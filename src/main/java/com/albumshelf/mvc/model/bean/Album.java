package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;
import java.sql.Date;

// mappa la tabella album
public class Album {

	private int idAlbum;
	private String nomeAlbum;
	private String nazione;
	private String tipo;
	private Date dataRilascio;
	private Date dataInizioRegistrazione;
	private Date dataFineRegistrazione;
	private String nomeAutoreCopertina;
	private String fileCopertina;
	private String descrittori;
	private int idGruppo;
	private int idCasaDiscografica;
	private int visite;
	private String nomeGruppo;
	private String nomeCasaDiscografica;
	private BigDecimal mediaVoto;
	private int numeroRecensioni;

	public Album() {}

	public int getIdAlbum() { return idAlbum; }
	public void setIdAlbum(int idAlbum) { this.idAlbum = idAlbum; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

	public String getNazione() { return nazione; }
	public void setNazione(String nazione) { this.nazione = nazione; }

	public String getTipo() { return tipo; }
	public void setTipo(String tipo) { this.tipo = tipo; }

	public Date getDataRilascio() { return dataRilascio; }
	public void setDataRilascio(Date dataRilascio) { this.dataRilascio = dataRilascio; }

	public Date getDataInizioRegistrazione() { return dataInizioRegistrazione; }
	public void setDataInizioRegistrazione(Date dataInizioRegistrazione) { this.dataInizioRegistrazione = dataInizioRegistrazione; }

	public Date getDataFineRegistrazione() { return dataFineRegistrazione; }
	public void setDataFineRegistrazione(Date dataFineRegistrazione) { this.dataFineRegistrazione = dataFineRegistrazione; }

	public String getNomeAutoreCopertina() { return nomeAutoreCopertina; }
	public void setNomeAutoreCopertina(String nomeAutoreCopertina) { this.nomeAutoreCopertina = nomeAutoreCopertina; }

	public String getFileCopertina() { return fileCopertina; }
	public void setFileCopertina(String fileCopertina) { this.fileCopertina = fileCopertina; }

	public String getDescrittori() { return descrittori; }
	public void setDescrittori(String descrittori) { this.descrittori = descrittori; }

	public int getIdGruppo() { return idGruppo; }
	public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

	public int getIdCasaDiscografica() { return idCasaDiscografica; }
	public void setIdCasaDiscografica(int idCasaDiscografica) { this.idCasaDiscografica = idCasaDiscografica; }

	public int getVisite() { return visite; }
	public void setVisite(int visite) { this.visite = visite; }

	public String getNomeGruppo() { return nomeGruppo; }
	public void setNomeGruppo(String nomeGruppo) { this.nomeGruppo = nomeGruppo; }

	public String getNomeCasaDiscografica() { return nomeCasaDiscografica; }
	public void setNomeCasaDiscografica(String nomeCasaDiscografica) { this.nomeCasaDiscografica = nomeCasaDiscografica; }

	public BigDecimal getMediaVoto() { return mediaVoto; }
	public void setMediaVoto(BigDecimal mediaVoto) { this.mediaVoto = mediaVoto; }

	public int getNumeroRecensioni() { return numeroRecensioni; }
	public void setNumeroRecensioni(int numeroRecensioni) { this.numeroRecensioni = numeroRecensioni; }

}
