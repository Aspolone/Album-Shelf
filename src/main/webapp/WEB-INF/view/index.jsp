<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Album" %>
<% request.setAttribute("titoloPagina", "Home"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?v=7">

<%!
    private String renderCardHome(Collection<Album> albums, String ctx, int evidenza) {
        if (albums == null || albums.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        int i = 0;
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
            String classe = (i == evidenza) ? "card-album in-evidenza" : "card-album";

            sb.append("<article class=\"").append(classe).append("\">");
            sb.append("<a href=\"").append(link).append("\">");
            if (!cover.isEmpty()) {
                sb.append("<img class=\"copertina\" src=\"").append(cover).append("\" alt=\"\">");
            } else {
                sb.append("<div class=\"copertina\"></div>");
            }
            sb.append("<h3>").append(nome).append("</h3>");
            sb.append("<p>").append(gruppo).append("</p>");
            sb.append("<span class=\"valutazione\">&#9733; ").append(voto).append("</span>");
            sb.append("</a></article>");
            i++;
        }
        return sb.toString();
    }
%>

<%
    String ctx = request.getContextPath();
    Collection<Album> miglioriSettimana = (Collection<Album>) request.getAttribute("miglioriSettimana");
    Collection<Album> miglioriAnno = (Collection<Album>) request.getAttribute("miglioriAnno");
    Collection<Album> piuRecensiti = (Collection<Album>) request.getAttribute("piuRecensiti");
%>

<div class="scroll-snap">

    <section class="sezione-snap sezione-hero">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="AlbumShelf" class="logo-hero">
        <h1 class="titolo-hero">LA TUA MUSICA. LE TUE REGOLE.</h1>
        <p class="sottotitolo-hero">Compra, vendi e recensisci i tuoi dischi.</p>
    </section>

    <% if (miglioriSettimana != null && !miglioriSettimana.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTA SETTIMANA</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">&#9665;</button>
            <div class="traccia-carousel">
                <%= renderCardHome(miglioriSettimana, ctx, 1) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">&#9655;</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

    <% if (miglioriAnno != null && !miglioriAnno.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">MIGLIORI QUESTO ANNO</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">&#9665;</button>
            <div class="traccia-carousel">
                <%= renderCardHome(miglioriAnno, ctx, 1) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">&#9655;</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

    <% if (piuRecensiti != null && !piuRecensiti.isEmpty()) { %>
    <section class="sezione-snap sezione-carousel">
        <h2 class="ribbon">I PI&Ugrave; RECENSITI</h2>
        <div class="carousel">
            <button class="freccia-carousel prev" aria-label="Precedente">&#9665;</button>
            <div class="traccia-carousel">
                <%= renderCardHome(piuRecensiti, ctx, 1) %>
            </div>
            <button class="freccia-carousel next" aria-label="Successivo">&#9655;</button>
        </div>
        <a href="${pageContext.request.contextPath}/esplora" class="vedi-altri">vedine altri</a>
    </section>
    <% } %>

</div>

<script src="${pageContext.request.contextPath}/js/carousel.js"></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>