package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collection;

import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.*;

@WebServlet(name = "Vendi", urlPatterns = { "/vendi" })
public class VendiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Utente utente = (Utente) request.getSession().getAttribute("utente");
		if (utente == null) {
			response.sendRedirect(request.getContextPath() + "/auth");
			return;
		}

		try (AlbumDAO albumDAO = new AlbumDAO()) {

			Collection<Album> albums = albumDAO.doRetrieveAll("nome");
			request.setAttribute("albums", albums);

			String albumParam = request.getParameter("album");
			if (albumParam != null && !albumParam.isBlank()) {
				int idAlbum = Integer.parseInt(albumParam);
				Album albumScelto = albumDAO.doRetrieveByKey(idAlbum);
				request.setAttribute("albumScelto", albumScelto);

				try (EdizioneDAO edizioneDAO = new EdizioneDAO()) {
					Collection<Edizione> edizioni = edizioneDAO.doRetrieveByAlbum(idAlbum);
					request.setAttribute("edizioni", edizioni);
				}
			}

		} catch (Exception e) {
			throw new ServletException(e);
		}

		request.getRequestDispatcher("/WEB-INF/view/transazioni/vendi.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Utente utente = (Utente) request.getSession().getAttribute("utente");
		if (utente == null) {
			response.sendRedirect(request.getContextPath() + "/auth");
			return;
		}

		try {
			int idEdizione = Integer.parseInt(request.getParameter("edizione"));
			BigDecimal prezzo = new BigDecimal(request.getParameter("prezzo"));
			String condizioneDisco = request.getParameter("condizione_disco");
			String condizioneConfezione = request.getParameter("condizione_confezione");
			boolean impellicolato = "on".equals(request.getParameter("impellicolato"));
			int quantita = Integer.parseInt(request.getParameter("quantita"));

			if (prezzo.compareTo(BigDecimal.ZERO) <= 0 || quantita < 1 || quantita > 50) {
				response.sendRedirect(request.getContextPath() + "/vendi?errore=dati");
				return;
			}

			Esemplare esemplare = new Esemplare();
			esemplare.setIdEdizione(idEdizione);
			esemplare.setIdUtente(utente.getIdUtente());
			esemplare.setPrezzo(prezzo);
			esemplare.setCondizioneDisco(condizioneDisco);
			esemplare.setCondizioneConfezione(condizioneConfezione);
			esemplare.setImpellicolato(impellicolato);

			try (EsemplareDAO dao = new EsemplareDAO()) {
				if (quantita == 1) {
					dao.doSave(esemplare);
				} else {
					dao.doSaveMultiplo(esemplare, quantita);
				}
			}

			response.sendRedirect(request.getContextPath() + "/vendi?successo=true");

		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/vendi?errore=formato");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}