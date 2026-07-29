<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<%@ page import="java.util.Collection" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css">

<%
    Componente artista = (Componente) request.getAttribute("artista");
    Collection<Composizione> gruppi = (Collection<Composizione>) request.getAttribute("gruppi");
%>
<main class="pagina-album">


    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover">
                <img src="${pageContext.request.contextPath}/img/icons-customer.png"
                     alt="<%= artista.getNome() %> <%= artista.getCognome() %>">
            </div>
            <div class="album-dati">
                <h1 class="album-titolo"><%= artista.getNome() %> <%= artista.getCognome() %></h1>
                <% if (artista.getDataNascita() != null) { %>
                <p class="album-dato">
                    Data di nascita: <span class="valore-dato">
                        <%= FormatUtil.formatData(artista.getDataNascita()) %>
                    </span>
                </p>
                <% } %>
                <% if (artista.getDataMorte() != null) { %>
                <p class="album-dato">
                    Data di morte: <span class="valore-dato">
                        <%= FormatUtil.formatData(artista.getDataMorte()) %>
                    </span>
                </p>
                <% } %>
                <% if (artista.getStrumento() != null && !artista.getStrumento().isEmpty()) { %>
                <p class="album-dato">Strumento: <span class="valore-dato"><%= artista.getStrumento() %></span></p>
                <% } %>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Gruppi</h2>
            <% if (gruppi.isEmpty()) { %>
            <p class="album-dato">Nessun gruppo associato.</p>
            <% } else { %>
            <ul class="copie">
                <% for (Composizione comp : gruppi) { %>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/musica/gruppo?id=<%= comp.getIdGruppo() %>">
                                <%= comp.getNomeGruppo() %>
                            </a>
                        </p>
                        <p class="copia__edizione">
                            <%= comp.getRuolo() != null ? comp.getRuolo() : "" %>
                        </p>
                        <p class="copia__venditore">
                            Dal <%= FormatUtil.formatData(comp.getDataIngresso()) %>
                            <%
                                if (comp.getDataUscita() != null) {
                            %>
                                al <%= FormatUtil.formatData(comp.getDataUscita()) %>
                            <% } else if (artista.getDataMorte() != null) { %>
                                al <%= FormatUtil.formatData(artista.getDataMorte()) %>
                            <% } else { %>
                                &ndash; presente
                            <% } %>
                        </p>
                    </div>
                </li>
                <% } %>
            </ul>
            <% } %>
        </section>

    </div>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
