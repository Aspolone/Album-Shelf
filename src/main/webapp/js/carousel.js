document.querySelectorAll('.carousel').forEach(function (carousel) {
    const traccia = carousel.querySelector('.traccia-carousel');
    const prev = carousel.querySelector('.freccia-carousel.prev');
    const next = carousel.querySelector('.freccia-carousel.next');

    if (!traccia || !prev || !next) {
        return;
    }

    const totale = traccia.querySelectorAll('.card-album').length;
    if (totale === 0) {
        return;
    }

    const posizioneFocus = Math.floor(totale / 2);

    function aggiornaFocus() {
        const carte = traccia.querySelectorAll('.card-album');
        carte.forEach(function (carta, i) {
            carta.classList.toggle('in-evidenza', i === posizioneFocus);
        });
    }

    function ruotaAvanti() {
        const prima = traccia.querySelector('.card-album');
        if (prima) {
            traccia.appendChild(prima);
            aggiornaFocus();
        }
    }

    function ruotaIndietro() {
        const carte = traccia.querySelectorAll('.card-album');
        const ultima = carte[carte.length - 1];
        if (ultima) {
            traccia.insertBefore(ultima, traccia.querySelector('.card-album'));
            aggiornaFocus();
        }
    }

    next.addEventListener('click', ruotaAvanti);
    prev.addEventListener('click', ruotaIndietro);

    aggiornaFocus();
});
