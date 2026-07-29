package com.albumshelf.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

import com.albumshelf.mvc.model.bean.Utente;
import com.albumshelf.mvc.model.dao.UtenteDAO;
import com.albumshelf.mvc.util.PasswordHashingUtil;

@WebServlet("/auth")
public class auth extends HttpServlet {

    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[A-Za-z0-9_]{3,30}$");
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}$");
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d).{8,}$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("utente") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/utente/auth.jsp")
               .forward(request, response);
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
                register(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/auth");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");

        if (usernameOrEmail == null || usernameOrEmail.isBlank()
                || password == null || password.isBlank()) {
            errore(request, response, "Compila tutti i campi.");
            return;
        }

        Utente utente;
        try (UtenteDAO dao = new UtenteDAO()) {
            utente = dao.doRetrieveByNomeUtenteOEmail(usernameOrEmail);
        }

        if (utente == null || !PasswordHashingUtil.verifica(password, utente.getPassword())) {
            errore(request, response, "Credenziali non valide.");
            return;
        }

        request.getSession().setAttribute("utente", utente);
        response.sendRedirect(request.getContextPath() + "/");
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || username.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()) {
            errore(request, response, "Compila tutti i campi.");
            return;
        }

        if (!USERNAME_PATTERN.matcher(username).matches()) {
            errore(request, response,
                    "Nome utente non valido: 3-30 caratteri, solo lettere, cifre e underscore.");
            return;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            errore(request, response, "Email non valida.");
            return;
        }

        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            errore(request, response,
                    "Password troppo debole: minimo 8 caratteri, almeno una lettera e una cifra.");
            return;
        }

        try (UtenteDAO dao = new UtenteDAO()) {
            if (dao.esisteNomeUtenteOEmail(username, email)) {
                errore(request, response, "Username o email già in uso.");
                return;
            }

            Utente utente = new Utente();
            utente.setNomeUtente(username);
            utente.setEmail(email);
            utente.setPassword(PasswordHashingUtil.hash(password));
            utente.setRuolo("cliente");

            long id = dao.doSave(utente);
            utente.setIdUtente((int) id);

            request.getSession().setAttribute("utente", utente);
        }

        response.sendRedirect(request.getContextPath() + "/");
    }

    private void errore(HttpServletRequest request, HttpServletResponse response,
                        String messaggio) throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        request.getRequestDispatcher("/WEB-INF/view/utente/auth.jsp")
               .forward(request, response);
    }
}