package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import com.albumshelf.mvc.model.bean.Album;
import com.albumshelf.mvc.model.bean.Gruppo;
import com.albumshelf.mvc.model.dao.AlbumDAO;
import com.albumshelf.mvc.model.dao.GruppoDAO;

@WebServlet("/esplora")
public class esplora extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (AlbumDAO albumDAO = new AlbumDAO();
             GruppoDAO gruppoDAO = new GruppoDAO()) {

            Collection<Album> piuVisitati = albumDAO.doRetrievePiuVisitati(12);
            Collection<Album> classici = albumDAO.doRetrieveMeglioRecensiti(12, 1);
            Collection<Album> inArrivo = albumDAO.doRetrieveUltimiUsciti(12);
            Collection<Gruppo> gruppi = gruppoDAO.doRetrievePiuVisitati(12);

            request.setAttribute("piuVisitati", piuVisitati);
            request.setAttribute("classici", classici);
            request.setAttribute("inArrivo", inArrivo);
            request.setAttribute("gruppi", gruppi);

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/esplora.jsp")
               .forward(request, response);
    }
}