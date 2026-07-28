<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover"></div>
            <div class="album-dati">
                <h1 class="album-titolo">Nome Gruppo</h1>
                <p class="album-dato">Anno di formazione:</p>
                <p class="album-dato">Paese:</p>
                <p class="album-dato">Genere:</p>
                <p class="album-dato">
                    Casa discografica:
                    <a href="${pageContext.request.contextPath}/musica/casadiscografica?id=1">Nome Etichetta</a>
                </p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Membri</h2>
            <ul class="elenco">
                <li>
                    <a href="${pageContext.request.contextPath}/musica/artista?id=1">
                        Nome Artista <span class="elenco__meta">Voce</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/musica/artista?id=2">
                        Nome Artista <span class="elenco__meta">Chitarra</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/musica/artista?id=3">
                        Nome Artista <span class="elenco__meta">Batteria</span>
                    </a>
                </li>
            </ul>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Discografia</h2>
            <ul class="elenco">
                <li>
                    <a href="${pageContext.request.contextPath}/musica/album?id=1">
                        Example Title <span class="elenco__meta">1998</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/musica/album?id=2">
                        Example Title <span class="elenco__meta">2001</span>
                    </a>
                </li>
            </ul>
        </section>

    </div>

    <aside class="recensioni">
        <div class="recensioni__pannello">
            <h2 class="nastro">Recensioni</h2>
            <article class="recensione">
                <p class="recensione__autore">
                    <a href="${pageContext.request.contextPath}/utente/profilo?id=1">Nome Utente</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9733;&#9733;</p>
                <p class="recensione__testo">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                    incididunt ut labore et dolore magna aliqua.
                </p>
            </article>
            <article class="recensione">
                <p class="recensione__autore">
                    <a href="${pageContext.request.contextPath}/utente/profilo?id=2">Nome Utente</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9733;&#9734;</p>
                <p class="recensione__testo">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                    incididunt ut labore et dolore magna aliqua.
                </p>
            </article>
        </div>
        <a class="recensioni__azione"
           href="${pageContext.request.contextPath}/utente/aggiungirecensione?album=1">Aggiungi recensione</a>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>