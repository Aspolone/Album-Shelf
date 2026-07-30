package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.ArrayList;
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
        String filtroCliente = request.getParameter("cliente");
        String filtroDa = request.getParameter("da");
        String filtroA = request.getParameter("a");

        try (OrdineDAO dao = new OrdineDAO()) {
            Collection<Ordine> ordini;

            Integer idCliente = null;
            if (filtroCliente != null && !filtroCliente.isBlank()) {
                try {
                    idCliente = Integer.parseInt(filtroCliente.trim());
                } catch (NumberFormatException ignored) {}
            }

            Timestamp da = null;
            Timestamp a = null;
            if (filtroDa != null && !filtroDa.isBlank()) {
                da = Timestamp.valueOf(LocalDate.parse(filtroDa).atStartOfDay());
            }
            if (filtroA != null && !filtroA.isBlank()) {
                a = Timestamp.valueOf(LocalDate.parse(filtroA).plusDays(1).atStartOfDay());
            }

            boolean haFiltroStato = filtroStato != null && STATI_VALIDI.contains(filtroStato);

            if (idCliente != null || da != null || a != null || haFiltroStato) {
                ordini = dao.doRetrieveFiltrati(
                        haFiltroStato ? filtroStato : null,
                        idCliente, da, a);
                if (haFiltroStato) request.setAttribute("statoAttivo", filtroStato);
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

        String msg = null;

        try (OrdineDAO dao = new OrdineDAO()) {
            if ("annulla".equals(action)) {
                dao.doAnnulla(idOrdine);
                msg = "annullato";
            } else if ("stato".equals(action)) {
                String nuovoStato = request.getParameter("nuovoStato");
                if (!STATI_VALIDI.contains(nuovoStato)) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                dao.doUpdateStato(idOrdine, nuovoStato);
                msg = "stato_aggiornato";
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        StringBuilder redirect = new StringBuilder(request.getContextPath() + "/admin/ordini");
        List<String> params = new ArrayList<>();
        if (msg != null) params.add("msg=" + msg);

        String filtroStato = request.getParameter("stato");
        if (filtroStato != null && STATI_VALIDI.contains(filtroStato))
            params.add("stato=" + filtroStato);

        String cliente = request.getParameter("cliente");
        if (cliente != null && !cliente.isBlank()) params.add("cliente=" + cliente);

        String da = request.getParameter("da");
        if (da != null && !da.isBlank()) params.add("da=" + da);

        String a = request.getParameter("a");
        if (a != null && !a.isBlank()) params.add("a=" + a);

        if (!params.isEmpty()) redirect.append("?").append(String.join("&", params));

        response.sendRedirect(redirect.toString());
    }
}
