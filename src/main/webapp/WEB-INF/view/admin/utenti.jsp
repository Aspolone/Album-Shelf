<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Utente" %>
<% request.setAttribute("titoloPagina", "Admin - Utenti"); %>
<% request.setAttribute("sezioneAdmin", "utenti"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

<%
    Collection<Utente> utenti = (Collection<Utente>) request.getAttribute("utenti");
    Utente sessione = (Utente) session.getAttribute("utente");
    String ctx = request.getContextPath();
%>

<div class="admin-shell">
    <%@ include file="/WEB-INF/view/admin/fragment/adminsidebar.jspf" %>

    <main class="admin-content">
        <h1 class="admin-titolo">Utenti</h1>

        <% if (utenti == null || utenti.isEmpty()) { %>
            <div class="admin-vuoto">Nessun utente registrato.</div>
        <% } else { %>
        <div style="overflow-x:auto;">
        <table class="admin-tabella">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome utente</th>
                    <th>Email</th>
                    <th>Iscritto il</th>
                    <th>Ruolo</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
            <% for (Utente u : utenti) {
                boolean isSelf = sessione != null && sessione.getIdUtente() == u.getIdUtente();
                String ruolo = u.getRuolo();
                String ruoloOpposto = "admin".equals(ruolo) ? "cliente" : "admin";
            %>
                <tr>
                    <td>#<%= u.getIdUtente() %></td>
                    <td><%= u.getNomeUtente() %><% if (isSelf) { %> <em style="color:#738494;">(tu)</em><% } %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getDataIscrizione() %></td>
                    <td><span class="admin-badge admin-badge--<%= ruolo %>"><%= ruolo %></span></td>
                    <td>
                        <div class="admin-azioni">
                            <% if (!isSelf) { %>
                                <form action="<%= ctx %>/admin/utenti" method="post">
                                    <input type="hidden" name="action" value="ruolo">
                                    <input type="hidden" name="idUtente" value="<%= u.getIdUtente() %>">
                                    <input type="hidden" name="nuovoRuolo" value="<%= ruoloOpposto %>">
                                    <button class="admin-btn admin-btn--secondario" type="submit">-> <%= ruoloOpposto %></button>
                                </form>
                                <button class="admin-btn admin-btn--pericolo" type="button"
                                        onclick="this.style.display='none'; document.getElementById('del-user-<%= u.getIdUtente() %>').style.display='flex';">
                                    Elimina
                                </button>
                                <div id="del-user-<%= u.getIdUtente() %>" class="admin-conferma-inline" style="display:none;">
                                    <span class="admin-conferma-testo">Eliminare <%= u.getNomeUtente() %>?</span>
                                    <form action="<%= ctx %>/admin/utenti" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="elimina">
                                        <input type="hidden" name="idUtente" value="<%= u.getIdUtente() %>">
                                        <button class="admin-btn admin-btn--pericolo" type="submit">Sì</button>
                                    </form>
                                    <button class="admin-btn admin-btn--secondario" type="button"
                                            onclick="this.parentElement.style.display='none'; this.parentElement.previousElementSibling.style.display='inline-block';">
                                        No
                                    </button>
                                </div>
                            <% } else { %>
                                <em style="color:#738494; font-size:0.75rem;">non modificabile</em>
                            <% } %>
                        </div>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <% } %>
    </main>
</div>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
