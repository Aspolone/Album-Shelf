<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=7">

<%
    CasaDiscografica casa = (CasaDiscografica) request.getAttribute("casaDiscografica");
    Collection<Album> catalogo = (Collection<Album>) request.getAttribute("catalogo");
%>

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-dati">
                <h1 class="album-titolo"><%= casa.getNome() %></h1>
                <% if (casa.getSede() != null && !casa.getSede().isEmpty()) { %>
                <p class="album-dato">Sede: <span class="valore-dato"><%= casa.getSede() %></span></p>
                <% } %>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Catalogo</h2>
            <% if (catalogo.isEmpty()) { %>
            <p class="album-dato">Nessun album pubblicato da questa etichetta.</p>
            <% } else { %>
            <ol class="tracklist">
                <%
                    int numero = 1;
                    for (Album album : catalogo) {
                %>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/album?id=<%= album.getIdAlbum() %>">
                        <span class="tracklist__num"><%= numero %></span>
                        <span class="tracklist__nome">
                            <%= album.getNomeAlbum() %>
                            &ndash;
                            <%= album.getNomeGruppo() %>
                        </span>
                        <span class="tracklist__durata">
                            <%= album.getDataRilascio() != null ? FormatUtil.formatData(album.getDataRilascio()) : "" %>
                        </span>
                    </a>
                </li>
                <%
                        numero++;
                    }
                %>
            </ol>
            <% } %>
        </section>

    </div>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
