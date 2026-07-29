<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("titoloPagina", "Home"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">


<main class="pagina">
    <section class="sezione-hero">
        <a href="${pageContext.request.contextPath}/esplora">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="Vai a Esplora" class="logo-hero">
        </a>
        <h1 class="titolo-hero">LA TUA MUSICA. LE TUE REGOLE.</h1>
        <p class="sottotitolo-hero">Compra, vendi e recensisci i tuoi dischi.</p>
    </section>
</main>

    <% if (miglioriSettimana != null && !miglioriSettimana.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTA SETTIMANA</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--prev">
            </button>
            <div class="traccia-carousel">
                <%= renderCardHome(miglioriSettimana, ctx, miglioriSettimana.size() / 2) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--next">
            </button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

    <% if (miglioriAnno != null && !miglioriAnno.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTO ANNO</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--prev">
            </button>
            <div class="traccia-carousel">
                <%= renderCardHome(miglioriAnno, ctx, miglioriAnno.size() / 2) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--next">
            </button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

    <% if (piuRecensiti != null && !piuRecensiti.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">I PI&Ugrave; RECENSITI</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--prev">
            </button>
            <div class="traccia-carousel">
                <%= renderCardHome(piuRecensiti, ctx, piuRecensiti.size() / 2) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">
                <img src="${pageContext.request.contextPath}/img/icons-chevron-down.png" alt="" class="icona-freccia icona-freccia--next">
            </button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

</div>

<script src="${pageContext.request.contextPath}/js/carousel.js"></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
