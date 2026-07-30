<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.albumshelf.mvc.model.bean.Utente" %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">

<%
    Utente utenteProfilo = (Utente) request.getAttribute("utenteProfilo");
%>

<main class="pagina">
    <div class="form-pagina">

        <header class="info-header">
            <p class="info-eyebrow">Il tuo account</p>
            <h1>Modifica profilo</h1>
            <p class="info-lead">
                Aggiorna le informazioni del tuo account.
                I campi con * sono obbligatori.
            </p>
        </header>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="form-messaggio form-messaggio--errore">${errorMessage}</p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
        <p class="form-messaggio form-messaggio--ok">${successMessage}</p>
        <% } %>

        <form action="${pageContext.request.contextPath}/modificaprofilo"
              method="post" class="form-vendi">

            <section class="form-sezione">
                <h2 class="nastro">Informazioni personali</h2>
                <div class="form-griglia">
                    <div class="form-campo">
                        <label for="nomeUtente">Nome utente *</label>
                        <input type="text" id="nomeUtente" name="nomeUtente"
                               value="<%= utenteProfilo.getNomeUtente() %>" required>
                    </div>
                    <div class="form-campo">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email"
                               value="<%= utenteProfilo.getEmail() %>" required>
                    </div>
                    <div class="form-campo">
                        <label for="nazione">Nazione</label>
                        <input type="text" id="nazione" name="nazione"
                               value="<%= utenteProfilo.getNazione() != null ? utenteProfilo.getNazione() : "" %>"
                               placeholder="es. Italia">
                    </div>
                    <div class="form-campo form-campo--intero">
                        <label for="descrizione">Descrizione</label>
                        <textarea id="descrizione" name="descrizione" rows="4"
                                  placeholder="Racconta qualcosa di te e della tua collezione..."><%= utenteProfilo.getDescrizione() != null ? utenteProfilo.getDescrizione() : "" %></textarea>
                    </div>
                </div>
            </section>

            <button type="submit" class="form-submit">Salva modifiche</button>

        </form>

        <form action="${pageContext.request.contextPath}/modificaprofilo"
              method="post" class="form-vendi">
            <input type="hidden" name="azione" value="cambiapassword">

            <section class="form-sezione">
                <h2 class="nastro">Cambia password</h2>
                <div class="form-griglia">
                    <div class="form-campo form-campo--intero">
                        <label for="passwordAttuale">Password attuale *</label>
                        <input type="password" id="passwordAttuale" name="passwordAttuale" required>
                    </div>
                    <div class="form-campo">
                        <label for="nuovaPassword">Nuova password *</label>
                        <input type="password" id="nuovaPassword" name="nuovaPassword" required>
                    </div>
                    <div class="form-campo">
                        <label for="confermaPassword">Conferma nuova password *</label>
                        <input type="password" id="confermaPassword" name="confermaPassword" required>
                    </div>
                </div>
            </section>

            <button type="submit" class="form-submit">Aggiorna password</button>

        </form>

        <div class="form-pericolo">
            <h2 class="form-pericolo-titolo">Elimina account</h2>
            <p class="form-pericolo-testo">
                L'eliminazione è permanente. Tutti i tuoi esemplari
                verranno rimossi dal catalogo e i tuoi dati cancellati.
            </p>
            <button type="button" class="form-submit form-submit--pericolo" id="btn-mostra-elimina"
                    onclick="document.getElementById('conferma-elimina').style.display='block'; this.style.display='none';">
                Elimina il mio account
            </button>
            <div id="conferma-elimina" class="form-conferma-inline" style="display:none;">
                <p class="form-conferma-testo">Sei sicuro? Questa azione è irreversibile.</p>
                <div class="form-conferma-azioni">
                    <form action="${pageContext.request.contextPath}/modificaprofilo" method="post" style="display:inline;">
                        <input type="hidden" name="azione" value="elimina">
                        <button type="submit" class="form-submit form-submit--pericolo">Sì, elimina</button>
                    </form>
                    <button type="button" class="form-submit" style="background-color:#2c3440; color:#FFFFFF;"
                            onclick="document.getElementById('conferma-elimina').style.display='none'; document.getElementById('btn-mostra-elimina').style.display='inline-block';">
                        Annulla
                    </button>
                </div>
            </div>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>