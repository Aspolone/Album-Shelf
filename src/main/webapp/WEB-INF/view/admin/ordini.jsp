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
    String filtroCliente = request.getParameter("cliente");
    String filtroDa = request.getParameter("da");
    String filtroA = request.getParameter("a");
    String ctx = request.getContextPath();
    String messaggio = request.getParameter("msg");
%>

<div class="admin-shell">
    <%@ include file="/WEB-INF/view/admin/fragment/adminsidebar.jspf" %>

    <main class="admin-content">
        <h1 class="admin-titolo">Ordini</h1>

        <% if ("stato_aggiornato".equals(messaggio)) { %>
        <div class="admin-msg admin-msg--ok">Stato ordine aggiornato con successo.</div>
        <% } %>
        <% if ("annullato".equals(messaggio)) { %>
        <div class="admin-msg admin-msg--ok">Ordine annullato. Gli esemplari sono tornati disponibili.</div>
        <% } %>

        <div class="admin-filtri">
            <a href="${pageContext.request.contextPath}/admin/ordini"
               class="<%= statoAttivo == null && filtroCliente == null && filtroDa == null ? "attivo" : "" %>">Tutti</a>
            <% for (String s : statiValidi) { %>
                <a href="<%= ctx %>/admin/ordini?stato=<%= s %>"
                   class="<%= s.equals(statoAttivo) ? "attivo" : "" %>"><%= s %></a>
            <% } %>
        </div>

        <div class="admin-filtri-avanzati">
            <form action="${pageContext.request.contextPath}/admin/ordini" method="get" class="admin-filtro-form">
                <div class="admin-filtro-campo">
                    <label for="filtro-cliente">Cliente (ID)</label>
                    <input type="number" id="filtro-cliente" name="cliente" min="1"
                           value="<%= filtroCliente != null ? filtroCliente : "" %>"
                           placeholder="ID utente">
                </div>
                <div class="admin-filtro-campo">
                    <label for="filtro-da">Da</label>
                    <input type="date" id="filtro-da" name="da"
                           value="<%= filtroDa != null ? filtroDa : "" %>">
                </div>
                <div class="admin-filtro-campo">
                    <label for="filtro-a">A</label>
                    <input type="date" id="filtro-a" name="a"
                           value="<%= filtroA != null ? filtroA : "" %>">
                </div>
                <% if (statoAttivo != null) { %>
                <input type="hidden" name="stato" value="<%= statoAttivo %>">
                <% } %>
                <button class="admin-btn admin-btn--primario" type="submit">Filtra</button>
                <a href="${pageContext.request.contextPath}/admin/ordini" class="admin-btn admin-btn--secondario">Reset</a>
            </form>
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
                StringBuilder hiddenParams = new StringBuilder();
                if (statoAttivo != null)
                    hiddenParams.append("<input type=\"hidden\" name=\"stato\" value=\"" + statoAttivo + "\">");
                if (filtroCliente != null)
                    hiddenParams.append("<input type=\"hidden\" name=\"cliente\" value=\"" + filtroCliente + "\">");
                if (filtroDa != null)
                    hiddenParams.append("<input type=\"hidden\" name=\"da\" value=\"" + filtroDa + "\">");
                if (filtroA != null)
                    hiddenParams.append("<input type=\"hidden\" name=\"a\" value=\"" + filtroA + "\">");
                String hid = hiddenParams.toString();
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
                                <%= hid %>
                                <select name="nuovoStato" class="admin-select-inline">
                                    <% for (String s : statiValidi) { %>
                                        <option value="<%= s %>" <%= s.equals(stato) ? "selected" : "" %>><%= s %></option>
                                    <% } %>
                                </select>
                                <button class="admin-btn admin-btn--primario" type="submit">Salva</button>
                            </form>
                            <% if (!"annullato".equals(stato)) { %>
                            <button class="admin-btn admin-btn--pericolo" type="button"
                                    onclick="this.style.display='none'; document.getElementById('annulla-<%= o.getIdOrdine() %>').style.display='flex';">
                                Annulla
                            </button>
                            <div id="annulla-<%= o.getIdOrdine() %>" class="admin-conferma-inline" style="display:none;">
                                <span class="admin-conferma-testo">Annullare #<%= o.getIdOrdine() %>?</span>
                                <form action="<%= ctx %>/admin/ordini" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="annulla">
                                    <input type="hidden" name="idOrdine" value="<%= o.getIdOrdine() %>">
                                    <%= hid %>
                                    <button class="admin-btn admin-btn--pericolo" type="submit">Sì</button>
                                </form>
                                <button class="admin-btn admin-btn--secondario" type="button"
                                        onclick="this.parentElement.style.display='none'; this.parentElement.previousElementSibling.style.display='inline-block';">
                                    No
                                </button>
                            </div>
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
