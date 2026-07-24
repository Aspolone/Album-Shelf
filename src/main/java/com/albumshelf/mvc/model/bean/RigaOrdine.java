package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

// mappa la tabella riga_ordine
public class RigaOrdine {

	private int idRigaOrdine;
	private int idOrdine;
	private Integer idEsemplare;
	private BigDecimal prezzoStorico;
	private BigDecimal ivaStorica;
	private String nomeAlbum;
	private String fileCopertina;
	private String formato;

	public RigaOrdine() {}

	public int getIdRigaOrdine() { return idRigaOrdine; }
	public void setIdRigaOrdine(int idRigaOrdine) { this.idRigaOrdine = idRigaOrdine; }

	public int getIdOrdine() { return idOrdine; }
	public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

	public Integer getIdEsemplare() { return idEsemplare; }
	public void setIdEsemplare(Integer idEsemplare) { this.idEsemplare = idEsemplare; }

	public BigDecimal getPrezzoStorico() { return prezzoStorico; }
	public void setPrezzoStorico(BigDecimal prezzoStorico) { this.prezzoStorico = prezzoStorico; }

	public BigDecimal getIvaStorica() { return ivaStorica; }
	public void setIvaStorica(BigDecimal ivaStorica) { this.ivaStorica = ivaStorica; }

	public String getNomeAlbum() { return nomeAlbum; }
	public void setNomeAlbum(String nomeAlbum) { this.nomeAlbum = nomeAlbum; }

	public String getFileCopertina() { return fileCopertina; }
	public void setFileCopertina(String fileCopertina) { this.fileCopertina = fileCopertina; }

	public String getFormato() { return formato; }
	public void setFormato(String formato) { this.formato = formato; }

}
