(function () {
    var tabLogin = document.getElementById('tabLogin');
    var tabSignup = document.getElementById('tabSignup');
    var formLogin = document.getElementById('formLogin');
    var formSignup = document.getElementById('formSignup');
    var thumb = document.getElementById('authThumb');

    function showLogin() {
        formLogin.style.display = 'block';
        formSignup.style.display = 'none';
        thumb.style.transform = 'translateX(0)';
        tabLogin.classList.add('active');
        tabSignup.classList.remove('active');
    }

    function showSignup() {
        formLogin.style.display = 'none';
        formSignup.style.display = 'block';
        thumb.style.transform = 'translateX(100%)';
        tabSignup.classList.add('active');
        tabLogin.classList.remove('active');
    }

    tabLogin.addEventListener('click', showLogin);
    tabSignup.addEventListener('click', showSignup);

    document.querySelectorAll('.auth-eye').forEach(function (btn) {
        var icona = btn.querySelector('.auth-eye-icona');
        btn.addEventListener('click', function () {
            var input = document.getElementById(btn.getAttribute('data-target'));
            if (input.type === 'password') {
                input.type = 'text';
                icona.src = btn.getAttribute('data-icona-nascondi');
                btn.setAttribute('aria-label', 'Nascondi password');
            } else {
                input.type = 'password';
                icona.src = btn.getAttribute('data-icona-mostra');
                btn.setAttribute('aria-label', 'Mostra password');
            }
        });
    });

    var ctx = document.getElementById('formLogin').action.replace(/\/auth$/, '');
    var suEmail = document.getElementById('suEmail');
    var suUsername = document.getElementById('suUsername');
    var checkTimer = null;

    function getOrCreateInline(input, id) {
        var el = document.getElementById(id);
        if (!el) {
            el = document.createElement('span');
            el.id = id;
            el.className = 'auth-inline-msg';
            input.parentNode.insertBefore(el, input.nextSibling);
        }
        return el;
    }

    function checkDisponibilita(input, tipo) {
        var valore = input.value.trim();
        var msgId = 'msg-' + tipo;
        var msg = getOrCreateInline(input, msgId);

        if (!valore) {
            msg.textContent = '';
            msg.className = 'auth-inline-msg';
            return;
        }

        var params = tipo === 'email' ? 'email=' + encodeURIComponent(valore) : 'username=' + encodeURIComponent(valore);
        var xhr = new XMLHttpRequest();
        xhr.open('GET', ctx + '/auth/check-email?' + params);
        xhr.onload = function () {
            if (xhr.status === 200) {
                var data = JSON.parse(xhr.responseText);
                if (data.disponibile) {
                    msg.textContent = tipo === 'email' ? 'Email disponibile' : 'Username disponibile';
                    msg.className = 'auth-inline-msg auth-inline-msg--ok';
                } else {
                    msg.textContent = tipo === 'email' ? 'Email già in uso' : 'Username già in uso';
                    msg.className = 'auth-inline-msg auth-inline-msg--errore';
                }
            }
        };
        xhr.send();
    }

    function debouncedCheck(input, tipo) {
        clearTimeout(checkTimer);
        checkTimer = setTimeout(function () {
            checkDisponibilita(input, tipo);
        }, 400);
    }

    if (suEmail) suEmail.addEventListener('input', function () { debouncedCheck(suEmail, 'email'); });
    if (suUsername) suUsername.addEventListener('input', function () { debouncedCheck(suUsername, 'username'); });
})();
