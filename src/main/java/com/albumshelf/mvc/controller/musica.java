package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "Musica", urlPatterns = {
    "/musica/album", "/musica/canzone", "/musica/artista",
    "/musica/gruppo", "/musica/casadiscografica"
})
public class musica extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        String vista = switch (request.getServletPath()) {
            case "/musica/album"            -> mostraAlbum(request, id);
            case "/musica/canzone"          -> mostraCanzone(request, id);
            case "/musica/artista"          -> mostraArtista(request, id);
            case "/musica/gruppo"           -> mostraGruppo(request, id);
            case "/musica/casadiscografica" -> mostraCasaDiscografica(request, id);
            default                         -> null;
        };

        if (vista == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.getRequestDispatcher(vista).forward(request, response);
    }
    
    private String mostraAlbum(HttpServletRequest request, String id) {
        return "/WEB-INF/view/musica/album.jsp";
    }
    
    private String mostraCanzone(HttpServletRequest request, String id) {
        return "/WEB-INF/view/musica/canzone.jsp";
    }
    
    private String mostraArtista(HttpServletRequest request, String id) {
        return "/WEB-INF/view/musica/artista.jsp";
    }
    
    private String mostraCasaDiscografica(HttpServletRequest request, String id) {
        return "/WEB-INF/view/musica/casadiscografica.jsp";
    }
    private String mostraGruppo(HttpServletRequest request, String id) {
        return "/WEB-INF/view/musica/gruppo.jsp";
    }
}