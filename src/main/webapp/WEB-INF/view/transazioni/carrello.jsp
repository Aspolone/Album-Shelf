<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<% request.setAttribute("titoloPagina", "Carrello"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/carrello.css">


<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    List<RigaCarrello> righe = carrello != null ? carrello.getRighe() : java.util.Collections.emptyList();
    String errore = request.getParameter("errore");
    String successo = request.getParameter("successo");
%>

<main class="pagina-carrello">

<div class="pagina-carrello__lista">

    <% if ("ordine".equals(successo)) { %>
    <div class="carrello-msg carrello-msg--ok">Ordine effettuato con successo!</div>
    <% } %>
    <% if ("svuotato".equals(successo)) { %>
    <div class="carrello-msg carrello-msg--ok">Carrello svuotato.</div>
    <% } %>
    <% if ("vuoto".equals(errore)) { %>
    <div class="carrello-msg carrello-msg--errore">Il carrello è vuoto, non puoi procedere.</div>
    <% } %>
    <% if ("nondisponibile".equals(errore)) { %>
    <div class="carrello-msg carrello-msg--errore">Una copia nel carrello non è più disponibile. È stata rimossa.</div>
    <% } %>

    <% if (righe == null || righe.isEmpty()) { %>
        <p class="pagina-carrello__vuoto">Il carrello è vuoto.</p>
    <% } else { %>
        <% for (RigaCarrello riga : righe) { %>
        <article class="riga">
            <div class="riga__cover">
                <% if (riga.getFileCopertina() != null && !riga.getFileCopertina().isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/img/copertine/<%= riga.getFileCopertina() %>" alt="<%= riga.getNomeAlbum() %>">
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
        <% if (!righe.isEmpty()) {
            BigDecimal subtotale = carrello.getTotale();
            BigDecimal aliquota = new BigDecimal("22.00");
            BigDecimal iva = subtotale.multiply(aliquota).divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
            BigDecimal totaleIva = subtotale.add(iva);
        %>
        <ul class="riepilogo__voci">
            <% for (RigaCarrello riga : righe) { %>
            <li><%= riga.getNomeAlbum() %>: <%= FormatUtil.formatPrezzo(riga.getPrezzo()) %></li>
            <% } %>
        </ul>
        <p class="riepilogo__riga">Subtotale <span class="riepilogo__cifra"><%= FormatUtil.formatPrezzo(subtotale) %></span></p>
        <p class="riepilogo__riga">IVA 22% <span class="riepilogo__cifra"><%= FormatUtil.formatPrezzo(iva) %></span></p>
        <h2 class="riepilogo__totale">Totale <span class="riepilogo__cifra"><%= FormatUtil.formatPrezzo(totaleIva) %></span></h2>

        <div id="conferma-checkout" class="carrello-conferma" style="display:none;">
            <p class="carrello-conferma__testo">Confermi l'ordine di <strong><%= FormatUtil.formatPrezzo(totaleIva) %></strong>?</p>
            <form action="${pageContext.request.contextPath}/carrello/checkout" method="post" style="display:inline;">
                <button class="riepilogo__azione" type="submit">Conferma ordine</button>
            </form>
            <button class="riepilogo__svuota" type="button" onclick="document.getElementById('conferma-checkout').style.display='none';">Annulla</button>
        </div>

        <button class="riepilogo__azione" type="button" id="btn-checkout"
                onclick="document.getElementById('conferma-checkout').style.display='block'; this.style.display='none';">
            Procedi all'acquisto
        </button>

        <div id="conferma-svuota" class="carrello-conferma" style="display:none;">
            <p class="carrello-conferma__testo">Vuoi davvero svuotare il carrello?</p>
            <form action="${pageContext.request.contextPath}/carrello/svuota" method="post" style="display:inline;">
                <button class="riepilogo__svuota" type="submit" style="border-color:#f15f99;">Sì, svuota</button>
            </form>
            <button class="riepilogo__svuota" type="button" onclick="document.getElementById('conferma-svuota').style.display='none'; document.getElementById('btn-svuota').style.display='block';">Annulla</button>
        </div>

        <button class="riepilogo__svuota" type="button" id="btn-svuota"
                onclick="document.getElementById('conferma-svuota').style.display='block'; this.style.display='none';">
            Svuota carrello
        </button>

        <% } else { %>
        <h2 class="riepilogo__totale">Totale <span class="riepilogo__cifra">0,00 &euro;</span></h2>
        <a class="riepilogo__azione" href="${pageContext.request.contextPath}/acquista">Vai al marketplace</a>
        <% } %>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
