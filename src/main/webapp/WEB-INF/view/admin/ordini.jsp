<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.albumshelf.mvc.model.bean.Ordine" %>
<% request.setAttribute("titoloPagina", "Admin - Ordini"); %>
<% request.setAttribute("sezioneAdmin", "ordini"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

<%
    Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
    List<String> statiValidi = (List<String>) request.getAttribute("statiValidi");
    String statoAttivo = (String) request.getAttribute("statoAttivo");
    String ctx = request.getContextPath();
%>

<div class="admin-shell">
    <%@ include file="/WEB-INF/view/admin/fragment/adminsidebar.jspf" %>

    <main class="admin-content">
        <h1 class="admin-titolo">Ordini</h1>

        <div class="admin-filtri">
            <a href="${pageContext.request.contextPath}/admin/ordini"
               class="<%= statoAttivo == null ? "attivo" : "" %>">Tutti</a>
            <% for (String s : statiValidi) { %>
                <a href="<%= ctx %>/admin/ordini?stato=<%= s %>"
                   class="<%= s.equals(statoAttivo) ? "attivo" : "" %>"><%= s %></a>
            <% } %>
        </div>

        <% if (ordini == null || ordini.isEmpty()) { %>
            <div class="admin-vuoto">Nessun ordine trovato.</div>
        <% } else { %>
        <div style="overflow-x:auto;">
        <table class="admin-tabella">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Data</th>
                    <th>Utente</th>
                    <th>Totale</th>
                    <th>Stato</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
            <% for (Ordine o : ordini) {
                String stato = o.getStatoOrdine();
                String hidStato = statoAttivo == null ? "" :
                    "<input type=\"hidden\" name=\"stato\" value=\"" + statoAttivo + "\">";
            %>
                <tr>
                    <td>#<%= o.getIdOrdine() %></td>
                    <td><%= o.getDataOrdine() %></td>
                    <td><%= o.getIdUtente() %></td>
                    <td>&euro; <%= o.getTotalePagato() %></td>
                    <td><span class="admin-badge admin-badge--<%= stato %>"><%= stato %></span></td>
                    <td>
                        <div class="admin-azioni">
                            <form action="<%= ctx %>/admin/ordini" method="post" style="display:flex; gap:4px;">
                                <input type="hidden" name="action" value="stato">
                                <input type="hidden" name="idOrdine" value="<%= o.getIdOrdine() %>">
                                <%= hidStato %>
                                <select name="nuovoStato" class="admin-select-inline">
                                    <% for (String s : statiValidi) { %>
                                        <option value="<%= s %>" <%= s.equals(stato) ? "selected" : "" %>><%= s %></option>
                                    <% } %>
                                </select>
                                <button class="admin-btn admin-btn--primario" type="submit">Salva</button>
                            </form>
                            <% if (!"annullato".equals(stato)) { %>
                            <form action="<%= ctx %>/admin/ordini" method="post"
                                  onsubmit="return confirm('Annullare l\'ordine #<%= o.getIdOrdine() %>? Gli esemplari torneranno disponibili.');">
                                <input type="hidden" name="action" value="annulla">
                                <input type="hidden" name="idOrdine" value="<%= o.getIdOrdine() %>">
                                <%= hidStato %>
                                <button class="admin-btn admin-btn--pericolo" type="submit">Annulla</button>
                            </form>
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
