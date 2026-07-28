document.querySelectorAll('.carosello').forEach(function (carosello) {
    const pista = carosello.querySelector('.carosello__pista');
    const indietro = carosello.querySelector('.carosello__freccia--indietro');
    const avanti = carosello.querySelector('.carosello__freccia--avanti');

    if (!pista || !indietro || !avanti) {
        return;
    }

    function aggiorna() {
        const scorribile = pista.scrollWidth - pista.clientWidth;
        indietro.hidden = scorribile <= 8 || pista.scrollLeft <= 4;
        avanti.hidden = scorribile <= 8 || pista.scrollLeft >= scorribile - 4;
    }

    function scorri(direzione) {
        pista.scrollBy({ left: direzione * pista.clientWidth * 0.85, behavior: 'smooth' });
    }

    indietro.addEventListener('click', function () { scorri(-1); });
    avanti.addEventListener('click', function () { scorri(1); });

    pista.addEventListener('scroll', aggiorna, { passive: true });
    window.addEventListener('resize', aggiorna);
    window.addEventListener('load', aggiorna);

    requestAnimationFrame(aggiorna);
});