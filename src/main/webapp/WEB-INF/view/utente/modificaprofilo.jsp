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

        <form action="${pageContext.request.contextPath}/modificaprofilo"
              method="post" class="form-vendi">

            <fieldset class="form-sezione">
                <legend class="nastro">Informazioni personali</legend>
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
            </fieldset>

            <button type="submit" class="form-submit">Salva modifiche</button>

        </form>

        <form action="${pageContext.request.contextPath}/modificaprofilo"
              method="post" class="form-vendi">
            <input type="hidden" name="azione" value="cambiapassword">

            <fieldset class="form-sezione">
                <legend class="nastro">Cambia password</legend>
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
            </fieldset>

            <button type="submit" class="form-submit">Aggiorna password</button>

        </form>

        <div class="form-pericolo">
            <h2 class="form-pericolo-titolo">Elimina account</h2>
            <p class="form-pericolo-testo">
                L'eliminazione è permanente. Tutti i tuoi esemplari
                verranno rimossi dal catalogo e i tuoi dati cancellati.
            </p>
            <form action="${pageContext.request.contextPath}/modificaprofilo"
                  method="post"
                  onsubmit="return confirm('Sei sicuro di voler eliminare il tuo account? Questa azione è irreversibile.');">
                <input type="hidden" name="azione" value="elimina">
                <button type="submit" class="form-submit form-submit--pericolo">Elimina il mio account</button>
            </form>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>