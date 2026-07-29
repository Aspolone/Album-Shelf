<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css?v=6">

<main class="pagina">
    <div class="form-pagina">

        <header class="info-header">
            <h1>Metti in vendita</h1>
            <p class="info-lead">
                Seleziona l'album e l'edizione del disco che vuoi vendere,
                poi descrivi le condizioni del tuo esemplare.
                I campi con * sono obbligatori.
            </p>
        </header>

        <form action="${pageContext.request.contextPath}/vendi"
              method="post" enctype="multipart/form-data" class="form-vendi">

            <fieldset class="form-sezione">
                <legend class="nastro">Album</legend>
                <div class="form-griglia">
                    <div class="form-campo form-campo--intero">
                        <label for="idAlbum">Cerca l'album nel catalogo *</label>
                        <select id="idAlbum" name="idAlbum" required>
                            <option value="">Seleziona un album</option>
                        </select>
                    </div>
                </div>
            </fieldset>

            <fieldset class="form-sezione">
                <legend class="nastro">Edizione</legend>
                <p class="form-sezione-intro">
                    Se l'edizione che possiedi è già presente selezionala,
                    altrimenti compila i campi sotto per crearne una nuova.
                </p>
                <div class="form-griglia">
                    <div class="form-campo form-campo--intero">
                        <label for="idEdizione">Edizione esistente</label>
                        <select id="idEdizione" name="idEdizione">
                            <option value="">Nessuna — ne creo una nuova</option>
                        </select>
                    </div>
                </div>
                <div id="nuovaEdizione" class="form-griglia form-griglia--sotto">
                    <div class="form-campo">
                        <label for="formato">Formato *</label>
                        <select id="formato" name="formato" required>
                            <option value="">Seleziona</option>
                            <option value="Vinile">Vinile</option>
                            <option value="CD">CD</option>
                            <option value="Cassetta">Cassetta</option>
                        </select>
                    </div>
                    <div class="form-campo">
                        <label for="annoStampa">Anno di stampa</label>
                        <input type="number" id="annoStampa" name="annoStampa"
                               min="1900" max="2026" placeholder="es. 1998">
                    </div>
                    <div class="form-campo">
                        <label for="etichetta">Etichetta</label>
                        <input type="text" id="etichetta" name="etichetta"
                               placeholder="es. Columbia Records">
                    </div>
                    <div class="form-campo">
                        <label for="paeseEdizione">Paese di stampa</label>
                        <input type="text" id="paeseEdizione" name="paeseEdizione"
                               placeholder="es. Italia">
                    </div>
                </div>
            </fieldset>

            <fieldset class="form-sezione">
                <legend class="nastro">Il tuo esemplare</legend>
                <div class="form-griglia">
                    <div class="form-campo">
                        <label for="prezzo">Prezzo (&euro;) *</label>
                        <input type="number" id="prezzo" name="prezzo"
                               step="0.01" min="0.01" required>
                    </div>
                    <div class="form-campo">
                        <label for="iva">IVA (%) *</label>
                        <input type="number" id="iva" name="iva"
                               step="0.01" min="0" max="99.99" value="22.00" required>
                    </div>
                    <div class="form-campo">
                        <label for="condizioneSupporto">Stato del supporto *</label>
                        <select id="condizioneSupporto" name="condizioneSupporto" required>
                            <option value="">Seleziona</option>
                            <option value="Nuovo">Nuovo</option>
                            <option value="Ottimo">Ottimo</option>
                            <option value="Buono">Buono</option>
                            <option value="Discreto">Discreto</option>
                            <option value="Scarso">Scarso</option>
                        </select>
                    </div>
                    <div class="form-campo">
                        <label for="condizioneConfezione">Stato della confezione *</label>
                        <select id="condizioneConfezione" name="condizioneConfezione" required>
                            <option value="">Seleziona</option>
                            <option value="Nuovo">Nuovo</option>
                            <option value="Ottimo">Ottimo</option>
                            <option value="Buono">Buono</option>
                            <option value="Discreto">Discreto</option>
                            <option value="Scarso">Scarso</option>
                        </select>
                    </div>
                </div>
                <div class="form-campo-singolo">
                    <label class="form-checkbox">
                        <input type="checkbox" name="impellicolato" value="true">
                        <span>L'articolo è ancora impellicolato (sigillato nella confezione originale)</span>
                    </label>
                </div>
            </fieldset>

            <fieldset class="form-sezione">
                <legend class="nastro">Immagini</legend>
                <div class="form-campo-singolo">
                    <label for="immagini">Carica foto dell'esemplare (max 5, formati JPG/PNG)</label>
                    <div class="form-upload">
                        <input type="file" id="immagini" name="immagini"
                               accept="image/jpeg,image/png" multiple>
                        <div class="form-upload-placeholder">
                            <span class="form-upload-icona">&#8679;</span>
                            <span class="form-upload-testo">Trascina qui le immagini o clicca per selezionarle</span>
                            <span class="form-upload-hint">JPG o PNG, massimo 5 MB ciascuna</span>
                        </div>
                    </div>
                    <div class="form-upload-anteprima" id="anteprimaImmagini"></div>
                </div>
            </fieldset>

            <fieldset class="form-sezione">
                <legend class="nastro">Condizioni di vendita</legend>
                <p class="form-termini-intro">
                    Pubblicando questo esemplare accetti le seguenti condizioni:
                </p>
                <ol class="form-termini-lista">
                    <li>L'articolo descritto corrisponde fedelmente alle condizioni
                        dichiarate e alle fotografie caricate.</li>
                    <li>La spedizione avverrà entro 5 giorni lavorativi dalla
                        ricezione del pagamento.</li>
                    <li>In caso di reso per difetto non dichiarato, il venditore
                        si impegna al rimborso completo incluse le spese di
                        spedizione.</li>
                    <li>Il venditore è responsabile della corretta applicazione
                        dell'IVA secondo la normativa vigente nel proprio paese.</li>
                    <li>AlbumShelf si riserva il diritto di rimuovere inserzioni
                        che violano i termini di servizio della piattaforma.</li>
                </ol>
                <div class="form-campo-singolo">
                    <label class="form-checkbox">
                        <input type="checkbox" name="accettaTermini" required>
                        <span>Ho letto e accetto le condizioni di vendita di AlbumShelf</span>
                    </label>
                </div>
            </fieldset>

            <button type="submit" class="form-submit">Pubblica esemplare</button>

        </form>

    </div>
</main>

<script src="${pageContext.request.contextPath}/js/immagini.js" defer></script>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>