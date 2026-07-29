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

@WebServlet(urlPatterns = {"", "/home"})
public class home extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (AlbumDAO dao = new AlbumDAO()) {

            Collection<Album> miglioriSettimana = dao.doRetrievePiuVisitati(7);
            Collection<Album> miglioriAnno = dao.doRetrieveMeglioRecensiti(7, 1);
            Collection<Album> piuRecensiti = dao.doRetrieveUltimiUsciti(7);

            request.setAttribute("miglioriSettimana", miglioriSettimana);
            request.setAttribute("miglioriAnno", miglioriAnno);
            request.setAttribute("piuRecensiti", piuRecensiti);

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/index.jsp")
               .forward(request, response);
    }
}