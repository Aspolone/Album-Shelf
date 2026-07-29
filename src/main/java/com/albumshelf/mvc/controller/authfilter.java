package com.albumshelf.mvc.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;

/**
 * Unica sentinella per l'accesso alle pagine protette.
 *
 * Regole:
 *  - URL sotto /admin* : richiedono utente loggato con ruolo 'admin' (ruolo riletto dal DB
 *    per non fidarsi della sessione che potrebbe essere vecchia).
 *  - /profilo          : richiede login SOLO per POST (GET e' pubblico con ?id=...).
 *  - Altri URL mappati : richiedono utente loggato, qualsiasi ruolo.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {
    "/vendi",
    "/modificaprofilo",
    "/carrello",
    "/aggiungirecensione",
    "/profilo",
    "/admin",
    "/admin/*"
})
public class authfilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getServletPath();
        String method = request.getMethod();
        boolean areaAdmin = path != null && (path.equals("/admin") || path.startsWith("/admin/"));
        boolean richiedeLogin = areaAdmin
                || !path.equals("/profilo")
                || "POST".equalsIgnoreCase(method);

        if (!richiedeLogin) {
            chain.doFilter(request, response);
            return;
        }

        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        if (areaAdmin) {
            try (UtenteDAO dao = new UtenteDAO()) {
                Utente fresco = dao.doRetrieveByKey(utente.getIdUtente());
                if (fresco == null) {
                    request.getSession().invalidate();
                    response.sendRedirect(request.getContextPath() + "/auth");
                    return;
                }
                if (!"admin".equals(fresco.getRuolo())) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                if (!fresco.getRuolo().equals(utente.getRuolo())) {
                    request.getSession().setAttribute("utente", fresco);
                }
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        }

        chain.doFilter(request, response);
    }
}
