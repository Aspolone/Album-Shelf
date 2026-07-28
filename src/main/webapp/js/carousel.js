document.querySelectorAll('.carousel').forEach(function (carousel) {
    const traccia = carousel.querySelector('.traccia-carousel');
    const prev = carousel.querySelector('.freccia-carousel.prev');
    const next = carousel.querySelector('.freccia-carousel.next');

    if (!traccia || !prev || !next) {
        return;
    }

    const carte = Array.prototype.slice.call(traccia.querySelectorAll('.card-album'));

    if (carte.length === 0) {
        return;
    }

    let corrente = carte.findIndex(function (carta) {
        return carta.classList.contains('in-evidenza');
    });

    if (corrente < 0) {
        corrente = Math.floor(carte.length / 2);
    }

    function aggiorna() {
        carte.forEach(function (carta, i) {
            carta.classList.toggle('in-evidenza', i === corrente);
        });

        prev.disabled = corrente === 0;
        next.disabled = corrente === carte.length - 1;
    }

    prev.addEventListener('click', function () {
        if (corrente > 0) {
            corrente--;
            aggiorna();
        }
    });

    next.addEventListener('click', function () {
        if (corrente < carte.length - 1) {
            corrente++;
            aggiorna();
        }
    });

    carte.forEach(function (carta, i) {
        carta.addEventListener('click', function () {
            corrente = i;
            aggiorna();
        });
    });

    aggiorna();
});
