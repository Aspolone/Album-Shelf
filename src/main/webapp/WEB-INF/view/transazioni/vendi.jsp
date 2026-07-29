<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="java.util.Collection" %>
<% request.setAttribute("titoloPagina", "Vendi"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css?v=2">

<%
    Collection<Album> albums = (Collection<Album>) request.getAttribute("albums");
    Album albumScelto = (Album) request.getAttribute("albumScelto");
    Collection<Edizione> edizioni = (Collection<Edizione>) request.getAttribute("edizioni");
    String errore = request.getParameter("errore");
    String successo = request.getParameter("successo");
%>

<main class="pagina-form">

    <h1 class="form__titolo">Metti in vendita</h1>

    <% if ("true".equals(successo)) { %>
    <p class="form__messaggio form__messaggio--ok">Esemplare messo in vendita con successo.</p>
    <% } %>
    <% if ("dati".equals(errore)) { %>
    <p class="form__messaggio form__messaggio--errore">Controlla i dati inseriti (prezzo e quantità).</p>
    <% } %>
    <% if ("formato".equals(errore)) { %>
    <p class="form__messaggio form__messaggio--errore">Formato non valido per prezzo o quantità.</p>
    <% } %>

    <%-- STEP 1: scegli album --%>
    <section class="form__sezione">
        <h2 class="form__sottotitolo">1. Scegli l'album</h2>
        <form action="${pageContext.request.contextPath}/vendi" method="get">
            <select name="album" class="form__select" required onchange="this.form.submit()">
                <option value="">-- Seleziona un album --</option>
                <% for (Album a : albums) { %>
                <option value="<%= a.getIdAlbum() %>"
                    <%= albumScelto != null && albumScelto.getIdAlbum() == a.getIdAlbum() ? "selected" : "" %>>
                    <%= a.getNomeAlbum() %> — <%= a.getNomeGruppo() %>
                </option>
                <% } %>
            </select>
        </form>
    </section>

    <% if (albumScelto != null && edizioni != null) { %>

    <%-- STEP 2: scegli edizione e compila i dettagli --%>
    <section class="form__sezione">
        <h2 class="form__sottotitolo">2. Dettagli della copia</h2>
        <form action="${pageContext.request.contextPath}/vendi" method="post">

            <label class="form__label">Edizione
                <select name="edizione" class="form__select" required>
                    <option value="">-- Seleziona un'edizione --</option>
                    <% for (Edizione ed : edizioni) { %>
                    <option value="<%= ed.getIdEdizione() %>">
                        <%= ed.getFormato() %> · <%= ed.getAnnoStampa() %>
                        <% if (ed.getEtichetta() != null) { %> · <%= ed.getEtichetta() %><% } %>
                        <% if (ed.getPaese() != null) { %> (<%= ed.getPaese() %>)<% } %>
                    </option>
                    <% } %>
                </select>
            </label>

            <label class="form__label">Prezzo (€)
                <input type="number" name="prezzo" class="form__input" step="0.01" min="0.01" required
                       placeholder="es. 25.00">
            </label>

            <label class="form__label">Condizione disco
                <select name="condizione_disco" class="form__select" required>
                    <option value="nuovo">Nuovo</option>
                    <option value="ottimo">Ottimo</option>
                    <option value="buono">Buono</option>
                    <option value="discreto">Discreto</option>
                    <option value="scarso">Scarso</option>
                </select>
            </label>

            <label class="form__label">Condizione confezione
                <select name="condizione_confezione" class="form__select" required>
                    <option value="nuovo">Nuovo</option>
                    <option value="ottimo">Ottimo</option>
                    <option value="buono">Buono</option>
                    <option value="discreto">Discreto</option>
                    <option value="scarso">Scarso</option>
                </select>
            </label>

            <label class="form__label form__label--checkbox">
                <input type="checkbox" name="impellicolato"> Impellicolato
            </label>

            <label class="form__label">Quantità (copie identiche)
                <input type="number" name="quantita" class="form__input" value="1" min="1" max="50" required>
            </label>

            <button type="submit" class="form__azione">Metti in vendita</button>
        </form>
    </section>

    <% } %>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
