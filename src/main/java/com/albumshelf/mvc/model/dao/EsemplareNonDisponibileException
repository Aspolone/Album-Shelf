package com.albumshelf.mvc.model.dao;

public class EsemplareNonDisponibileException extends Exception {

	private static final long serialVersionUID = 1L;

	private final int idEsemplare;

	public EsemplareNonDisponibileException(int idEsemplare) {
		super("L'esemplare " + idEsemplare + " non e' piu' disponibile.");
		this.idEsemplare = idEsemplare;
	}

	public int getIdEsemplare() { return idEsemplare; }
}
