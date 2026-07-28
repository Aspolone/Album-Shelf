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
})();