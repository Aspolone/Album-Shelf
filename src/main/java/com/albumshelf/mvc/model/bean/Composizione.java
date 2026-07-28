package com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Composizione {

	private int idComponente;
	private int idGruppo;
	private Date dataIngresso;
	private Date dataUscita;
	private String ruolo;
	private String nomeComponente;
	private String cognomeComponente;
	private String nomeGruppo;

	public Composizione() {}

	public int getIdComponente() { return idComponente; }
	public void setIdComponente(int idComponente) { this.idComponente = idComponente; }

	public int getIdGruppo() { return idGruppo; }
	public void setIdGruppo(int idGruppo) { this.idGruppo = idGruppo; }

	public Date getDataIngresso() { return dataIngresso; }
	public void setDataIngresso(Date dataIngresso) { this.dataIngresso = dataIngresso; }

	public Date getDataUscita() { return dataUscita; }
	public void setDataUscita(Date dataUscita) { this.dataUscita = dataUscita; }

	public String getRuolo() { return ruolo; }
	public void setRuolo(String ruolo) { this.ruolo = ruolo; }

	public String getNomeComponente() { return nomeComponente; }
	public void setNomeComponente(String nomeComponente) { this.nomeComponente = nomeComponente; }

	public String getCognomeComponente() { return cognomeComponente; }
	public void setCognomeComponente(String cognomeComponente) { this.cognomeComponente = cognomeComponente; }

	public String getNomeGruppo() { return nomeGruppo; }
	public void setNomeGruppo(String nomeGruppo) { this.nomeGruppo = nomeGruppo; }

}
