package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.albumshelf.mvc.model.bean.*;
import com.albumshelf.mvc.model.dao.EsemplareDAO;

@WebServlet(name = "Carrello", urlPatterns = {
	"/carrello", "/carrello/aggiungi", "/carrello/rimuovi", "/carrello/svuota"
})
public class CarrelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		mostraCarrello(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String azione = request.getServletPath();
		try {
			switch (azione) {
				case "/carrello/aggiungi" -> aggiungi(request);
				case "/carrello/rimuovi"  -> rimuovi(request);
				case "/carrello/svuota"   -> svuota(request);
				default -> { response.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}

		response.sendRedirect(request.getContextPath() + "/carrello");
	}

	private Carrello getCarrello(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		if (carrello == null) {
			carrello = new Carrello();
			session.setAttribute("carrello", carrello);
		}
		return carrello;
	}

	private void mostraCarrello(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Carrello carrello = getCarrello(request);
		request.setAttribute("carrello", carrello);
		request.getRequestDispatcher("/WEB-INF/view/transazioni/carrello.jsp").forward(request, response);
	}

	private void aggiungi(HttpServletRequest request) throws Exception {
		int idEsemplare = Integer.parseInt(request.getParameter("esemplare"));
		Carrello carrello = getCarrello(request);

		if (carrello.contiene(idEsemplare)) return;

		try (EsemplareDAO dao = new EsemplareDAO()) {

			if (!dao.isDisponibile(idEsemplare)) return;

			Esemplare e = dao.doRetrieveByKey(idEsemplare);
			if (e == null) return;

			RigaCarrello riga = new RigaCarrello();
			riga.setIdEsemplare(e.getIdEsemplare());
			riga.setNomeAlbum(e.getNomeAlbum());
			riga.setFileCopertina(e.getFileCopertina());
			riga.setFormato(e.getFormato());
			riga.setCondizioneDisco(e.getCondizioneDisco());
			riga.setNomeVenditore(e.getNomeVenditore());
			riga.setPrezzo(e.getPrezzo());

			carrello.aggiungi(riga);
		}
	}

	private void rimuovi(HttpServletRequest request) {
		int idEsemplare = Integer.parseInt(request.getParameter("esemplare"));
		getCarrello(request).rimuovi(idEsemplare);
	}

	private void svuota(HttpServletRequest request) {
		getCarrello(request).svuota();
	}
}