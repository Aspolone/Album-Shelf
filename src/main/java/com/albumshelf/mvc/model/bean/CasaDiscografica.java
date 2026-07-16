package main.java.com.albumshelf.mvc.model.bean;

public class CasaDiscografica {
    private int idCasaDiscografica;
    private String nome;
    private String sede;

    public CasaDiscografica() {}

    public int getIdCasaDiscografica() { return idCasaDiscografica; }
    public void setIdCasaDiscografica(int id) { this.idCasaDiscografica = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getSede() { return sede; }
    public void setSede(String sede) { this.sede = sede; }
}