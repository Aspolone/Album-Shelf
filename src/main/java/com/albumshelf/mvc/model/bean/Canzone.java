package main.java.com.albumshelf.mvc.model.bean;

import java.util.List;

public class Canzone {
    private int idCanzone;
    private String nome;
    private String testo;
    private int durata; // secondi
    private int idAlbum;
    private List<String> generi; // popolata dal DAO tramite canzone_genere, non è una colonna diretta

    public Canzone() {}

    public int getIdCanzone() { return idCanzone; }
    public void setIdCanzone(int idCanzone) { this.idCanzone = idCanzone; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getTesto() { return testo; }
    public void setTesto(String testo) { this.testo = testo; }

    public int getDurata() { return durata; }
    public void setDurata(int durata) { this.durata = durata; }

    public int getIdAlbum() { return idAlbum; }
    public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

    public List<String> getGeneri() { return generi; }
    public void setGeneri(List<String> generi) { this.generi = generi; }
}