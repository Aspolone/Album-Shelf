package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;
import com.albumshelf.mvc.util.PasswordHashingUtil;

@WebServlet(name = "Auth", urlPatterns = { "/auth", "/auth/logout" })
public class AuthServlet extends HttpServlet {

    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[A-Za-z0-9_]{3,30}$");
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}$");
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d).{8,}$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("/auth/logout".equals(request.getServletPath())) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        if (request.getSession().getAttribute("utente") != null) {
            response.sendRedirect(request.getContextPath() + "/esplora");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/utente/auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("login".equals(action)) {
                login(request, response);
            } else if ("register".equals(action)) {
                registrati(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String input = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");

        if (input == null || input.isBlank() || password == null || password.isBlank()) {
            mostraErrore(request, response, "Compila tutti i campi.");
            return;
        }

        try (UtenteDAO dao = new UtenteDAO()) {
            Utente candidato = dao.doRetrieveByNomeUtenteOEmail(input.trim());

            if (candidato == null || !PasswordHashingUtil.verifica(password, candidato.getPassword())) {
                mostraErrore(request, response, "Nome utente/email o password non validi.");
                return;
            }

            request.getSession().setAttribute("utente", candidato);

            String redirectUrl = (String) request.getSession().getAttribute("redirectUrl");
            if (redirectUrl != null) {
                request.getSession().removeAttribute("redirectUrl");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }

    private void registrati(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String nomeUtente = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (nomeUtente == null || nomeUtente.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()) {
            mostraErrore(request, response, "Compila tutti i campi.");
            return;
        }

        if (!USERNAME_PATTERN.matcher(nomeUtente).matches()) {
            mostraErrore(request, response,
                    "Nome utente non valido: 3-30 caratteri, solo lettere, cifre e underscore.");
            return;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            mostraErrore(request, response, "Email non valida.");
            return;
        }

        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            mostraErrore(request, response,
                    "Password troppo debole: minimo 8 caratteri, almeno una lettera e una cifra.");
            return;
        }

        try (UtenteDAO dao = new UtenteDAO()) {
            if (dao.esisteNomeUtenteOEmail(nomeUtente.trim(), email.trim())) {
                mostraErrore(request, response, "Nome utente o email già in uso.");
                return;
            }

            Utente utente = new Utente();
            utente.setNomeUtente(nomeUtente.trim());
            utente.setEmail(email.trim());
            utente.setPassword(PasswordHashingUtil.hash(password));
            utente.setRuolo("cliente");

            dao.doSave(utente);

            Utente registrato = dao.doRetrieveByNomeUtenteOEmail(nomeUtente.trim());
            request.getSession().setAttribute("utente", registrato);
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void mostraErrore(HttpServletRequest request, HttpServletResponse response, String messaggio)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        request.getRequestDispatcher("/WEB-INF/view/utente/auth.jsp").forward(request, response);
    }
}