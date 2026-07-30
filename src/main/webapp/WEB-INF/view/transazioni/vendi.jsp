<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="java.util.Collection" %>
<% request.setAttribute("titoloPagina", "Vendi"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">

<%
    Collection<Album> albums = (Collection<Album>) request.getAttribute("albums");
    Album albumScelto = (Album) request.getAttribute("albumScelto");
    Collection<Edizione> edizioni = (Collection<Edizione>) request.getAttribute("edizioni");
    String errore = request.getParameter("errore");
    String successo = request.getParameter("successo");
%>

<main class="pagina">
    <div class="form-pagina">

        <header class="info-header">
            <h1>Metti in vendita</h1>
            <p class="info-lead">
                Seleziona l'album e l'edizione del disco che vuoi vendere,
                poi descrivi le condizioni del tuo esemplare.
            </p>
        </header>

        <% if ("true".equals(successo)) { %>
        <p class="form-messaggio form-messaggio--ok">Esemplare messo in vendita con successo.</p>
        <% } %>
        <% if ("dati".equals(errore)) { %>
        <p class="form-messaggio form-messaggio--errore">Controlla i dati inseriti (prezzo e quantit&agrave;).</p>
        <% } %>
        <% if ("formato".equals(errore)) { %>
        <p class="form-messaggio form-messaggio--errore">Formato non valido per prezzo o quantit&agrave;.</p>
        <% } %>

        <section class="form-sezione">
            <h2 class="nastro">1. Scegli l'album</h2>
            <form action="${pageContext.request.contextPath}/vendi" method="get">
                <div class="form-griglia">
                    <div class="form-campo form-campo--intero">
                        <label for="album">Album *</label>
                        <select id="album" name="album" required onchange="this.form.submit()">
                            <option value="">-- Seleziona un album --</option>
                            <% for (Album a : albums) { %>
                            <option value="<%= a.getIdAlbum() %>"
                                <%= albumScelto != null && albumScelto.getIdAlbum() == a.getIdAlbum() ? "selected" : "" %>>
                                <%= a.getNomeAlbum() %> — <%= a.getNomeGruppo() %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                </div>
            </form>
        </section>

        <% if (albumScelto != null && edizioni != null) { %>

        <section class="form-sezione">
            <h2 class="nastro">2. Dettagli della copia</h2>
            <form action="${pageContext.request.contextPath}/vendi" method="post" class="form-vendi">

                <div class="form-griglia">

                    <div class="form-campo form-campo--intero">
                        <label for="edizione">Edizione *</label>
                        <select id="edizione" name="edizione" required>
                            <option value="">-- Seleziona un'edizione --</option>
                            <% for (Edizione ed : edizioni) { %>
                            <option value="<%= ed.getIdEdizione() %>">
                                <%= ed.getFormato() %> · <%= ed.getAnnoStampa() %>
                                <% if (ed.getEtichetta() != null) { %> · <%= ed.getEtichetta() %><% } %>
                                <% if (ed.getPaese() != null) { %> (<%= ed.getPaese() %>)<% } %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-campo">
                        <label for="prezzo">Prezzo (&euro;) *</label>
                        <input type="number" id="prezzo" name="prezzo" step="0.01" min="0.01" required
                               placeholder="es. 25.00">
                    </div>

                    <div class="form-campo">
                        <label for="quantita">Quantit&agrave; (copie identiche) *</label>
                        <input type="number" id="quantita" name="quantita" value="1" min="1" max="50" required>
                    </div>

                    <div class="form-campo">
                        <label for="condizione_disco">Condizione disco *</label>
                        <select id="condizione_disco" name="condizione_disco" required>
                            <option value="nuovo">Nuovo</option>
                            <option value="ottimo">Ottimo</option>
                            <option value="buono">Buono</option>
                            <option value="discreto">Discreto</option>
                            <option value="scarso">Scarso</option>
                        </select>
                    </div>

                    <div class="form-campo">
                        <label for="condizione_confezione">Condizione confezione *</label>
                        <select id="condizione_confezione" name="condizione_confezione" required>
                            <option value="nuovo">Nuovo</option>
                            <option value="ottimo">Ottimo</option>
                            <option value="buono">Buono</option>
                            <option value="discreto">Discreto</option>
                            <option value="scarso">Scarso</option>
                        </select>
                    </div>

                    <div class="form-campo form-campo--intero">
                        <label class="form-checkbox">
                            <input type="checkbox" name="impellicolato">
                            <span>Impellicolato</span>
                        </label>
                    </div>

                </div>

                <button type="submit" class="form-submit">Metti in vendita</button>
            </form>
        </section>

        <% } %>

    </div>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
