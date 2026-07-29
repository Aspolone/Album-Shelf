package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Ordine;
import com.albumshelf.mvc.model.dao.OrdineDAO;

@WebServlet("/admin/ordini")
public class AdminOrdiniServlet extends HttpServlet {

    private static final List<String> STATI_VALIDI =
            Arrays.asList("confermato", "spedito", "consegnato", "annullato");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filtroStato = request.getParameter("stato");

        try (OrdineDAO dao = new OrdineDAO()) {
            Collection<Ordine> ordini;
            if (filtroStato != null && STATI_VALIDI.contains(filtroStato)) {
                ordini = dao.doRetrieveByStato(filtroStato);
                request.setAttribute("statoAttivo", filtroStato);
            } else {
                ordini = dao.doRetrieveAll("data");
            }
            request.setAttribute("ordini", ordini);
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("statiValidi", STATI_VALIDI);
        request.getRequestDispatcher("/WEB-INF/view/admin/ordini.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("idOrdine");

        int idOrdine;
        try {
            idOrdine = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try (OrdineDAO dao = new OrdineDAO()) {
            if ("annulla".equals(action)) {
                dao.doAnnulla(idOrdine);
            } else if ("stato".equals(action)) {
                String nuovoStato = request.getParameter("nuovoStato");
                if (!STATI_VALIDI.contains(nuovoStato)) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                dao.doUpdateStato(idOrdine, nuovoStato);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        String filtroStato = request.getParameter("stato");
        String redirect = request.getContextPath() + "/admin/ordini";
        if (filtroStato != null && STATI_VALIDI.contains(filtroStato)) {
            redirect += "?stato=" + filtroStato;
        }
        response.sendRedirect(redirect);
    }
}
