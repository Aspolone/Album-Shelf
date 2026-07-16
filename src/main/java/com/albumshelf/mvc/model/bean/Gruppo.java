package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Gruppo {
    private int idGruppo;
    private Date dataCreazione;
    private String nazione;
    private Date dataScioglimento; // opzionale
    private String nomeAttuale;     // comodo da avere qui, letto da nome_gruppo con data_fine NULL

    public Gruppo() {}

    public int getIdGruppo() { return idGruppo; }
    public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

    public Date getDataCreazione() { return dataCreazione; }
    public void setDataCreazione(Date dataCreazione) { this.dataCreazione = dataCreazione; }

    public String getNazione() { return nazione; }
    public void setNazione(String nazione) { this.nazione = nazione; }

    public Date getDataScioglimento() { return dataScioglimento; }
    public void setDataScioglimento(Date dataScioglimento) { this.dataScioglimento = dataScioglimento; }

    public String getNomeAttuale() { return nomeAttuale; }
    public void setNomeAttuale(String nomeAttuale) { this.nomeAttuale = nomeAttuale; }
}