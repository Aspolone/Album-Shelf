<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("titoloPagina", "Carrello"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/carrello.css">


<main class="pagina-carrello">

    <div class="pagina-carrello__lista">

        <article class="riga">
            <div class="riga__cover"></div>
            <div class="riga__info">
                <h2 class="riga__titolo">
                    Title Example
                    <span class="riga__voto">4,8 <span class="riga__stella">&#9733;</span></span>
                </h2>
                <p class="riga__dato">Condizioni:</p>
                <p class="riga__dato">Venduto da:</p>
                <p class="riga__dato">Corriere:</p>
            </div>
            <p class="riga__prezzo">20,25 &euro;</p>
            <button class="riga__elimina" type="button" aria-label="Rimuovi dal carrello">
                <img src="${pageContext.request.contextPath}/img/icons-trash.png" alt="">
            </button>
        </article>

        <article class="riga">
            <div class="riga__cover"></div>
            <div class="riga__info">
                <h2 class="riga__titolo">
                    Title Example
                    <span class="riga__voto">4,8 <span class="riga__stella">&#9733;</span></span>
                </h2>
                <p class="riga__dato">Condizioni:</p>
                <p class="riga__dato">Venduto da:</p>
                <p class="riga__dato">Corriere:</p>
            </div>
            <p class="riga__prezzo">20,35 &euro;</p>
            <button class="riga__elimina" type="button" aria-label="Rimuovi dal carrello">
                <img src="${pageContext.request.contextPath}/img/icons-trash.png" alt="">
            </button>
        </article>

        <article class="riga">
            <div class="riga__cover"></div>
            <div class="riga__info">
                <h2 class="riga__titolo">
                    Title Example
                    <span class="riga__voto">4,8 <span class="riga__stella">&#9733;</span></span>
                </h2>
                <p class="riga__dato">Condizioni:</p>
                <p class="riga__dato">Venduto da:</p>
                <p class="riga__dato">Corriere:</p>
            </div>
            <p class="riga__prezzo">26,40 &euro;</p>
            <button class="riga__elimina" type="button" aria-label="Rimuovi dal carrello">
                <img src="${pageContext.request.contextPath}/img/icons-trash.png" alt="">
            </button>
        </article>

    </div>

    <aside class="riepilogo">
        <h2 class="riepilogo__totale">Totale <span class="riepilogo__cifra">104,67 &euro;</span></h2>
        <ul class="riepilogo__voci">
            <li>Album 1: 20,25 &euro;</li>
            <li>Album 2: 20,35 &euro;</li>
            <li>Album 3: 26,40 &euro;</li>
        </ul>
        <p class="riepilogo__spedizione">Spedizione: 37,67 &euro;</p>
        <a class="riepilogo__azione" href="${pageContext.request.contextPath}/transazioni/acquista">Procedi all'acquisto</a>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
