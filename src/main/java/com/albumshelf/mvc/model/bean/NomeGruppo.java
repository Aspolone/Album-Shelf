package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class NomeGruppo {
    private int idGruppo;
    private String nome;
    private Date dataInizio;
    private Date dataFine; // opzionale, NULL se è il nome attuale

    public NomeGruppo() {}

    public int getIdGruppo() { return idGruppo; }
    public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Date getDataInizio() { return dataInizio; }
    public void setDataInizio(Date dataInizio) { this.dataInizio = dataInizio; }

    public Date getDataFine() { return dataFine; }
    public void setDataFine(Date dataFine) { this.dataFine = dataFine; }
}