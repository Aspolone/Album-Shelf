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
import com.albumshelf.mvc.model.dao.AlbumDAO;

@WebServlet("/acquista")
public class acquista extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (AlbumDAO dao = new AlbumDAO()) {

            Collection<Album> piuAcquistati = dao.doRetrievePiuAcquistati(12);
            Collection<Album> vinili = dao.doRetrieveAcquistabili("vinile", 12);
            Collection<Album> classici = dao.doRetrieveMeglioRecensiti(12, 1);
            Collection<Album> cassette = dao.doRetrieveAcquistabili("cassetta", 12);
            Collection<Album> inArrivo = dao.doRetrieveUltimiUsciti(12);
            Collection<Album> cd = dao.doRetrieveAcquistabili("cd", 12);
            Collection<Album> tutti = dao.doRetrieveAcquistabili(null, 12);

            request.setAttribute("piuAcquistati", piuAcquistati);
            request.setAttribute("vinili", vinili);
            request.setAttribute("classici", classici);
            request.setAttribute("cassette", cassette);
            request.setAttribute("inArrivo", inArrivo);
            request.setAttribute("cd", cd);
            request.setAttribute("tutti", tutti);

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/transazioni/acquista.jsp")
               .forward(request, response);
    }
}