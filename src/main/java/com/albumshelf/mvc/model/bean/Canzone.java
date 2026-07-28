package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

public class Canzone {

	private int idCanzone;
	private String nome;
	private String testo;
	private Integer durata;
	private int idAlbum;
	private int visite;
	private String nomeAlbum; //da recuperare tramite join (nei dao)
	private BigDecimal mediaVoto;

	public Canzone() {}

	public int getIdCanzone() { return idCanzone; }
	public void setIdCanzone(int idCanzone) { this.idCanzone = idCanzone; }

	public String getNome() { return nome; }
	public void setNome(String nome) { this.nome = nome; }

	public String getTesto() { return testo; }
	public void setTesto(String testo) { this.testo = testo; }

	public Integer getDurata() { return durata; }
	public void setDurata(Integer durata) { this.durata = durata; }

	public int getIdAlbum() { return idAlbum; }
	public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

	public int getVisite() { return visite; }
	public void setVisite(int visite) { this.visite = visite; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

	public BigDecimal getMediaVoto() { return mediaVoto; }
	public void setMediaVoto(BigDecimal mediaVoto) { this.mediaVoto = mediaVoto; }

}
