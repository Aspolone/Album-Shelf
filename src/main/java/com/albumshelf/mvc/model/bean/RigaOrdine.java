package main.java.com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;

public class RigaOrdine {
    private int idRigaOrdine;
    private int idOrdine;
    private Integer idEsemplare; // nullable: può diventare NULL se il venditore cancella l'esemplare
    private BigDecimal prezzoStorico;
    private BigDecimal ivaStorica;
    private int quantita;

    public RigaOrdine() {}

    public int getIdRigaOrdine() { return idRigaOrdine; }
    public void setIdRigaOrdine(int idRigaOrdine) { this.idRigaOrdine = idRigaOrdine; }

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public Integer getIdEsemplare() { return idEsemplare; }
    public void setIdEsemplare(Integer idEsemplare) { this.idEsemplare = idEsemplare; }

    public BigDecimal getPrezzoStorico() { return prezzoStorico; }
    public void setPrezzoStorico(BigDecimal p) { this.prezzoStorico = p; }

    public BigDecimal getIvaStorica() { return ivaStorica; }
    public void setIvaStorica(BigDecimal ivaStorica) { this.ivaStorica = ivaStorica; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }
}