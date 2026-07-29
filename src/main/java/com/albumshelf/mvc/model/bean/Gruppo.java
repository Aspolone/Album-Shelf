package com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Gruppo {

	private int idGruppo;
	private String nome;
	private Date dataCreazione;
	private String nazione;
	private Date dataScioglimento;
	private String fileImmagine;
	private int visite;

	public Gruppo() {}

	public int getIdGruppo() { return idGruppo; }
	public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

	public String getNome() { return nome; }
	public void setNome(String nome) { this.nome = nome; }

	public Date getDataCreazione() { return dataCreazione; }
	public void setDataCreazione(Date dataCreazione) { this.dataCreazione = dataCreazione; }

	public String getNazione() { return nazione; }
	public void setNazione(String nazione) { this.nazione = nazione; }

	public Date getDataScioglimento() { return dataScioglimento; }
	public void setDataScioglimento(Date dataScioglimento) { this.dataScioglimento = dataScioglimento; }

	public String getFileImmagine() { return fileImmagine; }
	public void setFileImmagine(String fileImmagine) { this.fileImmagine = fileImmagine; }

	public int getVisite() { return visite; }
	public void setVisite(int visite) { this.visite = visite; }

}