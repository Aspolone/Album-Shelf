<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css">

<%
    Gruppo gruppo = (Gruppo) request.getAttribute("gruppo");
    Collection<Composizione> formazioneAttuale = (Collection<Composizione>) request.getAttribute("formazioneAttuale");
    Collection<Composizione> formazioneStorica = (Collection<Composizione>) request.getAttribute("formazioneStorica");
    Collection<NomeGruppo> nomiStorici = (Collection<NomeGruppo>) request.getAttribute("nomiStorici");
    Collection<Album> discografia = (Collection<Album>) request.getAttribute("discografia");
%>

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <% if (gruppo.getFileImmagine() != null && !gruppo.getFileImmagine().isEmpty()) { %>
            <div class="album-cover">
                <img src="${pageContext.request.contextPath}/img/gruppi/<%= gruppo.getFileImmagine() %>"
                     alt="<%= gruppo.getNome() %>">
            </div>
            <% } %>
            <div class="album-dati">
                <h1 class="album-titolo"><%= gruppo.getNome() %></h1>
                <p class="album-dato">
                    Nazione: <span class="valore-dato"><%= gruppo.getNazione() != null ? gruppo.getNazione() : "" %></span>
                </p>
                <p class="album-dato">
                    Fondazione: <span class="valore-dato"><%= FormatUtil.formatData(gruppo.getDataCreazione()) %></span>
                </p>
                <% if (gruppo.getDataScioglimento() != null) { %>
                <p class="album-dato">
                    Scioglimento: <span class="valore-dato"><%= FormatUtil.formatData(gruppo.getDataScioglimento()) %></span>
                </p>
                <% } %>
            </div>
        </section>

        <% if (nomiStorici != null && !nomiStorici.isEmpty()) { %>
        <section class="album-blocco">
            <h2 class="nastro">Nomi precedenti</h2>
            <ul class="copie">
                <% for (NomeGruppo nome : nomiStorici) { %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione"><%= nome.getNome() %></p>
                        <p class="copia__venditore">
                            <%= FormatUtil.formatData(nome.getDataInizio()) %>
                            &ndash;
                            <%= FormatUtil.formatData(nome.getDataFine()) %>
                        </p>
                    </div>
                </li>
                <% } %>
            </ul>
        </section>
        <% } %>

        <section class="album-blocco">
            <h2 class="nastro">Formazione attuale</h2>
            <% if (formazioneAttuale.isEmpty()) { %>
            <p class="album-dato">Nessun membro attivo.</p>
            <% } else { %>
            <ul class="copie">
                <% for (Composizione comp : formazioneAttuale) { %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/musica/artista?id=<%= comp.getIdComponente() %>">
                                <%= comp.getNomeComponente() %> <%= comp.getCognomeComponente() %>
                            </a>
                        </p>
                        <p class="copia__edizione">
                            <%= comp.getRuolo() != null ? comp.getRuolo() : "" %>
                        </p>
                        <p class="copia__venditore">
                            Dal <%= FormatUtil.formatData(comp.getDataIngresso()) %>
                            <%
                                if (comp.getDataMorteComponente() != null) {
                            %>
                                al <%= FormatUtil.formatData(comp.getDataMorteComponente()) %>
                            <% } else { %>
                                &ndash; presente
                            <% } %>
                        </p>
                    </div>
                </li>
                <% } %>
            </ul>
            <% } %>
        </section>

        <% if (formazioneStorica.size() > formazioneAttuale.size()) { %>
        <section class="album-blocco">
            <h2 class="nastro">Formazione storica</h2>
            <ul class="copie">
                <%
                    for (Composizione comp : formazioneStorica) {
                        // "storica" = chi non fa piu' parte del gruppo: o e' uscito
                        // formalmente, o e' deceduto senza essere mai uscito.
                        // chi non ha ne' l'uno ne' l'altro e' ancora un membro attuale,
                        // gia' mostrato sopra: va saltato qui per non duplicarlo.
                        boolean uscito = comp.getDataUscita() != null;
                        boolean decedutoSenzaUscita = comp.getDataUscita() == null
                                && comp.getDataMorteComponente() != null;
                        if (!uscito && !decedutoSenzaUscita) continue;
                %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/musica/artista?id=<%= comp.getIdComponente() %>">
                                <%= comp.getNomeComponente() %> <%= comp.getCognomeComponente() %>
                            </a>
                        </p>
                        <p class="copia__edizione">
                            <%= comp.getRuolo() != null ? comp.getRuolo() : "" %>
                        </p>
                        <p class="copia__venditore">
                            <%= FormatUtil.formatData(comp.getDataIngresso()) %>
                            &ndash;
                            <%= FormatUtil.formatData(uscito ? comp.getDataUscita() : comp.getDataMorteComponente()) %>
                        </p>
                    </div>
                </li>
                <% } %>
            </ul>
        </section>
        <% } %>

        <section class="album-blocco">
            <h2 class="nastro">Discografia</h2>
            <% if (discografia.isEmpty()) { %>
            <p class="album-dato">Nessun album registrato.</p>
            <% } else { %>
            <ol class="tracklist">
                <%
                    int numero = 1;
                    for (Album album : discografia) {
                %>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/album?id=<%= album.getIdAlbum() %>">
                        <span class="tracklist__num"><%= numero %></span>
                        <span class="tracklist__nome"><%= album.getNomeAlbum() %></span>
                        <span class="tracklist__durata">
                            <%= album.getDataRilascio() != null ? FormatUtil.formatData(album.getDataRilascio()) : "" %>
                        </span>
                    </a>
                </li>
                <%
                        numero++;
                    }
                %>
            </ol>
            <% } %>
        </section>

    </div>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
