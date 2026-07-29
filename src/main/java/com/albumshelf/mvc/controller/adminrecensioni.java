package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import com.albumshelf.mvc.model.dao.RecensioneDAO;

@WebServlet("/admin/recensioni")
public class adminrecensioni extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (RecensioneDAO dao = new RecensioneDAO()) {
            request.setAttribute("recensioni", dao.doRetrieveAll("data"));
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/admin/recensioni.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idRecensione;
        try {
            idRecensione = Integer.parseInt(request.getParameter("idRecensione"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try (RecensioneDAO dao = new RecensioneDAO()) {
            dao.doDelete(idRecensione);
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/admin/recensioni");
    }
}
