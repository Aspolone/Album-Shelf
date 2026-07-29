package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "PagineInfoServlet", urlPatterns = {"/about", "/transazioni/comevendere"})
public class PagineInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String vista = switch (request.getServletPath()) {
        case "/about"                   -> "/WEB-INF/view/about.jsp";
        case "/transazioni/comevendere" -> "/WEB-INF/view/transazioni/comevendere.jsp";
        default                         -> null;
    };

        if (vista == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.getRequestDispatcher(vista).forward(request, response);
    }
}