<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="album-cover"></div>
            <div class="album-dati">
                <h1 class="album-titolo">Example Title</h1>
                <p class="album-dato">
                    Gruppo:
                    <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                    &middot;
                    <a href="${pageContext.request.contextPath}/musica/artista?id=1">Nome Artista</a>
                </p>
                <p class="album-dato">Data incisione:</p>
                <p class="album-dato">Data rilascio:</p>
                <p class="album-dato">Genere:</p>
                <p class="album-dato">Descrizione:</p>
            </div>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Acquista</h2>
            <ul class="copie">
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">Ottime condizioni</p>
                        <p class="copia__edizione">Prima stampa 1998 &middot; Vinile 33 giri</p>
                        <p class="copia__venditore">
                            Venduto da
                            <a href="${pageContext.request.contextPath}/utente/profilo?id=1">Username</a>
                        </p>
                    </div>
                    <p class="copia__prezzo">20,25 &euro;</p>
                    <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                        <input type="hidden" name="esemplare" value="1">
                        <button class="copia__azione" type="submit">Aggiungi al carrello</button>
                    </form>
                </li>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">Buone condizioni</p>
                        <p class="copia__edizione">Ristampa 2012 &middot; CD</p>
                        <p class="copia__venditore">
                            Venduto da
                            <a href="${pageContext.request.contextPath}/utente/profilo?id=2">Username</a>
                        </p>
                    </div>
                    <p class="copia__prezzo">14,90 &euro;</p>
                    <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                        <input type="hidden" name="esemplare" value="2">
                        <button class="copia__azione" type="submit">Aggiungi al carrello</button>
                    </form>
                </li>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">Accettabile</p>
                        <p class="copia__edizione">Edizione limitata &middot; Cassetta</p>
                        <p class="copia__venditore">
                            Venduto da
                            <a href="${pageContext.request.contextPath}/utente/profilo?id=3">Username</a>
                        </p>
                    </div>
                    <p class="copia__prezzo">9,50 &euro;</p>
                    <form action="${pageContext.request.contextPath}/carrello/aggiungi" method="post">
                        <input type="hidden" name="esemplare" value="3">
                        <button class="copia__azione" type="submit">Aggiungi al carrello</button>
                    </form>
                </li>
            </ul>
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
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=4">
                        <span class="tracklist__num">4</span>
                        <span class="tracklist__nome">Titolo canzone</span>
                        <span class="tracklist__durata">5:07</span>
                    </a>
                </li>
                <li class="tracklist__voce">
                    <a href="${pageContext.request.contextPath}/musica/canzone?id=5">
                        <span class="tracklist__num">5</span>
                        <span class="tracklist__nome">Titolo canzone</span>
                        <span class="tracklist__durata">3:22</span>
                    </a>
                </li>
            </ol>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">Casa discografica</h2>
            <p class="album-dato">
                <a href="${pageContext.request.contextPath}/musica/casadiscografica?id=1">Nome Etichetta</a>
            </p>
            <p class="album-testo">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua.
            </p>
        </section>

    </div>

    <aside class="recensioni">
        <div class="recensioni__pannello">
            <h2 class="nastro">Recensioni</h2>
            <article class="recensione">
                <p class="recensione__autore">
                    <a href="${pageContext.request.contextPath}/utente/profilo?id=1">Nome Utente</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9733;&#9733;</p>
                <p class="recensione__testo">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                    incididunt ut labore et dolore magna aliqua.
                </p>
            </article>
            <article class="recensione">
                <p class="recensione__autore">
                    <a href="${pageContext.request.contextPath}/utente/profilo?id=2">Nome Utente</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9733;&#9734;</p>
                <p class="recensione__testo">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                    incididunt ut labore et dolore magna aliqua.
                </p>
            </article>
        </div>
        <a class="recensioni__azione"
           href="${pageContext.request.contextPath}/utente/aggiungirecensione?album=1">Aggiungi recensione</a>
    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>