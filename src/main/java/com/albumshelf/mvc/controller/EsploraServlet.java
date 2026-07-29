package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

import com.albumshelf.mvc.model.bean.Album;
import com.albumshelf.mvc.model.dao.AlbumDAO;

@WebServlet(name = "Esplora", urlPatterns = { "/esplora" })
public class EsploraServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (AlbumDAO dao = new AlbumDAO()) {

			Collection<Album> piuVisitati  = dao.doRetrievePiuVisitati(20);
			Collection<Album> piuVotati    = dao.doRetrieveMeglioRecensiti(20, 1);
			Collection<Album> ultimeUscite = dao.doRetrieveUltimiUsciti(20);

			request.setAttribute("piuVisitati", piuVisitati);
			request.setAttribute("piuVotati", piuVotati);
			request.setAttribute("ultimeUscite", ultimeUscite);

		} catch (Exception e) {
			throw new ServletException(e);
		}

		request.getRequestDispatcher("/WEB-INF/view/esplora.jsp").forward(request, response);
	}
}