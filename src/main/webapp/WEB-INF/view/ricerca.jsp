<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.RisultatoRicerca" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.ArrayList" %>

<%
    Collection<RisultatoRicerca> risultati = (Collection<RisultatoRicerca>) request.getAttribute("risultati");
    if (risultati == null) {
        risultati = new ArrayList<>();
    }
    
    String testoCercato = (String) request.getAttribute("testoCercato");
    if (testoCercato == null) {
        testoCercato = "";
    }
%>

<%@ include file="/WEB-INF/view/fragment/header.jspf" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ricerca.css">

<main class="pagina-info">

    <% if (risultati.isEmpty()) { %>
        <p>Nessun risultato trovato.</p>
    <% } else { %>
        <ul class="lista-risultati-ricerca">
            <% for (RisultatoRicerca r : risultati) { %>
            <li>
                <a href="<%= request.getContextPath() + r.getUrl() %>">
                    <div>
                        <strong><%= r.getTitolo() %></strong>
                        <% if (r.getSottotitolo() != null && !r.getSottotitolo().isEmpty()) { %>
                            <span class="risultato-dettagli"><%= r.getSottotitolo() %></span>
                        <% } %>
                    </div>
                    <span class="badge-tipo"><%= r.getTipo() %></span>
                </a>
            </li>
            <% } %>
        </ul>
    <% } %>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>