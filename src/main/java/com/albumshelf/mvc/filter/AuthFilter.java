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

// protegge le pagine che richiedono login. se l'utente non e' loggato,
// salva l'URL richiesto in sessione (redirectUrl) e lo manda a /auth.
// dopo il login, AuthServlet lo ridirige automaticamente dove voleva andare.
@WebFilter(urlPatterns = {
	"/vendi",
	"/carrello/checkout",
	"/utente/*"
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
			// salva l'URL originale per il redirect post-login
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