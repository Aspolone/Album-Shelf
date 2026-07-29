package com.albumshelf.mvc.model.bean;

public class RisultatoRicerca {

	private String tipo;     
	private String titolo;
	private String sottotitolo;
	private String url; 

	public RisultatoRicerca() {}

	public RisultatoRicerca(String tipo, String titolo, String sottotitolo, String url) {
		this.tipo = tipo;
		this.titolo = titolo;
		this.sottotitolo = sottotitolo;
		this.url = url;
	}

	public String getTipo() { return tipo; }
	public void setTipo(String tipo) { this.tipo = tipo; }

	public String getTitolo() { return titolo; }
	public void setTitolo(String titolo) { this.titolo = titolo; }

	public String getSottotitolo() { return sottotitolo; }
	public void setSottotitolo(String sottotitolo) { this.sottotitolo = sottotitolo; }

	public String getUrl() { return url; }
	public void setUrl(String url) { this.url = url; }
}