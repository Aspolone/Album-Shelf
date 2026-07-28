<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover"></div>
            <div class="album-dati">
                <h1 class="album-titolo">Nome Artista</h1>
                <p class="album-dato">Data di nascita:</p>
                <p class="album-dato">Paese:</p>
                <p class="album-dato">Strumento:</p>
                <p class="album-dato">
                    Gruppo:
                    <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                </p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Biografia</h2>
            <p class="album-testo">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
            </p>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Discografia</h2>
            <ul class="elenco">
                <li>
                    <a href="${pageContext.request.contextPath}/musica/album?id=1">
                        Example Title <span class="elenco__meta">1998</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/musica/album?id=2">
                        Example Title <span class="elenco__meta">2001</span>
                    </a>
                </li>
            </ul>
        </section>

    </div>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>