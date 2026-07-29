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

@WebServlet(name = "Musica", urlPatterns = {
	"/musica/album", "/musica/canzone", "/musica/artista",
	"/musica/gruppo", "/musica/casadiscografica"
})
public class MusicaServlet extends HttpServlet {

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

		String vista;
		try {
			vista = switch (request.getServletPath()) {
				case "/musica/album"            -> mostraAlbum(request, id);
				case "/musica/canzone"          -> mostraCanzone(request, id);
				case "/musica/artista"          -> mostraArtista(request, id);
				case "/musica/gruppo"           -> mostraGruppo(request, id);
				case "/musica/casadiscografica" -> mostraCasaDiscografica(request, id);
				default                         -> null;
			};
		} catch (Exception e) {
			throw new ServletException(e);
		}

		if (vista == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		request.getRequestDispatcher(vista).forward(request, response);
	}

	private String mostraAlbum(HttpServletRequest request, int id) throws Exception {

		try (AlbumDAO albumDAO = new AlbumDAO();
		     CanzoneDAO canzoneDAO = new CanzoneDAO();
		     EdizioneDAO edizioneDAO = new EdizioneDAO();
		     EsemplareDAO esemplareDAO = new EsemplareDAO();
		     RecensioneDAO recensioneDAO = new RecensioneDAO()) {

			Album album = albumDAO.doRetrieveDettaglio(id);
			if (album == null) return null;

			albumDAO.incrementaVisite(id);

			Collection<String> generi = albumDAO.doRetrieveGeneri(id);
			Collection<Canzone> tracklist = canzoneDAO.doRetrieveByAlbum(id);
			int durataTotale = canzoneDAO.getDurataTotaleAlbum(id);
			Collection<Edizione> edizioni = edizioneDAO.doRetrieveAcquistabiliByAlbum(id);
			Collection<Esemplare> copieInVendita = esemplareDAO.doRetrieveDisponibiliByAlbum(id);
			Collection<Recensione> recensioni = recensioneDAO.doRetrieveByAlbum(id);
			int[] distribuzioneVoti = recensioneDAO.getDistribuzioneVotiAlbum(id);

			Utente utente = (Utente) request.getSession().getAttribute("utente");
			Recensione recensioneUtente = null;
			if (utente != null) {
				recensioneUtente = recensioneDAO.doRetrieveByUtenteEAlbum(
						utente.getIdUtente(), id);
			}

			request.setAttribute("album", album);
			request.setAttribute("generi", generi);
			request.setAttribute("tracklist", tracklist);
			request.setAttribute("durataTotale", durataTotale);
			request.setAttribute("edizioni", edizioni);
			request.setAttribute("copieInVendita", copieInVendita);
			request.setAttribute("recensioni", recensioni);
			request.setAttribute("distribuzioneVoti", distribuzioneVoti);
			request.setAttribute("recensioneUtente", recensioneUtente);
		}

		return "/WEB-INF/view/musica/album.jsp";
	}

	private String mostraCanzone(HttpServletRequest request, int id) throws Exception {

		try (CanzoneDAO canzoneDAO = new CanzoneDAO();
		     RecensioneDAO recensioneDAO = new RecensioneDAO();
		     EsemplareDAO esemplareDAO = new EsemplareDAO()) {

			Canzone canzone = canzoneDAO.doRetrieveDettaglio(id);
			if (canzone == null) return null;

			canzoneDAO.incrementaVisite(id);

			Collection<String> generi = canzoneDAO.doRetrieveGeneri(id);
			Collection<Recensione> recensioni = recensioneDAO.doRetrieveByCanzone(id);

			Collection<Esemplare> copieInVendita = esemplareDAO.doRetrieveDisponibiliByAlbum(canzone.getIdAlbum());

			Utente utente = (Utente) request.getSession().getAttribute("utente");
			Recensione recensioneUtente = null;
			if (utente != null) {
				recensioneUtente = recensioneDAO.doRetrieveByUtenteECanzone(
						utente.getIdUtente(), id);
			}

			request.setAttribute("canzone", canzone);
			request.setAttribute("generi", generi);
			request.setAttribute("recensioni", recensioni);
			request.setAttribute("copieInVendita", copieInVendita);
			request.setAttribute("recensioneUtente", recensioneUtente);
		}

		return "/WEB-INF/view/musica/canzone.jsp";
	}

	private String mostraArtista(HttpServletRequest request, int id) throws Exception {

		try (ComponenteDAO componenteDAO = new ComponenteDAO();
		     GruppoDAO gruppoDAO = new GruppoDAO()) {

			Componente artista = componenteDAO.doRetrieveByKey(id);
			if (artista == null) return null;

			Collection<Composizione> gruppi = gruppoDAO.doRetrieveGruppiDiComponente(id);

			request.setAttribute("artista", artista);
			request.setAttribute("gruppi", gruppi);
		}

		return "/WEB-INF/view/musica/artista.jsp";
	}

	private String mostraGruppo(HttpServletRequest request, int id) throws Exception {

		try (GruppoDAO gruppoDAO = new GruppoDAO();
		     AlbumDAO albumDAO = new AlbumDAO()) {

			Gruppo gruppo = gruppoDAO.doRetrieveByKey(id);
			if (gruppo == null) return null;

			gruppoDAO.incrementaVisite(id);

			Collection<Composizione> formazioneAttuale = gruppoDAO.doRetrieveFormazioneAttuale(id);
			Collection<Composizione> formazioneStorica = gruppoDAO.doRetrieveFormazione(id);
			Collection<NomeGruppo> nomiStorici = gruppoDAO.doRetrieveNomiStorici(id);
			Collection<Album> discografia = albumDAO.doRetrieveByGruppo(id);

			request.setAttribute("gruppo", gruppo);
			request.setAttribute("formazioneAttuale", formazioneAttuale);
			request.setAttribute("formazioneStorica", formazioneStorica);
			request.setAttribute("nomiStorici", nomiStorici);
			request.setAttribute("discografia", discografia);
		}

		return "/WEB-INF/view/musica/gruppo.jsp";
	}

	private String mostraCasaDiscografica(HttpServletRequest request, int id) throws Exception {

		try (CasaDiscograficaDAO casaDAO = new CasaDiscograficaDAO();
		     AlbumDAO albumDAO = new AlbumDAO()) {

			CasaDiscografica casa = casaDAO.doRetrieveByKey(id);
			if (casa == null) return null;

			Collection<Album> catalogo = albumDAO.doRetrieveByCasaDiscografica(id);

			request.setAttribute("casaDiscografica", casa);
			request.setAttribute("catalogo", catalogo);
		}

		return "/WEB-INF/view/musica/casadiscografica.jsp";
	}
}