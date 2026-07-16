package main.java.com.albumshelf.mvc.model.bean;

public class Genere {
    private String genere;      // è la PK stessa, come da schema ER
    private String descrizione;

    public Genere() {}

    public String getGenere() { return genere; }
    public void setGenere(String genere) { this.genere = genere; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
}