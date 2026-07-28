package com.albumshelf.mvc.model.bean;

import java.sql.Date;

public class Componente {

	private int idComponente;
	private String nome;
	private String cognome;
	private Date dataNascita;
	private Date dataMorte;
	private String strumento;

	public Componente() {}

	public int getIdComponente() { return idComponente; }
	public void setIdComponente(int idComponente) { this.idComponente = idComponente; }

	public String getNome() { return nome; }
	public void setNome(String nome) { this.nome = nome; }

	public String getCognome() { return cognome; }
	public void setCognome(String cognome) { this.cognome = cognome; }

	public Date getDataNascita() { return dataNascita; }
	public void setDataNascita(Date dataNascita) { this.dataNascita = dataNascita; }

	public Date getDataMorte() { return dataMorte; }
	public void setDataMorte(Date dataMorte) { this.dataMorte = dataMorte; }

	public String getStrumento() { return strumento; }
	public void setStrumento(String strumento) { this.strumento = strumento; }

}
