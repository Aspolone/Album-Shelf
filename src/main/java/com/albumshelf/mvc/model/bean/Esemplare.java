package main.java.com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

public class Esemplare {
    private int idEsemplare;
    private BigDecimal prezzo;
    private BigDecimal iva;
    private String condizioneSupporto;
    private String condizioneConfezione;
    private boolean impellicolato;
    private boolean attivo;
    private int idEdizione;
    private int idUtente; // venditore

    public Esemplare() {}

    public int getIdEsemplare() { return idEsemplare; }
    public void setIdEsemplare(int idEsemplare) { this.idEsemplare = idEsemplare; }

    public BigDecimal getPrezzo() { return prezzo; }
    public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }

    public BigDecimal getIva() { return iva; }
    public void setIva(BigDecimal iva) { this.iva = iva; }

    public String getCondizioneSupporto() { return condizioneSupporto; }
    public void setCondizioneSupporto(String c) { this.condizioneSupporto = c; }

    public String getCondizioneConfezione() { return condizioneConfezione; }
    public void setCondizioneConfezione(String c) { this.condizioneConfezione = c; }

    public boolean isImpellicolato() { return impellicolato; }
    public void setImpellicolato(boolean impellicolato) { this.impellicolato = impellicolato; }

    public boolean isAttivo() { return attivo; }
    public void setAttivo(boolean attivo) { this.attivo = attivo; }

    public int getIdEdizione() { return idEdizione; }
    public void setIdEdizione(int idEdizione) { this.idEdizione = idEdizione; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
}