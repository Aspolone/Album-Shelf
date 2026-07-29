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

<<<<<<< HEAD
@WebFilter(urlPatterns = {
	"/vendi",
	"/carrello/checkout",
	"/modificaprofilo",
	"/aggiungirecensione"
=======
import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;

@WebFilter(filterName = "AuthFilter", urlPatterns = {
    "/vendi",
    "/modificaprofilo",
    "/carrello",
    "/carrello/checkout",
    "/aggiungirecensione",
    "/fattura",
    "/profilo",
    "/utente/*",
    "/admin",
    "/admin/*"
>>>>>>> 673e8d38b7820965a4dc337a2af8c3eba288985f
})
public class AuthFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		HttpSession session = request.getSession(false);
		boolean loggato = session != null && session.getAttribute("utente") != null;

		if (loggato) {
			chain.doFilter(request, response);
		} else {
			String urlOriginale = request.getRequestURI();
			String query = request.getQueryString();
			if (query != null) urlOriginale += "?" + query;
			request.getSession().setAttribute("redirectUrl", urlOriginale);

			response.sendRedirect(request.getContextPath() + "/auth");
		}
	}

	@Override
	public void destroy() {}
}