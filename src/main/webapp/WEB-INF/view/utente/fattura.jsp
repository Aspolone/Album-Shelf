<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="com.albumshelf.mvc.model.bean.*" %>
<%@ page import="com.albumshelf.mvc.util.FormatUtil" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fattura - AlbumShelf</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/logo-noback.png">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #1a1a1a;
            background: #f5f5f5;
            line-height: 1.6;
        }

        .fattura {
            max-width: 800px;
            margin: 40px auto;
            background: #ffffff;
            padding: 60px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.08);
        }

        .fattura-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 48px;
            padding-bottom: 24px;
            border-bottom: 3px solid #14181c;
        }

        .fattura-brand h1 {
            font-size: 1.8rem;
            letter-spacing: 2px;
            color: #14181c;
        }

        .fattura-brand p {
            font-size: 0.8rem;
            color: #738494;
            letter-spacing: 1px;
        }

        .fattura-numero {
            text-align: right;
        }

        .fattura-numero h2 {
            font-size: 1.4rem;
            letter-spacing: 2px;
            color: #14181c;
            text-transform: uppercase;
        }

        .fattura-numero p {
            font-size: 0.85rem;
            color: #738494;
            margin-top: 4px;
        }

        .fattura-parti {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }

        .fattura-parte h3 {
            font-size: 0.7rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: #738494;
            margin-bottom: 8px;
        }

        .fattura-parte p {
            font-size: 0.9rem;
            color: #1a1a1a;
            line-height: 1.8;
        }

        .fattura-tabella {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 32px;
        }

        .fattura-tabella thead th {
            font-size: 0.7rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #738494;
            text-align: left;
            padding: 12px 16px;
            border-bottom: 2px solid #14181c;
        }

        .fattura-tabella thead th:last-child {
            text-align: right;
        }

        .fattura-tabella tbody td {
            padding: 14px 16px;
            font-size: 0.9rem;
            border-bottom: 1px solid #e5e5e5;
            vertical-align: top;
        }

        .fattura-tabella tbody td:last-child {
            text-align: right;
            white-space: nowrap;
        }

        .fattura-tabella .articolo-nome {
            font-weight: 600;
        }

        .fattura-tabella .articolo-formato {
            font-size: 0.8rem;
            color: #738494;
        }

        .fattura-totali {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 48px;
        }

        .fattura-totali-box {
            width: 280px;
        }

        .fattura-totali-riga {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 0.9rem;
            color: #1a1a1a;
        }

        .fattura-totali-riga--totale {
            border-top: 2px solid #14181c;
            margin-top: 8px;
            padding-top: 12px;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .fattura-pagamento {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            padding-top: 32px;
            border-top: 1px solid #e5e5e5;
            margin-bottom: 40px;
        }

        .fattura-pagamento h3 {
            font-size: 0.7rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: #738494;
            margin-bottom: 8px;
        }

        .fattura-pagamento p {
            font-size: 0.85rem;
            color: #1a1a1a;
            line-height: 1.8;
        }

        .fattura-footer {
            text-align: center;
            padding-top: 24px;
            border-top: 1px solid #e5e5e5;
        }

        .fattura-footer p {
            font-size: 0.75rem;
            color: #738494;
            letter-spacing: 1px;
        }

        .fattura-azioni {
            text-align: center;
            margin: 24px auto 40px;
        }

        .fattura-btn-stampa {
            display: inline-block;
            padding: 12px 32px;
            font-family: inherit;
            font-size: 0.85rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #ffffff;
            background-color: #14181c;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.18s;
        }

        .fattura-btn-stampa:hover {
            background-color: #2c3440;
        }

        .fattura-btn-indietro {
            display: inline-block;
            margin-left: 12px;
            padding: 12px 32px;
            font-size: 0.85rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #738494;
            border: 1px solid #738494;
            border-radius: 4px;
            text-decoration: none;
            transition: color 0.18s, border-color 0.18s;
        }

        .fattura-btn-indietro:hover {
            color: #1a1a1a;
            border-color: #1a1a1a;
        }

        @media print {
            body {
                background: none;
            }

            .fattura {
                max-width: none;
                margin: 0;
                padding: 20mm;
                box-shadow: none;
            }

            .fattura-azioni {
                display: none;
            }

            .fattura-header {
                border-bottom-color: #000000;
            }

            .fattura-tabella thead th {
                border-bottom-color: #000000;
            }

            .fattura-totali-riga--totale {
                border-top-color: #000000;
            }

            .fattura-tabella tbody td {
                border-bottom-color: #cccccc;
            }

            @page {
                size: A4;
                margin: 10mm;
            }
        }

        @media (max-width: 600px) {
            .fattura {
                margin: 0;
                padding: 24px 16px;
            }

            .fattura-header {
                flex-direction: column;
                gap: 16px;
            }

            .fattura-numero {
                text-align: left;
            }

            .fattura-parti,
            .fattura-pagamento {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .fattura-tabella thead th,
            .fattura-tabella tbody td {
                padding: 10px 8px;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>

<%
    Ordine ordine = (Ordine) request.getAttribute("ordine");
    Collection<RigaOrdine> righe = (Collection<RigaOrdine>) request.getAttribute("righeOrdine");
    Utente utenteProfilo = (Utente) request.getAttribute("utenteProfilo");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    String dataOrdine = sdf.format(ordine.getDataOrdine());

    BigDecimal subtotale = BigDecimal.ZERO;
    for (RigaOrdine r : righe) {
        subtotale = subtotale.add(r.getPrezzoStorico());
    }

    RigaOrdine primaRiga = righe.iterator().next();
    BigDecimal aliquotaIva = primaRiga.getIvaStorica();
    BigDecimal iva = subtotale.multiply(aliquotaIva)
            .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
    BigDecimal totale = subtotale.add(iva);

    String numFattura = "AS-" + ordine.getIdOrdine() + "-" + String.format("%tY", ordine.getDataOrdine());
%>

<div class="fattura-azioni">
    <button class="fattura-btn-stampa" onclick="window.print()">Stampa / Salva PDF</button>
    <a href="${pageContext.request.contextPath}/profilo" class="fattura-btn-indietro">Torna al profilo</a>
</div>

<div class="fattura">

    <header class="fattura-header">
        <div class="fattura-brand">
            <h1>ALBUMSHELF</h1>
            <p>Marketplace dischi fisici</p>
            <p>AlbumShelf S.r.l. &mdash; P.IVA IT00000000000</p>
        </div>
        <div class="fattura-numero">
            <h2>Fattura</h2>
            <p>N. <%= numFattura %></p>
            <p>Data: <%= dataOrdine %></p>
        </div>
    </header>

    <div class="fattura-parti">
        <div class="fattura-parte">
            <h3>Venditore</h3>
            <p>
                AlbumShelf S.r.l.<br>
                Via della Musica 42<br>
                00100 Roma (RM), Italia<br>
                info@albumshelf.com
            </p>
        </div>
        <div class="fattura-parte">
            <h3>Acquirente</h3>
            <p>
                <%= utenteProfilo.getNomeUtente() %><br>
                <%= utenteProfilo.getEmail() %><br>
                <% if (utenteProfilo.getNazione() != null) { %>
                    <%= utenteProfilo.getNazione() %>
                <% } %>
            </p>
        </div>
    </div>

    <table class="fattura-tabella">
        <thead>
            <tr>
                <th>Articolo</th>
                <th>Formato</th>
                <th>IVA</th>
                <th>Importo</th>
            </tr>
        </thead>
        <tbody>
            <% for (RigaOrdine r : righe) { %>
            <tr>
                <td>
                    <span class="articolo-nome"><%= r.getNomeAlbum() != null ? r.getNomeAlbum() : "Articolo" %></span>
                </td>
                <td><%= r.getFormato() != null ? r.getFormato() : "-" %></td>
                <td><%= r.getIvaStorica() %>%</td>
                <td><%= FormatUtil.formatPrezzo(r.getPrezzoStorico()) %></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="fattura-totali">
        <div class="fattura-totali-box">
            <div class="fattura-totali-riga">
                <span>Subtotale</span>
                <span><%= FormatUtil.formatPrezzo(subtotale) %></span>
            </div>
            <div class="fattura-totali-riga">
                <span>IVA (<%= aliquotaIva %>%)</span>
                <span><%= FormatUtil.formatPrezzo(iva) %></span>
            </div>
            <div class="fattura-totali-riga fattura-totali-riga--totale">
                <span>Totale</span>
                <span><%= FormatUtil.formatPrezzo(totale) %></span>
            </div>
        </div>
    </div>

    <div class="fattura-pagamento">
        <div>
            <h3>Metodo di pagamento</h3>
            <p>
                Pagamento online<br>
                Transazione confermata il <%= dataOrdine %><br>
                Riferimento: ORD-<%= ordine.getIdOrdine() %>
            </p>
        </div>
        <div>
            <h3>Stato ordine</h3>
            <p>
                Stato: <%= ordine.getStatoOrdine().substring(0, 1).toUpperCase() + ordine.getStatoOrdine().substring(1) %><br>
                Ordine n. <%= ordine.getIdOrdine() %>
            </p>
        </div>
    </div>

    <footer class="fattura-footer">
        <p>Documento generato automaticamente da AlbumShelf &mdash; non ha valore fiscale</p>
        <p>AlbumShelf S.r.l. &mdash; Capitale sociale &euro; 10.000 i.v. &mdash; REA RM-000000</p>
    </footer>

</div>

</body>
</html>
