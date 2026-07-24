<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">

<section class="pagina-error">
    <div class="codice-error">403</div>
    <h1 class="titolo-error">Accesso negato</h1>
    <p class="messaggio-error">Non hai i permessi per visualizzare questa pagina.</p>
    <a href="${pageContext.request.contextPath}/auth" class="bottone-error">Accedi</a>
</section>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>