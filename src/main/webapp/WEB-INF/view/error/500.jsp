<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">

<section class="pagina-error">
    <div class="codice-error">500</div>
    <h1 class="titolo-error">Errore del server</h1>
    <p class="messaggio-error">Qualcosa è andato storto. Riprova tra qualche istante.</p>
    <a href="${pageContext.request.contextPath}/" class="bottone-error">Torna alla home</a>
</section>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>