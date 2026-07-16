package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Timestamp;

public class Recensione {
    private int idRecensione;
    private Timestamp dataRecensione;
    private int voto;
    private String commento;
    private int idUtente;
    private Integer idAlbum;   // Integer (non int) perché è nullable
    private Integer idCanzone; // idem

    public Recensione() {}

    public int getIdRecensione() { return idRecensione; }
    public void setIdRecensione(int idRecensione) { this.idRecensione = idRecensione; }

    public Timestamp getDataRecensione() { return dataRecensione; }
    public void setDataRecensione(Timestamp d) { this.dataRecensione = d; }

    public int getVoto() { return voto; }
    public void setVoto(int voto) { this.voto = voto; }

    public String getCommento() { return commento; }
    public void setCommento(String commento) { this.commento = commento; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public Integer getIdAlbum() { return idAlbum; }
    public void setIdAlbum(Integer idAlbum) { this.idAlbum = idAlbum; }

    public Integer getIdCanzone() { return idCanzone; }
    public void setIdCanzone(Integer idCanzone) { this.idCanzone = idCanzone; }
}