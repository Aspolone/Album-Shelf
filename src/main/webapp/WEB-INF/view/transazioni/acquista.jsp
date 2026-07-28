<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Album" %>
<% request.setAttribute("titoloPagina", "Acquista"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/esplora.css?v=6">

<%!
    private String renderCarosello(Collection<Album> albums, String ctx) {
        if (albums == null || albums.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Album a : albums) {
            String cover = a.getFileCopertina() != null
                ? ctx + "/img/copertine/" + a.getFileCopertina()
                : "";
            String link = ctx + "/musica/album?id=" + a.getIdAlbum();
            String nome = a.getNomeAlbum() != null ? a.getNomeAlbum() : "";
            String gruppo = a.getNomeGruppo() != null ? a.getNomeGruppo() : "";
            String voto = a.getMediaVoto() != null
                ? a.getMediaVoto().setScale(1).toPlainString()
                : "-";

            sb.append("<article class=\"card\">");
            sb.append("<a href=\"").append(link).append("\">");
            if (!cover.isEmpty()) {
                sb.append("<img class=\"card__cover\" src=\"").append(cover).append("\" alt=\"\">");
            } else {
                sb.append("<div class=\"card__cover\"></div>");
            }
            sb.append("<p class=\"card__nome\">").append(nome).append("</p>");
            sb.append("<p class=\"card__artista\">").append(gruppo).append("</p>");
            sb.append("<p class=\"card__voto\"><span class=\"card__stella\">&#9733;</span> ")
              .append(voto).append("</p>");
            sb.append("</a></article>");
        }
        return sb.toString();
    }
%>

<%
    String ctx = request.getContextPath();
    Collection<Album> piuAcquistati = (Collection<Album>) request.getAttribute("piuAcquistati");
    Collection<Album> vinili = (Collection<Album>) request.getAttribute("vinili");
    Collection<Album> classici = (Collection<Album>) request.getAttribute("classici");
    Collection<Album> cassette = (Collection<Album>) request.getAttribute("cassette");
    Collection<Album> inArrivo = (Collection<Album>) request.getAttribute("inArrivo");
    Collection<Album> cd = (Collection<Album>) request.getAttribute("cd");
    Collection<Album> tutti = (Collection<Album>) request.getAttribute("tutti");
%>

<main class="esplora">

    <h1 class="esplora__titolo">Acquista</h1>

    <form class="ricerca" action="${pageContext.request.contextPath}/acquista/ricerca" method="get">
        <input class="ricerca__campo" type="search" name="q"
               placeholder="Cerca un album, un artista, un'etichetta">
        <button class="ricerca__invio" type="submit">Cerca</button>
    </form>

    <% if (piuAcquistati != null && !piuAcquistati.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">I Pi&ugrave; Acquistati</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(piuAcquistati, ctx) %>
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
    <% } %>

    <% if (vinili != null && !vinili.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">Vinili</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(vinili, ctx) %>
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
    <% } %>

    <% if (classici != null && !classici.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">I Classici</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(classici, ctx) %>
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
    <% } %>

    <% if (cassette != null && !cassette.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">Cassette</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(cassette, ctx) %>
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
    <% } %>

    <% if (inArrivo != null && !inArrivo.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">In Arrivo</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(inArrivo, ctx) %>
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
    <% } %>

    <% if (cd != null && !cd.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">CD</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(cd, ctx) %>
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
    <% } %>

    <% if (tutti != null && !tutti.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">Tutti i supporti</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCarosello(tutti, ctx) %>
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
    <% } %>

</main>

<script src="${pageContext.request.contextPath}/js/esplora.js" defer></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>