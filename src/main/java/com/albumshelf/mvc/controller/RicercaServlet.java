package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.*;

@WebServlet(name = "Ricerca", urlPatterns = { "/ricerca" })
public class RicercaServlet extends HttpServlet {

	// numero massimo di risultati per tipo nella modalita' AJAX (dropdown
	// live): pochi, solo un'anteprima. la pagina di ricerca completa non ha
	// questo limite.
	private static final int LIMITE_SUGGERIMENTI_PER_TIPO = 5;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String testo = request.getParameter("q");
		boolean ajax = "true".equals(request.getParameter("ajax"));

		if (testo == null || testo.isBlank()) {
			if (ajax) {
				scriviJson(response, new ArrayList<>());
			} else {
				request.setAttribute("risultati", new ArrayList<RisultatoRicerca>());
				request.setAttribute("testoCercato", "");
				request.getRequestDispatcher("/WEB-INF/view/ricerca.jsp").forward(request, response);
			}
			return;
		}

		testo = testo.trim();
		int limite = ajax ? LIMITE_SUGGERIMENTI_PER_TIPO : Integer.MAX_VALUE;

		List<RisultatoRicerca> risultati;
		try {
			risultati = eseguiRicerca(testo, limite);
		} catch (Exception e) {
			throw new ServletException(e);
		}

		if (ajax) {
			scriviJson(response, risultati);
		} else {
			request.setAttribute("risultati", risultati);
			request.setAttribute("testoCercato", testo);
			request.getRequestDispatcher("/WEB-INF/view/ricerca.jsp").forward(request, response);
		}
	}

	private List<RisultatoRicerca> eseguiRicerca(String testo, int limitePerTipo) throws Exception {
		List<RisultatoRicerca> risultati = new ArrayList<>();

		try (AlbumDAO albumDAO = new AlbumDAO();
		     GruppoDAO gruppoDAO = new GruppoDAO();
		     CanzoneDAO canzoneDAO = new CanzoneDAO();
		     ComponenteDAO componenteDAO = new ComponenteDAO()) {

			int aggiunti = 0;
			for (Album a : albumDAO.doRetrieveByTesto(testo)) {
				if (aggiunti++ >= limitePerTipo) break;
				risultati.add(new RisultatoRicerca(
						"Album", a.getNomeAlbum(), a.getNomeGruppo(),
						"/musica/album?id=" + a.getIdAlbum()));
			}

			aggiunti = 0;
			for (Gruppo g : gruppoDAO.doRetrieveByNome(testo)) {
				if (aggiunti++ >= limitePerTipo) break;
				risultati.add(new RisultatoRicerca(
						"Gruppo", g.getNome(), g.getNazione(),
						"/musica/gruppo?id=" + g.getIdGruppo()));
			}

			aggiunti = 0;
			for (Canzone c : canzoneDAO.doRetrieveByTesto(testo)) {
				if (aggiunti++ >= limitePerTipo) break;
				risultati.add(new RisultatoRicerca(
						"Canzone", c.getNome(), c.getNomeAlbum(),
						"/musica/canzone?id=" + c.getIdCanzone()));
			}

			aggiunti = 0;
			for (Componente comp : componenteDAO.doRetrieveByNome(testo)) {
				if (aggiunti++ >= limitePerTipo) break;
				risultati.add(new RisultatoRicerca(
						"Artista", comp.getNome() + " " + comp.getCognome(), null,
						"/musica/artista?id=" + comp.getIdComponente()));
			}
		}

		return risultati;
	}

	private void scriviJson(HttpServletResponse response, List<RisultatoRicerca> risultati) throws IOException {
		response.setContentType("application/json;charset=UTF-8");

		StringBuilder json = new StringBuilder("[");
		for (int i = 0; i < risultati.size(); i++) {
			if (i > 0) json.append(",");
			RisultatoRicerca r = risultati.get(i);
			json.append("{")
				.append("\"tipo\":").append(escapeJson(r.getTipo())).append(",")
				.append("\"titolo\":").append(escapeJson(r.getTitolo())).append(",")
				.append("\"sottotitolo\":").append(escapeJson(r.getSottotitolo())).append(",")
				.append("\"url\":").append(escapeJson(r.getUrl()))
				.append("}");
		}
		json.append("]");

		try (PrintWriter out = response.getWriter()) {
			out.write(json.toString());
		}
	}

	private String escapeJson(String valore) {
		if (valore == null) return "null";
		String escapato = valore
				.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\n", "\\n")
				.replace("\r", "\\r");
		return "\"" + escapato + "\"";
	}
}