<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.albumshelf.mvc.model.bean.Esemplare" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<% request.setAttribute("titoloPagina", "Acquista"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/esplora.css">

<%!
    private String renderCaroselloEsemplari(Collection<Esemplare> esemplari, String ctx) {
        if (esemplari == null || esemplari.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Esemplare e : esemplari) {
            String cover = e.getFileCopertina() != null
                ? ctx + "/img/copertine/" + e.getFileCopertina()
                : "";
            String link = ctx + "/prodotto?id=" + e.getIdEsemplare();
            String nome = e.getNomeAlbum() != null ? e.getNomeAlbum() : "";
            String prezzo = FormatUtil.formatPrezzo(e.getPrezzo());
            String condizione = e.getCondizioneDisco() != null ? e.getCondizioneDisco() : "";
            String formato = e.getFormato() != null ? e.getFormato() : "";

            sb.append("<article class=\"card\">");
            sb.append("<a href=\"").append(link).append("\">");
            if (!cover.isEmpty()) {
                sb.append("<img class=\"card__cover\" src=\"").append(cover).append("\" alt=\"\">");
            } else {
                sb.append("<div class=\"card__cover\"></div>");
            }
            sb.append("<p class=\"card__nome\">").append(nome).append("</p>");
            sb.append("<p class=\"card__artista\">").append(formato).append(" &middot; ").append(condizione).append("</p>");
            sb.append("<p class=\"card__prezzo\">").append(prezzo).append("</p>");
            sb.append("</a></article>");
        }
        return sb.toString();
    }
%>

<%
    String ctx = request.getContextPath();
    Collection<Esemplare> tutti     = (Collection<Esemplare>) request.getAttribute("tutti");
    Collection<Esemplare> vinili    = (Collection<Esemplare>) request.getAttribute("vinili");
    Collection<Esemplare> cd        = (Collection<Esemplare>) request.getAttribute("cd");
    Collection<Esemplare> cassette  = (Collection<Esemplare>) request.getAttribute("cassette");
%>

<main class="esplora">

    <h1 class="esplora__titolo">Acquista</h1>

    <% if (tutti != null && !tutti.isEmpty()) { %>
    <section class="categoria">
        <h2 class="categoria__titolo">Tutti i supporti</h2>
        <div class="carosello">
            <div class="carosello__pista">
                <%= renderCaroselloEsemplari(tutti, ctx) %>
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
                <%= renderCaroselloEsemplari(vinili, ctx) %>
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
                <%= renderCaroselloEsemplari(cd, ctx) %>
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
                <%= renderCaroselloEsemplari(cassette, ctx) %>
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
