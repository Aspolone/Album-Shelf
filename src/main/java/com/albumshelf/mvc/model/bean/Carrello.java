package com.albumshelf.mvc.model.bean;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Carrello {

	private Map<Integer, RigaCarrello> righe = new LinkedHashMap<>();

	public Carrello() {}

	public void aggiungi(RigaCarrello riga) {
		righe.put(riga.getIdEsemplare(), riga);
	}

	public void rimuovi(int idEsemplare) {
		righe.remove(idEsemplare);
	}

	public boolean contiene(int idEsemplare) {
		return righe.containsKey(idEsemplare);
	}

	public void svuota() {
		righe.clear();
	}

	public boolean isVuoto() {
		return righe.isEmpty();
	}

	public int getNumeroArticoli() {
		return righe.size();
	}

	public List<RigaCarrello> getRighe() {
		return new ArrayList<>(righe.values());
	}

	public BigDecimal getTotale() {
		BigDecimal totale = BigDecimal.ZERO;
		for (RigaCarrello r : righe.values()) {
			totale = totale.add(r.getPrezzo());
		}
		return totale;
	}
}