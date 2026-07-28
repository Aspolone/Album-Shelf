package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Ordine {

	private int idOrdine;
	private Timestamp dataOrdine;
	private BigDecimal totalePagato;
	private String statoOrdine;
	private int idUtente;

	public Ordine() {}

	public int getIdOrdine() { return idOrdine; }
	public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

	public Timestamp getDataOrdine() { return dataOrdine; }
	public void setDataOrdine(Timestamp dataOrdine) { this.dataOrdine = dataOrdine; }

	public BigDecimal getTotalePagato() { return totalePagato; }
	public void setTotalePagato(BigDecimal totalePagato) { this.totalePagato = totalePagato; }

	public String getStatoOrdine() { return statoOrdine; }
	public void setStatoOrdine(String statoOrdine) { this.statoOrdine = statoOrdine; }

	public int getIdUtente() { return idUtente; }
	public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

}
