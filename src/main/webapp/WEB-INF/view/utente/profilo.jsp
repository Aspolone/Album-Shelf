<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/profilo.css">

<%
    Utente utenteProfilo = (Utente) request.getAttribute("utenteProfilo");
    Collection<Esemplare> esemplari = (Collection<Esemplare>) request.getAttribute("esemplari");
    Collection<Recensione> recensioni = (Collection<Recensione>) request.getAttribute("recensioni");
    Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
    boolean proprietario = Boolean.TRUE.equals(request.getAttribute("proprietario"));
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
%>

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="profilo-avatar">
                <img src="${pageContext.request.contextPath}/img/icons-customer.png"
                     alt="Avatar" class="profilo-avatar-img">
            </div>
            <div class="album-dati">
                <h1 class="album-titolo"><%= utenteProfilo.getNomeUtente() %></h1>
                <% if (utenteProfilo.getNazione() != null) { %>
                    <p class="album-dato">Nazione: <%= utenteProfilo.getNazione() %></p>
                <% } %>
                <p class="album-dato">Iscritto dal: <%= sdf.format(utenteProfilo.getDataIscrizione()) %></p>
                <p class="album-dato">
                    <span class="profilo-ruolo"><%= utenteProfilo.getRuolo() %></span>
                </p>
                <% if (utenteProfilo.getDescrizione() != null) { %>
                    <p class="album-testo"><%= utenteProfilo.getDescrizione() %></p>
                <% } %>
            </div>
        </section>

        <% if (proprietario) { %>
        <section class="profilo-azioni">
            <a href="${pageContext.request.contextPath}/modificaprofilo"
               class="album-azione">Modifica profilo</a>
            <a href="${pageContext.request.contextPath}/vendi"
               class="album-azione">Metti in vendita</a>
        </section>
        <% } %>

        <% if (esemplari != null && !esemplari.isEmpty()) { %>
        <section class="album-blocco">
            <h2 class="nastro">In vendita</h2>
            <ul class="copie">
                <% for (Esemplare e : esemplari) { %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/prodotto?id=<%= e.getIdEsemplare() %>">
                                <%= e.getNomeAlbum() %>
                            </a>
                        </p>
                        <p class="copia__edizione">
                            <%= e.getCondizioneDisco() %> &middot; <%= e.getFormato() %>
                        </p>
                    </div>
                    <p class="copia__prezzo"><%= e.getPrezzo() %> &euro;</p>
                    <span class="profilo-stato profilo-stato--<%= e.isDisponibile() ? "attivo" : "venduto" %>">
                        <%= e.isDisponibile() ? "Attivo" : "Venduto" %>
                    </span>
                </li>
                <% } %>
            </ul>
        </section>
        <% } %>

        <% if (proprietario && ordini != null && !ordini.isEmpty()) { %>
        <section class="album-blocco">
            <h2 class="nastro">I miei ordini</h2>
            <ul class="elenco">
                <% for (Ordine o : ordini) { %>
                <li>
                    <a href="${pageContext.request.contextPath}/utente/mioordine?id=<%= o.getIdOrdine() %>">
                        <div class="profilo-ordine-info">
                            <span class="profilo-ordine-id">Ordine #<%= o.getIdOrdine() %></span>
                            <span class="profilo-ordine-data"><%= sdf.format(o.getDataOrdine()) %></span>
                        </div>
                        <div class="profilo-ordine-destra">
                            <span class="profilo-stato profilo-stato--<%= o.getStatoOrdine() %>">
                                <%= o.getStatoOrdine() %>
                            </span>
                            <span class="elenco__meta"><%= o.getTotalePagato() %> &euro;</span>
                        </div>
                    </a>
                </li>
                <% } %>
            </ul>
        </section>
        <% } %>

    </div>

    <aside class="recensioni">
        <% if (recensioni != null && !recensioni.isEmpty()) { %>
        <div class="recensioni__pannello">
            <h2 class="nastro">Recensioni scritte</h2>
            <% for (Recensione r : recensioni) { %>
            <article class="recensione">
                <p class="recensione__autore">
                    <% if (r.getIdAlbum() != null) { %>
                        su <a href="${pageContext.request.contextPath}/musica/album?id=<%= r.getIdAlbum() %>">
                            <%= r.getNomeAlbum() != null ? r.getNomeAlbum() : "Album" %>
                        </a>
                    <% } else if (r.getIdCanzone() != null) { %>
                        su <a href="${pageContext.request.contextPath}/musica/canzone?id=<%= r.getIdCanzone() %>">
                            <%= r.getNomeCanzone() != null ? r.getNomeCanzone() : "Canzone" %>
                        </a>
                    <% } %>
                </p>
                <p class="recensione__voto">
                    <% for (int i = 0; i < r.getVoto().intValue(); i++) { %>&#9733;<% } %>
                    <% for (int i = r.getVoto().intValue(); i < 5; i++) { %>&#9734;<% } %>
                </p>
                <% if (r.getCommento() != null) { %>
                    <p class="recensione__testo"><%= r.getCommento() %></p>
                <% } %>
            </article>
            <% } %>
        </div>
        <% } %>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>