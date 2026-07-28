package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "Profilo", urlPatterns = {"/modificaprofilo", "/profilo", " "})
public class utente extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        String vista = switch (request.getServletPath()) {
            case "/modificaprofilo"    -> mostraModificaProfilo(request, id);
            case "/profilo"            -> mostraProfilo(request, id);
            case "/aggiungirecensione" -> mostraAggiungiRecensione(request, id);
            default                    -> null;
        };

        if (vista == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.getRequestDispatcher(vista).forward(request, response);
    }

    private String mostraModificaProfilo(HttpServletRequest request, String id) {
        return "/WEB-INF/view/utente/modificaprofilo.jsp";
    }

    private String mostraProfilo(HttpServletRequest request, String id) {
        return "/WEB-INF/view/utente/profilo.jsp";
    }
    
    private String mostraAggiungiRecensione(HttpServletRequest request, String id) {
        return "/WEB-INF/view/utente/aggiungirecensione.jsp";
    }
    
}