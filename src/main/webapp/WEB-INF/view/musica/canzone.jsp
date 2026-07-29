<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css">

<%
    Canzone canzone = (Canzone) request.getAttribute("canzone");
    Collection<String> generi = (Collection<String>) request.getAttribute("generi");
    Collection<Recensione> recensioni = (Collection<Recensione>) request.getAttribute("recensioni");
    Recensione recensioneUtente = (Recensione) request.getAttribute("recensioneUtente");
    Collection<Esemplare> copieInVendita = (Collection<Esemplare>) request.getAttribute("copieInVendita");
%>


<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-dati">
                <h1 class="album-titolo"><%= canzone.getNome() %></h1>
                <p class="album-dato">
                    Album:
                    <a class="valore-dato" href="${pageContext.request.contextPath}/musica/album?id=<%= canzone.getIdAlbum() %>">
                        <%= canzone.getNomeAlbum() %>
                    </a>
                </p>
                <p class="album-dato">
                    Durata: <span class="valore-dato"><%= FormatUtil.formatDurata(canzone.getDurata()) %></span>
                </p>
                <% if (generi != null && !generi.isEmpty()) { %>
                <p class="album-dato">
                    Genere:
                    <span class="valore-dato">
                    <%
                        boolean primo = true;
                        for (String genere : generi) {
                            if (!primo) { %>, <% }
                    %>
                    <%= genere %>
                    <% primo = false;
                        }
                    %>
                    </span>
                </p>
                <% } %>
                <% if (canzone.getMediaVoto() != null) { %>
                <p class="album-dato">
                    Voto medio: <span class="valore-dato"><%= FormatUtil.formatVotoBreve(canzone.getMediaVoto()) %></span>
                </p>
                <% } %>
            </div>
        </section>

        <section class="album-blocco canzone-acquista">
            <h2 class="nastro">
                Acquista &quot;<%= canzone.getNomeAlbum() %>&quot;
            </h2>
            <ul class="copie">
                <% for (Esemplare esemplare : copieInVendita) { %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione"><%= esemplare.getCondizioneDisco() %></p>
                        <p class="copia__edizione"><%= esemplare.getFormato() %></p>
                        <p class="copia__venditore">
                            Venduto da
                            <a href="${pageContext.request.contextPath}/utente/profilo?id=<%= esemplare.getIdUtente() %>">
                                <%= esemplare.getNomeVenditore() %>
                            </a>
                        </p>
                    </div>
                    <p class="copia__prezzo"><%= FormatUtil.formatPrezzo(esemplare.getPrezzo()) %></p>
                    <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                        <input type="hidden" name="esemplare" value="<%= esemplare.getIdEsemplare() %>">
                        <button class="copia__azione" type="submit">Aggiungi al carrello</button>
                    </form>
                </li>
                <% } %>
                <% if (copieInVendita.isEmpty()) { %>
                <li class="copia copia--vuota">Nessuna copia disponibile al momento.</li>
                <% } %>
            </ul>
            <a class="canzone-acquista__link-album"
               href="${pageContext.request.contextPath}/musica/album?id=<%= canzone.getIdAlbum() %>">
                Vai alla pagina dell'album completo &rarr;
            </a>
        </section>

        <% if (canzone.getTesto() != null && !canzone.getTesto().isEmpty()) { %>
        <section class="album-blocco">
            <h2 class="nastro">Testo</h2>
            <p class="album-testo"><%= canzone.getTesto() %></p>
        </section>
        <% } %>

    </div>

    <aside class="recensioni">
        <div class="recensioni__pannello">
            <h2 class="nastro">Recensioni</h2>
            <% for (Recensione recensione : recensioni) { %>
            <article class="recensione">
                <p class="recensione__autore">
                    <a href="${pageContext.request.contextPath}/utente/profilo?id=<%= recensione.getIdUtente() %>">
                        <%= recensione.getNomeUtente() %>
                    </a>
                </p>
                <p class="recensione__voto"><%= FormatUtil.formatVotoBreve(recensione.getVoto()) %> / 5</p>
                <p class="recensione__testo"><%= recensione.getCommento() %></p>
            </article>
            <% } %>
            <% if (recensioni.isEmpty()) { %>
            <p class="recensioni__vuoto">Ancora nessuna recensione per questa canzone.</p>
            <% } %>
        </div>
        <a class="recensioni__azione"
           href="${pageContext.request.contextPath}/aggiungirecensione?canzone=<%= canzone.getIdCanzone() %>">
            <%= recensioneUtente != null ? "Modifica la tua recensione" : "Aggiungi recensione" %>
        </a>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
