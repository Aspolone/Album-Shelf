package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

public class Esemplare {

	private int idEsemplare;
	private BigDecimal prezzo;
	private String condizioneDisco;
	private String condizioneConfezione;
	private boolean impellicolato;
	private int idEdizione;
	private int idUtente;
	private boolean disponibile;
	private String nomeVenditore;
	private String nomeAlbum;
	private String fileCopertina;
	private String formato;
	private int idAlbum;

	public Esemplare() {}

	public int getIdEsemplare() { return idEsemplare; }
	public void setIdEsemplare(int idEsemplare) { this.idEsemplare = idEsemplare; }

	public BigDecimal getPrezzo() { return prezzo; }
	public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }

	public String getCondizioneDisco() { return condizioneDisco; }
	public void setCondizioneDisco(String condizioneDisco) { this.condizioneDisco = condizioneDisco; }

	public String getCondizioneConfezione() { return condizioneConfezione; }
	public void setCondizioneConfezione(String condizioneConfezione) { this.condizioneConfezione = condizioneConfezione; }

	public boolean isImpellicolato() { return impellicolato; }
	public void setImpellicolato(boolean impellicolato) { this.impellicolato = impellicolato; }

	public int getIdEdizione() { return idEdizione; }
	public void setIdEdizione(int idEdizione) { this.idEdizione = idEdizione; }

	public int getIdUtente() { return idUtente; }
	public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

	public boolean isDisponibile() { return disponibile; }
	public void setDisponibile(boolean disponibile) { this.disponibile = disponibile; }

	public String getNomeVenditore() { return nomeVenditore; }
	public void setNomeVenditore(String nomeVenditore) { this.nomeVenditore = nomeVenditore; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

	public String getFileCopertina() { return fileCopertina; }
	public void setFileCopertina(String fileCopertina) { this.fileCopertina = fileCopertina; }

	public String getFormato() { return formato; }
	public void setFormato(String formato) { this.formato = formato; }

	public int getIdAlbum() { return idAlbum; }
	public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

}
