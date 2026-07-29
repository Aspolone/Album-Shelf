<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/recensione.css">

<%
    String tipo = (String) request.getAttribute("tipo");
    Album album = (Album) request.getAttribute("album");
    Canzone canzone = (Canzone) request.getAttribute("canzone");

    String titolo = "";
    String idAlbumVal = "";
    String idCanzoneVal = "";
    String nomeGruppo = "";

    if ("album".equals(tipo) && album != null) {
        titolo = album.getNomeAlbum();
        idAlbumVal = String.valueOf(album.getIdAlbum());
        nomeGruppo = album.getNomeGruppo() != null ? album.getNomeGruppo() : "";
    } else if ("canzone".equals(tipo) && canzone != null) {
        titolo = canzone.getNome();
        idCanzoneVal = String.valueOf(canzone.getIdCanzone());
    }
%>

<main class="pagina">
    <div class="form-pagina">

        <div class="recensione-testata">
            <div class="recensione-cover"></div>
            <div class="recensione-info">
                <p class="info-eyebrow">Stai recensendo</p>
                <h1 class="recensione-titolo"><%= titolo %></h1>
                <% if (!nomeGruppo.isEmpty()) { %>
                    <p class="recensione-dato">Gruppo: <%= nomeGruppo %></p>
                <% } %>
                <% if ("canzone".equals(tipo) && canzone != null) { %>
                    <p class="recensione-dato">
                        Album:
                        <a href="${pageContext.request.contextPath}/musica/album?id=<%= canzone.getIdAlbum() %>">
                            <%= canzone.getNomeAlbum() %>
                        </a>
                    </p>
                <% } %>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/aggiungirecensione"
              method="post" class="form-vendi">

            <input type="hidden" name="idAlbum" value="<%= idAlbumVal %>">
            <input type="hidden" name="idCanzone" value="<%= idCanzoneVal %>">

            <fieldset class="form-sezione">
                <legend class="nastro">Valutazione</legend>
                <p class="form-sezione-intro">
                    Seleziona un voto da 1 a 5 stelle.
                </p>
                <div class="recensione-stelle">
                    <input type="radio" name="voto" id="stella5" value="5.0" required>
                    <label for="stella5" title="5 stelle">&#9733;</label>
                    <input type="radio" name="voto" id="stella4" value="4.0">
                    <label for="stella4" title="4 stelle">&#9733;</label>
                    <input type="radio" name="voto" id="stella3" value="3.0">
                    <label for="stella3" title="3 stelle">&#9733;</label>
                    <input type="radio" name="voto" id="stella2" value="2.0">
                    <label for="stella2" title="2 stelle">&#9733;</label>
                    <input type="radio" name="voto" id="stella1" value="1.0">
                    <label for="stella1" title="1 stella">&#9733;</label>
                </div>
            </fieldset>

            <fieldset class="form-sezione">
                <legend class="nastro">Commento</legend>
                <div class="form-campo-singolo">
                    <label for="commento">
                        Descrivi cosa ti è piaciuto o meno di questo disco.
                    </label>
                    <textarea id="commento" name="commento" rows="6"
                              placeholder="La produzione, il suono, i testi, le emozioni..."></textarea>
                </div>
            </fieldset>

            <button type="submit" class="form-submit">Pubblica recensione</button>

        </form>

    </div>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>