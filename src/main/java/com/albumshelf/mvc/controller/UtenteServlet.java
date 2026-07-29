package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import com.albumshelf.mvc.model.bean.RigaOrdine;

import com.albumshelf.mvc.util.PasswordHashingUtil;
import java.math.BigDecimal;

import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.*;

@WebServlet(name = "Utente", urlPatterns = {"/profilo", "/modificaprofilo", "/aggiungirecensione", "/fattura"})
public class UtenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try {
            String vista = switch (request.getServletPath()) {
                case "/profilo"            -> mostraProfilo(request, id);
                case "/modificaprofilo"    -> mostraModificaProfilo(request);
                case "/aggiungirecensione" -> mostraAggiungiRecensione(request);
                case "/fattura"            -> mostraFattura(request);
                default                    -> null;
            };

            if (vista == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            request.getRequestDispatcher(vista).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private String mostraProfilo(HttpServletRequest request, String id) throws SQLException {
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("utente");
        int idProfilo;

        if (id != null && !id.isBlank()) {
            idProfilo = Integer.parseInt(id);
        } else if (utenteLoggato != null) {
            idProfilo = utenteLoggato.getIdUtente();
        } else {
            return null;
        }

        try (UtenteDAO utenteDAO = new UtenteDAO()) {
            Utente utenteProfilo = utenteDAO.doRetrieveByKey(idProfilo);
            if (utenteProfilo == null) return null;
            request.setAttribute("utenteProfilo", utenteProfilo);
        }

        try (EsemplareDAO esemplareDAO = new EsemplareDAO()) {
            Collection<Esemplare> esemplari = esemplareDAO.doRetrieveByVenditore(idProfilo);
            request.setAttribute("esemplari", esemplari);
        }

        try (RecensioneDAO recensioneDAO = new RecensioneDAO()) {
            Collection<Recensione> recensioni = recensioneDAO.doRetrieveByUtente(idProfilo);
            request.setAttribute("recensioni", recensioni);
        }

        boolean proprietario = utenteLoggato != null
                && utenteLoggato.getIdUtente() == idProfilo;
        request.setAttribute("proprietario", proprietario);

        if (proprietario) {
            try (OrdineDAO ordineDAO = new OrdineDAO()) {
                Collection<Ordine> ordini = ordineDAO.doRetrieveByUtente(idProfilo);
                request.setAttribute("ordini", ordini);
            }
        }

        return "/WEB-INF/view/utente/profilo.jsp";
    }

    private String mostraModificaProfilo(HttpServletRequest request) {
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("utente");
        request.setAttribute("utenteProfilo", utenteLoggato);
        return "/WEB-INF/view/utente/modificaprofilo.jsp";
    }

    private String mostraFattura(HttpServletRequest request) throws SQLException {
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("utente");
        String idOrdineStr = request.getParameter("ordine");
        if (idOrdineStr == null || idOrdineStr.isBlank()) return null;

        int idOrdine = Integer.parseInt(idOrdineStr);

        try (OrdineDAO ordineDAO = new OrdineDAO()) {
            Ordine ordine = ordineDAO.doRetrieveByKey(idOrdine);
            if (ordine == null || ordine.getIdUtente() != utenteLoggato.getIdUtente()) return null;

            Collection<RigaOrdine> righe = ordineDAO.doRetrieveRighe(idOrdine);
            request.setAttribute("ordine", ordine);
            request.setAttribute("righeOrdine", righe);
            request.setAttribute("utenteProfilo", utenteLoggato);
        }

        return "/WEB-INF/view/utente/fattura.jsp";
    }

    private String mostraAggiungiRecensione(HttpServletRequest request) throws SQLException {
        String idAlbumStr = request.getParameter("album");
        String idCanzoneStr = request.getParameter("canzone");

        if (idAlbumStr != null && !idAlbumStr.isBlank()) {
            try (AlbumDAO dao = new AlbumDAO()) {
                Album album = dao.doRetrieveDettaglio(Integer.parseInt(idAlbumStr));
                request.setAttribute("album", album);
                request.setAttribute("tipo", "album");
            }
        } else if (idCanzoneStr != null && !idCanzoneStr.isBlank()) {
            try (CanzoneDAO dao = new CanzoneDAO()) {
                Canzone canzone = dao.doRetrieveDettaglio(Integer.parseInt(idCanzoneStr));
                request.setAttribute("canzone", canzone);
                request.setAttribute("tipo", "canzone");
            }
        } else {
            return null;
        }

        return "/WEB-INF/view/utente/aggiungirecensione.jsp";
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("utente");

        try {
            if ("/aggiungirecensione".equals(request.getServletPath())) {
                salvaRecensione(request, response, utenteLoggato);
                return;
            }

            String azione = request.getParameter("azione");
            if ("cambiapassword".equals(azione)) {
                cambiaPassword(request, response, utenteLoggato);
            } else if ("elimina".equals(azione)) {
                eliminaAccount(request, response, utenteLoggato);
            } else {
                salvaProfilo(request, response, utenteLoggato);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void salvaProfilo(HttpServletRequest request, HttpServletResponse response,
                              Utente utenteLoggato) throws SQLException, ServletException, IOException {

        String nomeUtente = request.getParameter("nomeUtente");
        String email = request.getParameter("email");
        String nazione = request.getParameter("nazione");
        String descrizione = request.getParameter("descrizione");

        if (nomeUtente == null || nomeUtente.isBlank()
                || email == null || email.isBlank()) {
            request.setAttribute("utenteProfilo", utenteLoggato);
            request.setAttribute("errorMessage", "Nome utente e email sono obbligatori.");
            request.getRequestDispatcher("/WEB-INF/view/utente/modificaprofilo.jsp")
                   .forward(request, response);
            return;
        }

        utenteLoggato.setNomeUtente(nomeUtente.trim());
        utenteLoggato.setEmail(email.trim());
        utenteLoggato.setNazione(nazione != null && !nazione.isBlank() ? nazione.trim() : null);
        utenteLoggato.setDescrizione(descrizione != null && !descrizione.isBlank() ? descrizione.trim() : null);

        try (UtenteDAO dao = new UtenteDAO()) {
            dao.doUpdate(utenteLoggato);
        }

        request.getSession().setAttribute("utente", utenteLoggato);
        response.sendRedirect(request.getContextPath() + "/profilo");
    }

    private void cambiaPassword(HttpServletRequest request, HttpServletResponse response,
                                 Utente utenteLoggato) throws SQLException, ServletException, IOException {

        String passwordAttuale = request.getParameter("passwordAttuale");
        String nuovaPassword = request.getParameter("nuovaPassword");
        String confermaPassword = request.getParameter("confermaPassword");

        if (!PasswordHashingUtil.verifica(passwordAttuale, utenteLoggato.getPassword())) {
            request.setAttribute("utenteProfilo", utenteLoggato);
            request.setAttribute("errorMessage", "Password attuale errata.");
            request.getRequestDispatcher("/WEB-INF/view/utente/modificaprofilo.jsp")
                   .forward(request, response);
            return;
        }

        if (!nuovaPassword.equals(confermaPassword)) {
            request.setAttribute("utenteProfilo", utenteLoggato);
            request.setAttribute("errorMessage", "Le password non coincidono.");
            request.getRequestDispatcher("/WEB-INF/view/utente/modificaprofilo.jsp")
                   .forward(request, response);
            return;
        }

        String nuovoHash = PasswordHashingUtil.hash(nuovaPassword);

        try (UtenteDAO dao = new UtenteDAO()) {
            dao.doUpdatePassword(utenteLoggato.getIdUtente(), nuovoHash);
        }

        utenteLoggato.setPassword(nuovoHash);
        request.getSession().setAttribute("utente", utenteLoggato);
        response.sendRedirect(request.getContextPath() + "/profilo");
    }

    private void salvaRecensione(HttpServletRequest request, HttpServletResponse response,
                                  Utente utenteLoggato) throws SQLException, IOException {

        String votoStr = request.getParameter("voto");
        String commento = request.getParameter("commento");
        String idAlbumStr = request.getParameter("idAlbum");
        String idCanzoneStr = request.getParameter("idCanzone");

        if (votoStr == null || votoStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        Recensione recensione = new Recensione();
        recensione.setVoto(new BigDecimal(votoStr));
        recensione.setCommento(commento != null && !commento.isBlank() ? commento.trim() : null);
        recensione.setIdUtente(utenteLoggato.getIdUtente());

        if (idAlbumStr != null && !idAlbumStr.isBlank()) {
            recensione.setIdAlbum(Integer.parseInt(idAlbumStr));
        }
        if (idCanzoneStr != null && !idCanzoneStr.isBlank()) {
            recensione.setIdCanzone(Integer.parseInt(idCanzoneStr));
        }

        try (RecensioneDAO dao = new RecensioneDAO()) {
            dao.doSave(recensione);
        }

        if (recensione.getIdAlbum() != null) {
            response.sendRedirect(request.getContextPath()
                    + "/musica/album?id=" + recensione.getIdAlbum());
        } else if (recensione.getIdCanzone() != null) {
            response.sendRedirect(request.getContextPath()
                    + "/musica/canzone?id=" + recensione.getIdCanzone());
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void eliminaAccount(HttpServletRequest request, HttpServletResponse response,
                                 Utente utenteLoggato) throws SQLException, IOException {

        try (UtenteDAO dao = new UtenteDAO()) {
            dao.doDelete(utenteLoggato.getIdUtente());
        }

        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/");
    }
}