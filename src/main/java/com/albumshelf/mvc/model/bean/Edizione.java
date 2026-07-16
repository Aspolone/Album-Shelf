package main.java.com.albumshelf.mvc.model.bean;

public class Edizione {
    private int idEdizione;
    private int annoStampa;
    private String formato; // vinile / cd / cassetta
    private String etichetta;
    private String paese;
    private int idAlbum;

    public Edizione() {}

    public int getIdEdizione() { return idEdizione; }
    public void setIdEdizione(int idEdizione) { this.idEdizione = idEdizione; }

    public int getAnnoStampa() { return annoStampa; }
    public void setAnnoStampa(int annoStampa) { this.annoStampa = annoStampa; }

    public String getFormato() { return formato; }
    public void setFormato(String formato) { this.formato = formato; }

    public String getEtichetta() { return etichetta; }
    public void setEtichetta(String etichetta) { this.etichetta = etichetta; }

    public String getPaese() { return paese; }
    public void setPaese(String paese) { this.paese = paese; }

    public int getIdAlbum() { return idAlbum; }
    public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }
}