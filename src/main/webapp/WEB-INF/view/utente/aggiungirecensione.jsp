<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css?v=6">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/recensione.css?v=6">

<main class="pagina">
    <div class="form-pagina">

        <div class="recensione-testata">
            <div class="recensione-cover"></div>
            <div class="recensione-info">
                <p class="info-eyebrow">Stai recensendo</p>
                <h1 class="recensione-titolo">Example Title</h1>
                <p class="recensione-dato">
                    Gruppo:
                    <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                </p>
                <p class="recensione-dato">
                    Album:
                    <a href="${pageContext.request.contextPath}/musica/album?id=1">Nome Album</a>
                </p>
                <p class="recensione-dato">Anno: 1998</p>
                <p class="recensione-dato">Genere: Rock</p>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/aggiungirecensione"
              method="post" class="form-vendi">

            <input type="hidden" name="idAlbum" value="">
            <input type="hidden" name="idCanzone" value="">

            <fieldset class="form-sezione">
                <legend class="nastro">Valutazione</legend>
                <p class="form-sezione-intro">
                    Seleziona un voto da 1 a 5 stelle.
                </p>
                <div class="recensione-stelle">
                    <input type="radio" name="voto" id="stella5" value="5" required>
                    <label for="stella5" title="5 stelle">&#9733;</label>

                    <input type="radio" name="voto" id="stella4" value="4">
                    <label for="stella4" title="4 stelle">&#9733;</label>

                    <input type="radio" name="voto" id="stella3" value="3">
                    <label for="stella3" title="3 stelle">&#9733;</label>

                    <input type="radio" name="voto" id="stella2" value="2">
                    <label for="stella2" title="2 stelle">&#9733;</label>

                    <input type="radio" name="voto" id="stella1" value="1">
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