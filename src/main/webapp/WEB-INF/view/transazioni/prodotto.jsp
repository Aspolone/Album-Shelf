<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/prodotto.css?v=6">

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover"></div>
            <div class="album-dati">
                <h1 class="album-titolo">Example Title</h1>
                <p class="album-dato">
                    Gruppo:
                    <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                </p>
                <p class="album-dato">
                    Album:
                    <a href="${pageContext.request.contextPath}/musica/album?id=1">Nome Album</a>
                </p>
                <p class="album-dato">
                    Casa discografica:
                    <a href="${pageContext.request.contextPath}/musica/casadiscografica?id=1">Nome Etichetta</a>
                </p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Edizione</h2>
            <div class="prodotto-dettagli">
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Formato</span>
                    <span class="prodotto-valore">Vinile 33 giri</span>
                </div>
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Anno di stampa</span>
                    <span class="prodotto-valore">1998</span>
                </div>
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Etichetta</span>
                    <span class="prodotto-valore">Columbia Records</span>
                </div>
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Paese di stampa</span>
                    <span class="prodotto-valore">Italia</span>
                </div>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Condizioni</h2>
            <div class="prodotto-dettagli">
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Supporto</span>
                    <span class="prodotto-valore">Near Mint (Quasi perfetto)</span>
                </div>
                <div class="prodotto-campo">
                    <span class="prodotto-etichetta">Confezione</span>
                    <span class="prodotto-valore">Very Good Plus</span>
                </div>
                <div class="prodotto-campo prodotto-campo--intero">
                    <span class="prodotto-etichetta">Impellicolato</span>
                    <span class="prodotto-badge prodotto-badge--si">Sigillato</span>
                </div>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Foto</h2>
            <div class="prodotto-galleria">
                <img src="${pageContext.request.contextPath}/img/esemplari/1_1.jpg"
                     alt="Foto 1" class="prodotto-foto">
                <img src="${pageContext.request.contextPath}/img/esemplari/1_2.jpg"
                     alt="Foto 2" class="prodotto-foto">
                <img src="${pageContext.request.contextPath}/img/esemplari/1_3.jpg"
                     alt="Foto 3" class="prodotto-foto">
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Tracklist</h2>
            <ol class="tracklist">
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=1">
                        <span class="tracklist__num">1</span>
                        <span class="tracklist__nome">Titolo canzone</span>
                        <span class="tracklist__durata">3:41</span>
                    </a>
                </li>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=2">
                        <span class="tracklist__num">2</span>
                        <span class="tracklist__nome">Titolo canzone</span>
                        <span class="tracklist__durata">4:12</span>
                    </a>
                </li>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=3">
                        <span class="tracklist__num">3</span>
                        <span class="tracklist__nome">Titolo canzone</span>
                        <span class="tracklist__durata">2:58</span>
                    </a>
                </li>
            </ol>
        </section>

    </div>

    <aside class="recensioni">

        <div class="prodotto-acquisto">
            <p class="prodotto-prezzo-grande">20,25 &euro;</p>
            <p class="prodotto-iva">IVA 22% inclusa</p>
            <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                <input type="hidden" name="esemplare" value="1">
                <button class="prodotto-btn-carrello" type="submit">Aggiungi al carrello</button>
            </form>
        </div>

        <div class="prodotto-venditore">
            <h2 class="prodotto-venditore-titolo">Venditore</h2>
            <p class="prodotto-venditore-nome">
                <a href="${pageContext.request.contextPath}/utente/profilo?id=1">Username</a>
            </p>
            <p class="prodotto-venditore-dato">Italia</p>
            <p class="prodotto-venditore-dato">Iscritto dal 2024</p>
        </div>


</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>