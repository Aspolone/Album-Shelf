package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

import com.albumshelf.mvc.model.bean.Esemplare;
import com.albumshelf.mvc.model.dao.EsemplareDAO;

@WebServlet(name = "Acquista", urlPatterns = { "/acquista" })
public class AcquistaServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (EsemplareDAO dao = new EsemplareDAO()) {

			// doRetrieveConFiltri(formato, condizioneDisco, prezzoMax)
			// formato null = tutti i formati
			Collection<Esemplare> tutti     = dao.doRetrieveConFiltri(null, null, null);
			Collection<Esemplare> vinili    = dao.doRetrieveConFiltri("vinile", null, null);
			Collection<Esemplare> cd        = dao.doRetrieveConFiltri("cd", null, null);
			Collection<Esemplare> cassette  = dao.doRetrieveConFiltri("cassetta", null, null);

			request.setAttribute("tutti", tutti);
			request.setAttribute("vinili", vinili);
			request.setAttribute("cd", cd);
			request.setAttribute("cassette", cassette);

		} catch (Exception e) {
			throw new ServletException(e);
		}

		request.getRequestDispatcher("/WEB-INF/view/transazioni/acquista.jsp").forward(request, response);
	}
}