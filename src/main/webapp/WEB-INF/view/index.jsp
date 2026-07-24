<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">

<div class="scroll-snap">

    <section class="sezione-snap sezione-hero">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="AlbumShelf" class="logo-hero">
        <h1 class="titolo-hero">LA TUA MUSICA. LE TUE REGOLE.</h1>
        <p class="sottotitolo-hero">Compra, vendi e recensisci i tuoi dischi.</p>
    </section>

    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTA SETTIMANA</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">‹</button>
            <div class="traccia-carousel">
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album in-evidenza">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">›</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora#piuAcquistati" class="vedi-altri">vedine altri</a>
    </section>

    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTO ANNO</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">‹</button>
            <div class="traccia-carousel">
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album in-evidenza">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">›</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora#classici" class="vedi-altri">vedine altri</a>
    </section>

    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">I PIÙ RECENSITI</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">‹</button>
            <div class="traccia-carousel">
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album in-evidenza">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
                <article class="card-album">
                    <div class="copertina"></div>
                    <h3>TITOLO</h3>
                    <p>ARTISTA</p>
                    <span class="valutazione">★ 4.8</span>
                </article>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">›</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora#piuRecensiti" class="vedi-altri">vedine altri</a>
    </section>

</div>

<script src="${pageContext.request.contextPath}/js/carousel.js"></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>