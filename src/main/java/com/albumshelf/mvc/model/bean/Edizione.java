package com.albumshelf.mvc.model.bean;

public class Edizione {

	private int idEdizione;
	private Integer annoStampa;
	private String formato;
	private String etichetta;
	private String paese;
	private int idAlbum;
	private String nomeAlbum;

	public Edizione() {}

	public int getIdEdizione() { return idEdizione; }
	public void setIdEdizione(int idEdizione) { this.idEdizione = idEdizione; }

	public Integer getAnnoStampa() { return annoStampa; }
	public void setAnnoStampa(Integer annoStampa) { this.annoStampa = annoStampa; }

	public String getFormato() { return formato; }
	public void setFormato(String formato) { this.formato = formato; }

	public String getEtichetta() { return etichetta; }
	public void setEtichetta(String etichetta) { this.etichetta = etichetta; }

	public String getPaese() { return paese; }
	public void setPaese(String paese) { this.paese = paese; }

	public int getIdAlbum() { return idAlbum; }
	public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

}
