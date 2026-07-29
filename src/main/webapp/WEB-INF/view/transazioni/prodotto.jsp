<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/prodotto.css">

<%
    Esemplare esemplare = (Esemplare) request.getAttribute("esemplare");
    Album album = (Album) request.getAttribute("album");
    Edizione edizione = (Edizione) request.getAttribute("edizione");
    Collection<Canzone> tracklist = (Collection<Canzone>) request.getAttribute("tracklist");
    Utente venditore = (Utente) request.getAttribute("venditore");
%>

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover">
                <img src="${pageContext.request.contextPath}/img/copertine/<%= album.getFileCopertina() %>"
                     alt="Copertina di <%= album.getNomeAlbum() %>">
            </div>
            <div class="album-dati">
                <h1 class="album-titolo"><%= album.getNomeAlbum() %></h1>
                <p class="album-dato">
                    Gruppo:
                    <a class="valore-dato" href="${pageContext.request.contextPath}/musica/gruppo?id=<%= album.getIdGruppo() %>">
                        <%= album.getNomeGruppo() %>
                    </a>
                </p>
                <p class="album-dato">
                    Formato: <span class="valore-dato"><%= esemplare.getFormato() %></span>
                </p>
                <p class="album-dato">
                    Stato: <span class="valore-dato"><%= esemplare.isDisponibile() ? "Disponibile" : "Venduto" %></span>
                </p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Edizione</h2>
            <p class="album-dato">Anno di stampa: <span class="valore-dato"><%= edizione.getAnnoStampa() %></span></p>
            <p class="album-dato">Formato: <span class="valore-dato"><%= edizione.getFormato() %></span></p>
            <% if (edizione.getEtichetta() != null) { %>
            <p class="album-dato">Etichetta: <span class="valore-dato"><%= edizione.getEtichetta() %></span></p>
            <% } %>
            <% if (edizione.getPaese() != null) { %>
            <p class="album-dato">Paese: <span class="valore-dato"><%= edizione.getPaese() %></span></p>
            <% } %>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Condizioni</h2>
            <p class="album-dato">Disco: <span class="valore-dato"><%= esemplare.getCondizioneDisco() %></span></p>
            <p class="album-dato">Confezione: <span class="valore-dato"><%= esemplare.getCondizioneConfezione() %></span></p>
            <p class="album-dato">Impellicolato: <span class="valore-dato"><%= esemplare.isImpellicolato() ? "Sì" : "No" %></span></p>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Tracklist</h2>
            <ol class="tracklist">
                <%
                    int numero = 1;
                    for (Canzone canzone : tracklist) {
                %>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=<%= canzone.getIdCanzone() %>">
                        <span class="tracklist__num"><%= numero %></span>
                        <span class="tracklist__nome"><%= canzone.getNome() %></span>
                        <span class="tracklist__durata"><%= FormatUtil.formatDurata(canzone.getDurata()) %></span>
                    </a>
                </li>
                <%
                        numero++;
                    }
                %>
            </ol>
        </section>

    </div>

    <aside class="prodotto-acquisto">
        <div class="prodotto-acquisto__box">
            <p class="prodotto-acquisto__prezzo"><%= FormatUtil.formatPrezzo(esemplare.getPrezzo()) %></p>

            <% if (esemplare.isDisponibile()) { %>
            <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                <input type="hidden" name="esemplare" value="<%= esemplare.getIdEsemplare() %>">
                <button class="prodotto-acquisto__azione" type="submit">Aggiungi al carrello</button>
            </form>
            <% } else { %>
            <p class="prodotto-acquisto__venduto">Questa copia è stata venduta.</p>
            <% } %>
        </div>

        <div class="prodotto-venditore">
            <h2 class="nastro">Venditore</h2>
            <p class="album-dato">
                <a class="valore-dato" href="${pageContext.request.contextPath}/utente/profilo?id=<%= venditore.getIdUtente() %>">
                    <%= venditore.getNomeUtente() %>
                </a>
            </p>
            <% if (venditore.getNazione() != null) { %>
            <p class="album-dato">Nazione: <span class="valore-dato"><%= venditore.getNazione() %></span></p>
            <% } %>
            <p class="album-dato">
                Iscritto dal: <span class="valore-dato"><%= FormatUtil.formatData(venditore.getDataIscrizione()) %></span>
            </p>
        </div>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
