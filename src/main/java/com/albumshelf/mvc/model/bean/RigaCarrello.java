package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

public class RigaCarrello {         

	private int idEsemplare;
	private String nomeAlbum;
	private String fileCopertina;
	private String formato;
	private String condizioneDisco;
	private String nomeVenditore;
	private BigDecimal prezzo;

	public RigaCarrello() {}

	public int getIdEsemplare() { return idEsemplare; }
	public void setIdEsemplare(int idEsemplare) { this.idEsemplare = idEsemplare; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

	public String getFileCopertina() { return fileCopertina; }
	public void setFileCopertina(String fileCopertina) { this.fileCopertina = fileCopertina; }

	public String getFormato() { return formato; }
	public void setFormato(String formato) { this.formato = formato; }

	public String getCondizioneDisco() { return condizioneDisco; }
	public void setCondizioneDisco(String condizioneDisco) { this.condizioneDisco = condizioneDisco; }

	public String getNomeVenditore() { return nomeVenditore; }
	public void setNomeVenditore(String nomeVenditore) { this.nomeVenditore = nomeVenditore; }

	public BigDecimal getPrezzo() { return prezzo; }
	public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }
}