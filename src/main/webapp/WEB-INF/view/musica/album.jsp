<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">

<%
    Album album = (Album) request.getAttribute("album");
    Collection<String> generi = (Collection<String>) request.getAttribute("generi");
    Collection<Canzone> tracklist = (Collection<Canzone>) request.getAttribute("tracklist");
    Collection<Esemplare> copieInVendita = (Collection<Esemplare>) request.getAttribute("copieInVendita");
    Collection<Recensione> recensioni = (Collection<Recensione>) request.getAttribute("recensioni");
    Recensione recensioneUtente = (Recensione) request.getAttribute("recensioneUtente");
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
                    <a href="${pageContext.request.contextPath}/musica/gruppo?id=<%= album.getIdGruppo() %>">
                        <%= album.getNomeGruppo() %>
                    </a>
                </p>
                <p class="album-dato">
                    Data incisione:
                    <%= FormatUtil.formatData(album.getDataInizioRegistrazione()) %>
                    <% if (album.getDataFineRegistrazione() != null) { %>
                        &ndash; <%= FormatUtil.formatData(album.getDataFineRegistrazione()) %>
                    <% } %>
                </p>
                <p class="album-dato">Data rilascio: <%= FormatUtil.formatData(album.getDataRilascio()) %></p>
                <p class="album-dato">
                    Genere:
                    <%
                        boolean primo = true;
                        for (String genere : generi) {
                            if (!primo) { %>, <% }
                    %>
                    <%= genere %>
                    <% primo = false;
                        }
                    %>
                </p>
                <p class="album-dato">Descrizione: <%= album.getDescrittori() %></p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Acquista</h2>
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

        <section class="album-blocco">
            <h2 class="nastro">Casa discografica</h2>
            <p class="album-dato">
                <a href="${pageContext.request.contextPath}/musica/casadiscografica?id=<%= album.getIdCasaDiscografica() %>">
                    <%= album.getNomeCasaDiscografica() %>
                </a>
            </p>
        </section>

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
            <p class="recensioni__vuoto">Ancora nessuna recensione per questo album.</p>
            <% } %>
        </div>
        <a class="recensioni__azione"
           href="${pageContext.request.contextPath}/utente/<%= recensioneUtente != null ? "modificarecensione" : "aggiungirecensione" %>?album=<%= album.getIdAlbum() %>">
            <%= recensioneUtente != null ? "Modifica la tua recensione" : "Aggiungi recensione" %>
        </a>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
