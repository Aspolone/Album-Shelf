package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Componente {
    private int idComponente;
    private String nome;
    private String cognome;
    private String titolo;
    private Date dataNascita;
    private Date dataMorte;      // opzionale
    private String strumento;    // opzionale

    public Componente() {}

    public int getIdComponente() { return idComponente; }
    public void setIdComponente(int idComponente) { this.idComponente = idComponente; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }

    public Date getDataNascita() { return dataNascita; }
    public void setDataNascita(Date dataNascita) { this.dataNascita = dataNascita; }

    public Date getDataMorte() { return dataMorte; }
    public void setDataMorte(Date dataMorte) { this.dataMorte = dataMorte; }

    public String getStrumento() { return strumento; }
    public void setStrumento(String strumento) { this.strumento = strumento; }
}