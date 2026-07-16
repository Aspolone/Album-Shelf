package main.java.com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Album {
    private int idAlbum;
    private String nomeAlbum;
    private String nazione;
    private Date dataRilascio;
    private Date dataInizioRegistrazione;
    private Date dataFineRegistrazione;
    private String tipo;
    private String nomeAutoreCopertina;
    private String fileCopertina;
    private String descrittori;
    private int idGruppo;
    private int idCasaDiscografica;

    public Album() {}

    public int getIdAlbum() { return idAlbum; }
    public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

    public String getNomeAlbum() { return nomeAlbum; }
    public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

    public String getNazione() { return nazione; }
    public void setNazione(String nazione) { this.nazione = nazione; }

    public Date getDataRilascio() { return dataRilascio; }
    public void setDataRilascio(Date dataRilascio) { this.dataRilascio = dataRilascio; }

    public Date getDataInizioRegistrazione() { return dataInizioRegistrazione; }
    public void setDataInizioRegistrazione(Date d) { this.dataInizioRegistrazione = d; }

    public Date getDataFineRegistrazione() { return dataFineRegistrazione; }
    public void setDataFineRegistrazione(Date d) { this.dataFineRegistrazione = d; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getNomeAutoreCopertina() { return nomeAutoreCopertina; }
    public void setNomeAutoreCopertina(String n) { this.nomeAutoreCopertina = n; }

    public String getFileCopertina() { return fileCopertina; }
    public void setFileCopertina(String fileCopertina) { this.fileCopertina = fileCopertina; }

    public String getDescrittori() { return descrittori; }
    public void setDescrittori(String descrittori) { this.descrittori = descrittori; }

    public int getIdGruppo() { return idGruppo; }
    public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

    public int getIdCasaDiscografica() { return idCasaDiscografica; }
    public void setIdCasaDiscografica(int id) { this.idCasaDiscografica = id; }
}