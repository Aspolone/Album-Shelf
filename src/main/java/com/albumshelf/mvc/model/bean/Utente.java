package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Timestamp;

public class Utente {
    private int idUtente;
    private String nomeUtente;
    private String descrizione;
    private String nazione;
    private String email;
    private String password;  // hash, mai in chiaro
    private Timestamp dataIscrizione;
    private String ruolo;      // "cliente" oppure "admin"

    public Utente() {}

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public String getNomeUtente() { return nomeUtente; }
    public void setNomeUtente(String nomeUtente) { this.nomeUtente = nomeUtente; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public String getNazione() { return nazione; }
    public void setNazione(String nazione) { this.nazione = nazione; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Timestamp getDataIscrizione() { return dataIscrizione; }
    public void setDataIscrizione(Timestamp dataIscrizione) { this.dataIscrizione = dataIscrizione; }

    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }
}