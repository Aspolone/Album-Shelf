<% request.setAttribute("titoloPagina", "About"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/infopages.css">


<main class="info-page">
		
  <header class="info-header">
    <p class="info-eyebrow">Informazioni</p>
    <h1>Chi siamo</h1>
    <p class="info-lead">
      Siamo un mercato online dedicato alla musica registrata: dischi, album e
      singoli che passano di mano tra chi li ha collezionati e chi li sta ancora
      cercando. Niente magazzino centrale, niente intermediari: le inserzioni
      sono pubblicate direttamente dai venditori.
    </p>
  </header>

  <section class="info-section">
    <h2>Cosa trovi nel catalogo</h2>
    <p>
      Ogni prodotto in vendita &egrave; collegato alle informazioni musicali che lo
      descrivono, cosí puoi partire da quello che conosci e arrivare a quello che
      non conosci ancora. Il catalogo &egrave; organizzato su cinque livelli:
    </p>
    <dl class="info-list">
      <dt>Canzone</dt>
      <dd>Il singolo brano, con la sua durata e le edizioni in cui compare.</dd>

      <dt>Album</dt>
      <dd>La raccolta completa, con tracklist e anno di pubblicazione.</dd>

      <dt>Artista</dt>
      <dd>Il singolo musicista, con la sua discografia.</dd>

      <dt>Gruppo</dt>
      <dd>La formazione, con gli artisti che ne fanno o ne hanno fatto parte.</dd>

      <dt>Casa discografica</dt>
      <dd>L'etichetta che ha pubblicato il disco, con il suo catalogo.</dd>
    </dl>
    <p>
      Le schede sono collegate tra loro: dalla pagina di una canzone raggiungi
      l'album che la contiene, da lí il gruppo che l'ha incisa e l'etichetta che
      l'ha pubblicata.
    </p>
  </section>

  <section class="info-section">
    <h2>Come funziona</h2>
    <p>
      Per navigare il catalogo non serve alcuna registrazione. L'account &egrave;
      richiesto solo nel momento in cui vuoi acquistare o vendere: serve a tenere
      insieme il carrello, lo storico degli ordini e le recensioni che scrivi.
    </p>
    <p>
      Chi compra sceglie i prodotti, li raccoglie nel carrello e completa
      l'ordine. Chi vende pubblica le proprie inserzioni, riceve gli ordini e
      spedisce. Ogni acquisto concluso può essere recensito, e le recensioni
      restano visibili sulla scheda del prodotto.
    </p>
  </section>

  <section class="info-section">
    <h2>Le recensioni</h2>
    <p>
      Puoi recensire solo i prodotti che hai effettivamente acquistato. &Egrave; una
      regola che riduce il numero di recensioni ma le rende affidabili: quello
      che leggi su una scheda viene da qualcuno che quel disco lo ha ricevuto
      davvero.
    </p>
  </section>

  <nav class="info-next">
    <h2>Da qui puoi</h2>
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/esplora">Esplorare il catalogo</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/transazioni/comevendere">Scoprire come vendere</a>
      </li>
    </ul>
  </nav>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
