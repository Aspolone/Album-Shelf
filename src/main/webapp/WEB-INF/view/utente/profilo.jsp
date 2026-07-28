<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/album.css?v=6">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/profilo.css?v=6">

<main class="pagina-album">

    <div class="album-colonna">

        <section class="album-testata">
            <div class="profilo-avatar">
                <img src="${pageContext.request.contextPath}/img/icons-customer.png"
                     alt="Avatar" class="profilo-avatar-img">
            </div>
            <div class="album-dati">
                <h1 class="album-titolo">Username</h1>
                <p class="album-dato">Nazione: Italia</p>
                <p class="album-dato">Iscritto dal: 15 Marzo 2024</p>
                <p class="album-dato">
                    <span class="profilo-ruolo">Cliente</span>
                </p>
                <p class="album-testo">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    Collezionista di vinili prog rock e jazz fusion.
                </p>
            </div>
        </section>

        <section class="profilo-azioni">
            <a href="${pageContext.request.contextPath}/modificaprofilo"
               class="album-azione">Modifica profilo</a>
            <a href="${pageContext.request.contextPath}/vendi"
               class="album-azione">Metti in vendita</a>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">In vendita</h2>
            <ul class="copie">
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/prodotto?id=1">Example Title</a>
                        </p>
                        <p class="copia__edizione">Near Mint &middot; Vinile 33 giri &middot; 1998</p>
                        <p class="copia__venditore">
                            <a href="${pageContext.request.contextPath}/musica/album?id=1">Nome Album</a>
                            &middot;
                            <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                        </p>
                    </div>
                    <p class="copia__prezzo">20,25 &euro;</p>
                    <span class="profilo-stato profilo-stato--attivo">Attivo</span>
                </li>
                <li class="copia">
                    <div class="copia__dati">
                        <p class="copia__condizione">
                            <a href="${pageContext.request.contextPath}/prodotto?id=2">Example Title</a>
                        </p>
                        <p class="copia__edizione">Very Good Plus &middot; CD &middot; 2012</p>
                        <p class="copia__venditore">
                            <a href="${pageContext.request.contextPath}/musica/album?id=2">Nome Album</a>
                            &middot;
                            <a href="${pageContext.request.contextPath}/musica/gruppo?id=1">Nome Gruppo</a>
                        </p>
                    </div>
                    <p class="copia__prezzo">14,90 &euro;</p>
                    <span class="profilo-stato profilo-stato--venduto">Venduto</span>
                </li>
            </ul>
        </section>

        <section class="album-blocco">
            <h2 class="nastro">I miei ordini</h2>
            <ul class="elenco">
                <li>
                    <a href="${pageContext.request.contextPath}/utente/mioordine?id=1">
                        <div class="profilo-ordine-info">
                            <span class="profilo-ordine-id">Ordine #1</span>
                            <span class="profilo-ordine-data">15 Luglio 2026</span>
                        </div>
                        <div class="profilo-ordine-destra">
                            <span class="profilo-stato profilo-stato--confermato">Confermato</span>
                            <span class="elenco__meta">42,65 &euro;</span>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/utente/mioordine?id=2">
                        <div class="profilo-ordine-info">
                            <span class="profilo-ordine-id">Ordine #2</span>
                            <span class="profilo-ordine-data">3 Giugno 2026</span>
                        </div>
                        <div class="profilo-ordine-destra">
                            <span class="profilo-stato profilo-stato--consegnato">Consegnato</span>
                            <span class="elenco__meta">18,90 &euro;</span>
                        </div>
                    </a>
                </li>
            </ul>
        </section>

    </div>

    <aside class="recensioni">

        <div class="recensioni__pannello">
            <h2 class="nastro">Recensioni scritte</h2>
            <article class="recensione">
                <p class="recensione__autore">
                    su <a href="${pageContext.request.contextPath}/musica/album?id=1">Nome Album</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9733;&#9733;</p>
                <p class="recensione__testo">
                    Album straordinario, ogni traccia è un capolavoro.
                </p>
            </article>
            <article class="recensione">
                <p class="recensione__autore">
                    su <a href="${pageContext.request.contextPath}/musica/canzone?id=3">Nome Canzone</a>
                </p>
                <p class="recensione__voto">&#9733;&#9733;&#9733;&#9734;&#9734;</p>
                <p class="recensione__testo">
                    Buon brano ma la produzione non mi convince del tutto.
                </p>
            </article>
        </div>

    </aside>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>