package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;

@WebServlet("/admin/utenti")
public class AdminUtentiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (UtenteDAO dao = new UtenteDAO()) {
            request.setAttribute("utenti", dao.doRetrieveAll("data_iscrizione"));
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/admin/utenti.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente sessione = (Utente) request.getSession().getAttribute("utente");
        String action = request.getParameter("action");
        int idUtente;
        try {
            idUtente = Integer.parseInt(request.getParameter("idUtente"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if (sessione != null && sessione.getIdUtente() == idUtente) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try (UtenteDAO dao = new UtenteDAO()) {
            Utente utente = dao.doRetrieveByKey(idUtente);
            if (utente == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            if ("ruolo".equals(action)) {
                String nuovoRuolo = request.getParameter("nuovoRuolo");
                if (!"cliente".equals(nuovoRuolo) && !"admin".equals(nuovoRuolo)) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                utente.setRuolo(nuovoRuolo);
                dao.doUpdate(utente);
            } else if ("elimina".equals(action)) {
                dao.doDelete(idUtente);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/admin/utenti");
    }
}
