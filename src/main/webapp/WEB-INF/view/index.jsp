<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("titoloPagina", "Home"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?v=8">

<main class="pagina">
    <section class="sezione-hero">
        <a href="${pageContext.request.contextPath}/esplora">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="Vai a Esplora" class="logo-hero">
        </a>
        <h1 class="titolo-hero">LA TUA MUSICA. LE TUE REGOLE.</h1>
        <p class="sottotitolo-hero">Compra, vendi e recensisci i tuoi dischi.</p>
    </section>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
