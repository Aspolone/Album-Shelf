package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import com.albumshelf.mvc.model.dao.AlbumDAO;
import com.albumshelf.mvc.model.dao.OrdineDAO;
import com.albumshelf.mvc.model.dao.RecensioneDAO;
import com.albumshelf.mvc.model.dao.UtenteDAO;

@WebServlet("/admin")
public class admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (AlbumDAO albumDAO = new AlbumDAO();
             OrdineDAO ordineDAO = new OrdineDAO();
             UtenteDAO utenteDAO = new UtenteDAO();
             RecensioneDAO recDAO = new RecensioneDAO()) {

            request.setAttribute("totAlbum",       albumDAO.doRetrieveAll(null).size());
            request.setAttribute("totOrdini",      ordineDAO.doRetrieveAll(null).size());
            request.setAttribute("totUtenti",      utenteDAO.doRetrieveAll(null).size());
            request.setAttribute("totRecensioni",  recDAO.doRetrieveAll(null).size());

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp")
               .forward(request, response);
    }
}
