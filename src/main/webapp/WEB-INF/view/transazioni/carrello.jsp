<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.List" %>
<% request.setAttribute("titoloPagina", "Carrello"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/carrello.css">

<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    List<RigaCarrello> righe = carrello != null ? carrello.getRighe() : java.util.Collections.emptyList();
%>

<main class="pagina-carrello">

    <div class="pagina-carrello__lista">

        <% if (righe.isEmpty()) { %>
        <p class="carrello-vuoto">Il carrello è vuoto.</p>
        <% } else { %>
            <% for (RigaCarrello riga : righe) { %>
        <article class="riga">
            <div class="riga__cover">
                <% if (riga.getFileCopertina() != null) { %>
                <img src="${pageContext.request.contextPath}/img/copertine/<%= riga.getFileCopertina() %>" alt="">
                <% } %>
            </div>
            <div class="riga__info">
                <h2 class="riga__titolo"><%= riga.getNomeAlbum() %></h2>
                <p class="riga__dato">Formato: <span class="valore-dato"><%= riga.getFormato() %></span></p>
                <p class="riga__dato">Condizioni: <span class="valore-dato"><%= riga.getCondizioneDisco() %></span></p>
                <p class="riga__dato">Venduto da: <span class="valore-dato"><%= riga.getNomeVenditore() %></span></p>
            </div>
            <p class="riga__prezzo"><%= FormatUtil.formatPrezzo(riga.getPrezzo()) %></p>
            <form action="${pageContext.request.contextPath}/carrello/rimuovi" method="post">
                <input type="hidden" name="esemplare" value="<%= riga.getIdEsemplare() %>">
                <button class="riga__elimina" type="submit" aria-label="Rimuovi dal carrello">
                    <img src="${pageContext.request.contextPath}/img/icons-trash.png" alt="">
                </button>
            </form>
        </article>
            <% } %>
        <% } %>

    </div>

    <aside class="riepilogo">
        <% if (!righe.isEmpty()) { %>
        <h2 class="riepilogo__totale">Totale <span class="riepilogo__cifra"><%= FormatUtil.formatPrezzo(carrello.getTotale()) %></span></h2>
        <ul class="riepilogo__voci">
            <% for (RigaCarrello riga : righe) { %>
            <li><%= riga.getNomeAlbum() %>: <%= FormatUtil.formatPrezzo(riga.getPrezzo()) %></li>
            <% } %>
        </ul>
        <form action="${pageContext.request.contextPath}/carrello/checkout" method="post">
            <button class="riepilogo__azione" type="submit">Procedi all'acquisto</button>
        </form>
        <form action="${pageContext.request.contextPath}/carrello/svuota" method="post">
            <button class="riepilogo__svuota" type="submit">Svuota carrello</button>
        </form>
        <% } else { %>
        <h2 class="riepilogo__totale">Totale <span class="riepilogo__cifra">0,00 &euro;</span></h2>
        <a class="riepilogo__azione" href="${pageContext.request.contextPath}/acquista">Vai al marketplace</a>
        <% } %>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
