// ricerca.js
// Barra di ricerca con suggerimenti live via fetch, senza ricaricare la pagina.
// Il submit "normale" del form resta funzionante come fallback (se JS e'
// disabilitato o l'utente preme Invio), questo script aggiunge solo il
// dropdown dei risultati mentre l'utente digita.

(function () {
    const campo = document.getElementById("campo-ricerca");
    const contenitoreRisultati = document.getElementById("risultati-ricerca");

    if (!campo || !contenitoreRisultati) return;

    const contextPath = campo.closest("form").getAttribute("action").replace("/ricerca", "");

    let timerDebounce = null;
    let controllerFetchInCorso = null;

    campo.addEventListener("input", function () {
        const testo = campo.value.trim();

        // debounce: aspetta che l'utente smetta di digitare per 300ms prima
        // di chiamare il server, altrimenti si spara una richiesta per ogni
        // singolo carattere digitato
        clearTimeout(timerDebounce);

        if (testo.length < 2) {
            nascondiRisultati();
            return;
        }

        timerDebounce = setTimeout(function () {
            eseguiRicerca(testo);
        }, 300);
    });

    function eseguiRicerca(testo) {
        // annulla la richiesta precedente se ancora in volo: evita che una
        // risposta lenta e vecchia sovrascriva una risposta piu recente
        if (controllerFetchInCorso) {
            controllerFetchInCorso.abort();
        }
        controllerFetchInCorso = new AbortController();

        const url = contextPath + "/ricerca?q=" + encodeURIComponent(testo) + "&ajax=true";

        fetch(url, { signal: controllerFetchInCorso.signal })
            .then(function (risposta) {
                if (!risposta.ok) throw new Error("Risposta non valida dal server");
                return risposta.json();
            })
            .then(mostraRisultati)
            .catch(function (errore) {
                if (errore.name !== "AbortError") {
                    console.error("Errore nella ricerca:", errore);
                    nascondiRisultati();
                }
            });
    }

    function mostraRisultati(risultati) {
        contenitoreRisultati.innerHTML = "";

        if (!risultati || risultati.length === 0) {
            const voce = document.createElement("li");
            voce.className = "risultato-ricerca risultato-ricerca--vuoto";
            voce.textContent = "Nessun risultato trovato.";
            contenitoreRisultati.appendChild(voce);
            contenitoreRisultati.hidden = false;
            return;
        }

        risultati.forEach(function (r) {
            const voce = document.createElement("li");
            voce.className = "risultato-ricerca";

            const link = document.createElement("a");
            link.href = contextPath + r.url;

            const titolo = document.createElement("span");
            titolo.className = "risultato-ricerca__titolo";
            titolo.textContent = r.titolo;

            const sottotitolo = document.createElement("span");
            sottotitolo.className = "risultato-ricerca__sottotitolo";
            sottotitolo.textContent = r.tipo + (r.sottotitolo ? " · " + r.sottotitolo : "");

            link.appendChild(titolo);
            link.appendChild(sottotitolo);
            voce.appendChild(link);
            contenitoreRisultati.appendChild(voce);
        });

        contenitoreRisultati.hidden = false;
    }

    function nascondiRisultati() {
        contenitoreRisultati.hidden = true;
        contenitoreRisultati.innerHTML = "";
    }

    // chiudi il dropdown se l'utente clicca fuori dalla barra di ricerca
    document.addEventListener("click", function (evento) {
        const dentroLaRicerca = evento.target.closest(".barra-ricerca-wrapper");
        if (!dentroLaRicerca) nascondiRisultati();
    });

    // chiudi con Escape
    campo.addEventListener("keydown", function (evento) {
        if (evento.key === "Escape") nascondiRisultati();
    });
})();