package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import com.albumshelf.mvc.util.PasswordHashingUtil;
import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.*;

@WebServlet(name = "Utente", urlPatterns = {"/profilo", "/modificaprofilo", "/aggiungirecensione"})
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
        String azione = request.getParameter("azione");

        try {
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
                              Utente utenteLoggato) throws SQLException, IOException {

        String nomeUtente = request.getParameter("nomeUtente");
        String email = request.getParameter("email");
        String nazione = request.getParameter("nazione");
        String descrizione = request.getParameter("descrizione");

        utenteLoggato.setNomeUtente(nomeUtente);
        utenteLoggato.setEmail(email);
        utenteLoggato.setNazione(nazione);
        utenteLoggato.setDescrizione(descrizione);

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

    private void eliminaAccount(HttpServletRequest request, HttpServletResponse response,
                                 Utente utenteLoggato) throws SQLException, IOException {

        try (UtenteDAO dao = new UtenteDAO()) {
            dao.doDelete(utenteLoggato.getIdUtente());
        }

        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/");
    }
}