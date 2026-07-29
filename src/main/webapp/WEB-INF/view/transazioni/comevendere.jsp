<% request.setAttribute("titoloPagina", "Come Vendere"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/infopages.css">


<main class="info-page">

  <header class="info-header">
    <p class="info-eyebrow">Guida</p>
    <h1>Come vendere</h1>
    <p class="info-lead">
      Mettere in vendita un disco richiede pochi minuti. Questa pagina spiega il
      percorso completo, dalla registrazione alla spedizione, cos&igrave; sai cosa
      aspettarti prima di iniziare.
    </p>
  </header>

  <section class="info-section">
    <h2>I passaggi</h2>

    <ol class="info-steps">
      <li>
        <h3>Crea un account</h3>
        <p>
          Serve un account per pubblicare un'inserzione: &egrave; quello che collega il
          prodotto a te e ti permette di ricevere gli ordini. Se ne hai gi&agrave; uno,
          accedi e prosegui.
        </p>
        <p class="info-step-link">
          <a href="${pageContext.request.contextPath}/auth">Accedi o registrati</a>
        </p>
      </li>

      <li>
        <h3>Prepara le informazioni del disco</h3>
        <p>
          Prima di aprire il modulo, tieni a portata di mano i dati che ti
          verranno chiesti: titolo dell'album, artista o gruppo, casa
          discografica, anno di pubblicazione e formato. Pi&ugrave; la scheda &egrave; precisa,
          pi&ugrave; &egrave; probabile che chi cerca proprio quel disco lo trovi.
        </p>
      </li>

      <li>
        <h3>Descrivi lo stato di conservazione</h3>
        <p>
          &Egrave; la parte che fa la differenza sui dischi usati. Indica lo stato del
          supporto e della copertina, e segnala i difetti: graffi, salti in
          riproduzione, angoli consumati, inserti mancanti. Una descrizione
          onesta evita quasi tutte le contestazioni.
        </p>
      </li>

      <li>
        <h3>Pubblica l'inserzione</h3>
        <p>
          Compila il modulo di inserimento con i dati che hai preparato e imposta
          il prezzo. Da questo momento il prodotto compare nel catalogo ed &egrave;
          acquistabile.
        </p>
        <p class="info-step-link">
          <a href="${pageContext.request.contextPath}/vendi">Aggiungi un prodotto</a>
        </p>
      </li>

      <li>
        <h3>Gestisci l'ordine e spedisci</h3>
        <p>
          Quando qualcuno acquista, l'ordine compare nella tua area personale con
          i dati necessari alla spedizione. Imballa il disco in modo che non si
          pieghi durante il trasporto e spedisci in tempi brevi: la puntualit&agrave; &egrave;
          la prima cosa che finisce nelle recensioni.
        </p>
        <p class="info-step-link">
          <a href="${pageContext.request.contextPath}/profilo">Vai ai tuoi ordini</a>
        </p>
      </li>
    </ol>
  </section>

  <section class="info-section">
    <h2>Come fissare il prezzo</h2>
    <p>
      Cerca lo stesso album nel catalogo e guarda a quanto &egrave; proposto dagli altri
      venditori, tenendo conto dello stato di conservazione: due copie dello
      stesso disco possono valere molto diversamente. Le prime stampe, le edizioni
      limitate e i dischi ancora sigillati stanno su una fascia a parte.
    </p>
  </section>

  <section class="info-section">
    <h2>Cosa non puoi vendere</h2>
    <ul class="info-list-plain">
      <li>Copie non autorizzate, masterizzate o riprodotte senza licenza.</li>
      <li>File audio e download: sul sito si vendono supporti fisici.</li>
      <li>Prodotti che non possiedi o che non sei in grado di spedire.</li>
    </ul>
  </section>

  <nav class="info-next">
    <h2>Da qui puoi</h2>
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/vendi">Pubblicare la tua prima inserzione</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/acquista">Acquistare il tuo primo prodotto</a>
      </li>
    </ul>
  </nav>

</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
