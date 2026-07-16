package main.java.com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Ordine {
    private int idOrdine;
    private Timestamp dataOrdine;
    private BigDecimal totalePagato;
    private String statoOrdine;
    private Integer votoFeedback;     // opzionale
    private String commentoFeedback;  // opzionale
    private int idUtente;
    private List<RigaOrdine> righe;   // popolata dal DAO quando serve il dettaglio completo

    public Ordine() {}

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public Timestamp getDataOrdine() { return dataOrdine; }
    public void setDataOrdine(Timestamp dataOrdine) { this.dataOrdine = dataOrdine; }

    public BigDecimal getTotalePagato() { return totalePagato; }
    public void setTotalePagato(BigDecimal totalePagato) { this.totalePagato = totalePagato; }

    public String getStatoOrdine() { return statoOrdine; }
    public void setStatoOrdine(String statoOrdine) { this.statoOrdine = statoOrdine; }

    public Integer getVotoFeedback() { return votoFeedback; }
    public void setVotoFeedback(Integer votoFeedback) { this.votoFeedback = votoFeedback; }

    public String getCommentoFeedback() { return commentoFeedback; }
    public void setCommentoFeedback(String c) { this.commentoFeedback = c; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public List<RigaOrdine> getRighe() { return righe; }
    public void setRighe(List<RigaOrdine> righe) { this.righe = righe; }
}