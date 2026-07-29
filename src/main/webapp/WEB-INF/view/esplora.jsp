<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Album" %>
<%@ page import="com.albumshelf.mvc.model.bean.Gruppo" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<% request.setAttribute("titoloPagina", "Esplora"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/esplora.css?v=8">

<%!
    private String renderCaroselloAlbum(Collection<Album> albums, String ctx) {
        if (albums == null || albums.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Album a : albums) {
            String cover = a.getFileCopertina() != null
                ? ctx + "/img/copertine/" + a.getFileCopertina()
                : "";
            String link = ctx + "/musica/album?id=" + a.getIdAlbum();
            String nome = a.getNomeAlbum() != null ? a.getNomeAlbum() : "";
            String gruppo = a.getNomeGruppo() != null ? a.getNomeGruppo() : "";
            String voto = FormatUtil.formatVotoBreve(a.getMediaVoto());

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

    private String renderCaroselloGruppi(Collection<Gruppo> gruppi, String ctx) {
        if (gruppi == null || gruppi.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Gruppo g : gruppi) {
            String link = ctx + "/musica/gruppo?id=" + g.getIdGruppo();
            String nome = g.getNome() != null ? g.getNome() : "";

            sb.append("<article class=\"card card--profilo\">");
            sb.append("<a href=\"").append(link).append("\">");
            sb.append("<div class=\"card__cover\"></div>");
            sb.append("<p class=\"card__nome\">").append(nome).append("</p>");
            sb.append("</a></article>");
        }
        return sb.toString();
    }
%>

<%
    String ctx = request.getContextPath();
    Collection<Album> piuVisitati = (Collection<Album>) request.getAttribute("piuVisitati");
    Collection<Album> classici = (Collection<Album>) request.getAttribute("classici");
    Collection<Album> inArrivo = (Collection<Album>) request.getAttribute("inArrivo");
    Collection<Gruppo> gruppi = (Collection<Gruppo>) request.getAttribute("gruppi");
%>

<main class="esplora">

    <h1 class="esplora__titolo">Esplora</h1>

    <form class="ricerca" action="${pageContext.request.contextPath}/esplora/ricerca" method="get">
        <input class="ricerca__campo" type="search" name="q"
               placeholder="Cerca un album, un artista, un'etichetta">
        <button class="ricerca__invio" type="submit">Cerca</button>
    </form>

    <% if (piuVisitati != null && !piuVisitati.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">I Pi&ugrave; Visitati</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCaroselloAlbum(piuVisitati, ctx) %>
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
                <%= renderCaroselloAlbum(classici, ctx) %>
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
        <h2 class="categoria__titolo">Ultime uscite</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCaroselloAlbum(inArrivo, ctx) %>
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

    <% if (gruppi != null && !gruppi.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">Artisti &amp; Gruppi</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCaroselloGruppi(gruppi, ctx) %>
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