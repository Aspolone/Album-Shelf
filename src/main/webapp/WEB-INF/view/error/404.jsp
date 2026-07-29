<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<% request.setAttribute("titoloPagina", "404"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">

<section class="pagina-error">
    <div class="codice-error">404</div>
    <h1 class="titolo-error">Pagina non trovata</h1>
    <p class="messaggio-error">La risorsa che stai cercando non esiste o è stata spostata.</p>
    <a href="${pageContext.request.contextPath}/" class="bottone-error">Torna alla home</a>
</section>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>