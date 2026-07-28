package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Recensione {
    private int idRecensione;
    private BigDecimal voto;
    private String commento;
    private Timestamp dataRecensione;
    private int idUtente;
    private Integer idAlbum;
    private Integer idCanzone;
    private String nomeUtente;
    private String nomeAlbum;
    private String nomeCanzone;

    public Recensione() {}

    public int getIdRecensione() { return idRecensione; }
    public void setIdRecensione(int idRecensione) { this.idRecensione = idRecensione; }
    public BigDecimal getVoto() { return voto; }
    public void setVoto(BigDecimal voto) { this.voto = voto; }
    public String getCommento() { return commento; }
    public void setCommento(String commento) { this.commento = commento; }
    public Timestamp getDataRecensione() { return dataRecensione; }
    public void setDataRecensione(Timestamp dataRecensione) { this.dataRecensione = dataRecensione; }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    public Integer getIdAlbum() { return idAlbum; }
    public void setIdAlbum(Integer idAlbum) { this.idAlbum = idAlbum; }
    public Integer getIdCanzone() { return idCanzone; }
    public void setIdCanzone(Integer idCanzone) { this.idCanzone = idCanzone; }
    public String getNomeUtente() { return nomeUtente; }
    public void setNomeUtente(String nomeUtente) { this.nomeUtente = nomeUtente; }
    public String getNomeAlbum() { return nomeAlbum; }
    public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }
    public String getNomeCanzone() { return nomeCanzone; }
    public void setNomeCanzone(String nomeCanzone) { this.nomeCanzone = nomeCanzone; }
}