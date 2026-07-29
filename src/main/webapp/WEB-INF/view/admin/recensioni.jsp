<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Recensione" %>
<% request.setAttribute("titoloPagina", "Admin - Recensioni"); %>
<% request.setAttribute("sezioneAdmin", "recensioni"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

<%
    Collection<Recensione> recensioni = (Collection<Recensione>) request.getAttribute("recensioni");
    String ctx = request.getContextPath();
%>

<div class="admin-shell">
    <%@ include file="/WEB-INF/view/admin/fragment/adminsidebar.jspf" %>

    <main class="admin-content">
        <h1 class="admin-titolo">Recensioni</h1>

        <% if (recensioni == null || recensioni.isEmpty()) { %>
            <div class="admin-vuoto">Nessuna recensione presente.</div>
        <% } else { %>
        <div style="overflow-x:auto;">
        <table class="admin-tabella">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Data</th>
                    <th>Utente</th>
                    <th>Target</th>
                    <th>Voto</th>
                    <th>Commento</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
            <% for (Recensione r : recensioni) {
                String target = r.getNomeAlbum() != null ? "Album: " + r.getNomeAlbum()
                              : (r.getNomeCanzone() != null ? "Canzone: " + r.getNomeCanzone() : "-");
                String commento = r.getCommento();
                if (commento != null && commento.length() > 200) commento = commento.substring(0, 200) + "...";
            %>
                <tr>
                    <td>#<%= r.getIdRecensione() %></td>
                    <td><%= r.getDataRecensione() %></td>
                    <td><%= r.getNomeUtente() %></td>
                    <td><%= target %></td>
                    <td>&#9733; <%= r.getVoto() %></td>
                    <td class="admin-commento"><%= commento == null ? "" : commento %></td>
                    <td>
                        <form action="<%= ctx %>/admin/recensioni" method="post"
                              onsubmit="return confirm('Eliminare la recensione #<%= r.getIdRecensione() %>?');">
                            <input type="hidden" name="idRecensione" value="<%= r.getIdRecensione() %>">
                            <button class="admin-btn admin-btn--pericolo" type="submit">Elimina</button>
                        </form>
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
