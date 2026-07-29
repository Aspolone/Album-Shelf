package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.*;


@WebServlet(name = "Prodotto", urlPatterns = { "/prodotto" })
public class ProdottoServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idParam = request.getParameter("id");
		if (idParam == null || idParam.isBlank()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		int id;
		try {
			id = Integer.parseInt(idParam);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		try (EsemplareDAO esemplareDAO = new EsemplareDAO();
		     AlbumDAO albumDAO = new AlbumDAO();
		     EdizioneDAO edizioneDAO = new EdizioneDAO();
		     CanzoneDAO canzoneDAO = new CanzoneDAO();
		     UtenteDAO utenteDAO = new UtenteDAO()) {

			Esemplare esemplare = esemplareDAO.doRetrieveByKey(id);
			if (esemplare == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}

			// l'album a cui appartiene questa copia: copre copertina, gruppo,
			// casa discografica, descrizione in un colpo solo
			Album album = albumDAO.doRetrieveDettaglio(esemplare.getIdAlbum());
			Edizione edizione = edizioneDAO.doRetrieveByKey(esemplare.getIdEdizione());
			Collection<Canzone> tracklist = canzoneDAO.doRetrieveByAlbum(esemplare.getIdAlbum());
			Utente venditore = utenteDAO.doRetrieveByKey(esemplare.getIdUtente());

			request.setAttribute("esemplare", esemplare);
			request.setAttribute("album", album);
			request.setAttribute("edizione", edizione);
			request.setAttribute("tracklist", tracklist);
			request.setAttribute("venditore", venditore);

		} catch (Exception e) {
			throw new ServletException(e);
		}

		request.getRequestDispatcher("/WEB-INF/view/transazioni/prodotto.jsp").forward(request, response);
	}
}