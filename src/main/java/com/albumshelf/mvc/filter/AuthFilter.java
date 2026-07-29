package com.albumshelf.mvc.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;

@WebFilter(filterName = "AuthFilter", urlPatterns = {
    "/vendi",
    "/modificaprofilo",
    "/carrello",
    "/carrello/checkout",
    "/aggiungirecensione",
    "/profilo",
    "/utente/*",
    "/admin",
    "/admin/*"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getServletPath();
        boolean areaAdmin = path != null && (path.equals("/admin") || path.startsWith("/admin/"));

        HttpSession session = request.getSession(false);
        Utente utente = session != null ? (Utente) session.getAttribute("utente") : null;

        if (utente == null) {
            String urlOriginale = request.getRequestURI();
            String query = request.getQueryString();
            if (query != null) urlOriginale += "?" + query;
            request.getSession().setAttribute("redirectUrl", urlOriginale);
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

    @Override
    public void destroy() {}
}