<% request.setAttribute("titoloPagina", "Esplora"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/esplora.css?v=6">

<main class="esplora">

    <h1 class="esplora__titolo">Esplora</h1>

    <form class="ricerca" action="${pageContext.request.contextPath}/esplora/ricerca" method="get">
        <input class="ricerca__campo" type="search" name="q"
               placeholder="Cerca un album, un artista, un'etichetta">
        <button class="ricerca__invio" type="submit">Cerca</button>
    </form>

    <section class="categoria">
        <h2 class="categoria__titolo">I Pi&ugrave; Acquistati</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

    <section class="categoria">
        <h2 class="categoria__titolo">I Classici</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

    <section class="categoria">
        <h2 class="categoria__titolo">I Pi&ugrave; Recensiti</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

    <section class="categoria">
        <h2 class="categoria__titolo">In Arrivo</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

    <section class="categoria">
        <h2 class="categoria__titolo">In Sconto</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card">
                    <div class="card__cover"></div>
                    <p class="card__nome">Titolo</p>
                    <p class="card__artista">Artista</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

    <section class="categoria">
        <h2 class="categoria__titolo">Artisti & Gruppi</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
                <article class="card card--profilo">
                    <div class="card__cover"></div>
                    <p class="card__nome">Username</p>
                    <p class="card__voto"><span class="card__stella">&#9733;</span> 4.8</p>
                </article>
            </div>
            <button class="carosello__freccia carosello__freccia--indietro" type="button"
                    aria-label="Scorri indietro" hidden>
                <img src="${pageContext.request.contextPath}/img/icons-arrow-left.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
            <button class="carosello__freccia carosello__freccia--avanti" type="button"
                    aria-label="Scorri avanti">
                <img src="${pageContext.request.contextPath}/img/icons-arrow-right.png"
                     class="carosello__icona" alt="" aria-hidden="true">
            </button>
        </div>
    </section>

</main>

<script src="${pageContext.request.contextPath}/js/esplora.js" defer></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
