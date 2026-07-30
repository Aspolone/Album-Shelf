document.getElementById('idEdizione').addEventListener('change', function() {
    var nuova = document.getElementById('nuovaEdizione');
    var campi = nuova.querySelectorAll('input, select');
    if (this.value === '') {
        nuova.style.display = 'grid';
        document.getElementById('formato').setAttribute('required', 'required');
    } else {
        nuova.style.display = 'none';
        for (var i = 0; i < campi.length; i++) {
            campi[i].removeAttribute('required');
            campi[i].value = '';
        }
    }
});

document.getElementById('immagini').addEventListener('change', function() {
    var anteprima = document.getElementById('anteprimaImmagini');
    anteprima.innerHTML = '';
    var files = this.files;
    if (files.length > 5) {
        var msgEl = document.getElementById('msg-immagini');
        if (!msgEl) {
            msgEl = document.createElement('p');
            msgEl.id = 'msg-immagini';
            msgEl.className = 'form-messaggio form-messaggio--errore';
            anteprima.parentNode.insertBefore(msgEl, anteprima);
        }
        msgEl.textContent = 'Puoi caricare al massimo 5 immagini.';
        this.value = '';
        return;
    }
    var msgOld = document.getElementById('msg-immagini');
    if (msgOld) msgOld.remove();
    for (var i = 0; i < files.length; i++) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'form-upload-thumb';
            anteprima.appendChild(img);
        };
        reader.readAsDataURL(files[i]);
    }
});