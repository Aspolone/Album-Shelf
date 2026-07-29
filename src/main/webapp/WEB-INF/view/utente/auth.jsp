<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accedi o registrati - AlbumShelf</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/logo-noback.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body class="auth-body">

<div class="auth-page">
    <div class="auth-groove auth-groove-1"></div>
    <div class="auth-groove auth-groove-2"></div>
    <div class="auth-groove auth-groove-3"></div>

    <div class="auth-wrap">


        <div class="auth-card">
			
        <div class="auth-brand">
            <a href="${pageContext.request.contextPath}/" class="auth-logo-link">
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="" class="auth-logo-img">
                <span class="auth-logo-text">AlbumShelf</span>
            </a>
            <p class="auth-slogan">La tua musica, le tue regole</p>
        </div>
            
            <div class="auth-error" style="${empty errorMessage ? 'display:none;' : ''}">${errorMessage}</div>

            <div class="auth-tabs">
                <div class="auth-tab-thumb" id="authThumb"></div>
                <button type="button" class="auth-tab active" id="tabLogin">Accedi</button>
                <button type="button" class="auth-tab" id="tabSignup">Registrati</button>
            </div>

           
            <form class="auth-form" id="formLogin" action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="login">

                <label for="loginId">Username o email</label>
                <input type="text" id="loginId" name="usernameOrEmail" placeholder="keresael@proton.me" required autocomplete="username">

                <label for="loginPwd">Password</label>
                <div class="auth-pwd-wrap">
                    <input type="password" id="loginPwd" name="password" placeholder="********" required autocomplete="current-password">
                    <button type="button" class="auth-eye" aria-label="Mostra password" data-target="loginPwd"
                            data-icona-mostra="${pageContext.request.contextPath}/img/icons-eye.png"
                            data-icona-nascondi="${pageContext.request.contextPath}/img/icons-eye-off.png">
                        <img class="auth-eye-icona" src="${pageContext.request.contextPath}/img/icons-eye.png"
                             alt="" aria-hidden="true">
                    </button>
                </div>

                <button type="submit" class="auth-cta">Accedi</button>
            </form>

            
            <form class="auth-form" id="formSignup" action="${pageContext.request.contextPath}/auth" method="post" style="display:none;">
                <input type="hidden" name="action" value="register">

                <label for="suUsername">Nome utente</label>
                <input type="text" id="suUsername" name="username" placeholder="Keresael" required
                       autocomplete="username"
                       pattern="[A-Za-z0-9_]{3,30}"
                       title="3-30 caratteri: lettere, cifre e underscore.">

                <label for="suEmail">Email</label>
                <input type="email" id="suEmail" name="email" placeholder="keresael@proton.me" required
                       autocomplete="email"
                       pattern="[^\s@]+@[^\s@]+\.[^\s@]{2,}"
                       title="Inserisci un indirizzo email valido.">

                <label for="suPwd">Password</label>
                <div class="auth-pwd-wrap">
                    <input type="password" id="suPwd" name="password" placeholder="********" required
                           autocomplete="new-password"
                           minlength="8"
                           pattern="(?=.*[A-Za-z])(?=.*\d).{8,}"
                           title="Minimo 8 caratteri, almeno una lettera e una cifra.">
                    <button type="button" class="auth-eye" aria-label="Mostra password" data-target="suPwd"
                            data-icona-mostra="${pageContext.request.contextPath}/img/icons-eye.png"
                            data-icona-nascondi="${pageContext.request.contextPath}/img/icons-eye-off.png">
                        <img class="auth-eye-icona" src="${pageContext.request.contextPath}/img/icons-eye.png"
                             alt="" aria-hidden="true">
                    </button>
                </div>

                <button type="submit" class="auth-cta">Crea account</button>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/auth.js"></script>
</body>
</html>
