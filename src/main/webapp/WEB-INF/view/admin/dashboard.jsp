<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("titoloPagina", "Admin"); %>
<% request.setAttribute("sezioneAdmin", "dashboard"); %>
<%@ include file="/WEB-INF/view/fragment/header.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

<div class="admin-shell">
    <%@ include file="/WEB-INF/view/admin/fragment/adminsidebar.jspf" %>

    <main class="admin-content">
        <h1 class="admin-titolo">Dashboard</h1>

        <div class="admin-kpi-griglia">
            <div class="admin-kpi">
                <div class="admin-kpi__label">Album totali</div>
                <div class="admin-kpi__valore">${totAlbum}</div>
            </div>
            <div class="admin-kpi">
                <div class="admin-kpi__label">Ordini totali</div>
                <div class="admin-kpi__valore">${totOrdini}</div>
            </div>
            <div class="admin-kpi">
                <div class="admin-kpi__label">Utenti registrati</div>
                <div class="admin-kpi__valore">${totUtenti}</div>
            </div>
            <div class="admin-kpi">
                <div class="admin-kpi__label">Recensioni</div>
                <div class="admin-kpi__valore">${totRecensioni}</div>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/view/fragment/footer.jspf" %>
