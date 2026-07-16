package main.java.com.albumshelf.mvc.model.bean;

import java.util.LinkedHashMap;
import java.util.Map;

public class Carrello {

    // chiave: idEsemplare, valore: quantità
    private Map<Integer, Integer> articoli = new LinkedHashMap<>();

    public Carrello() {}

    public void aggiungi(int idEsemplare) {
        aggiungi(idEsemplare, 1);
    }

    public void aggiungi(int idEsemplare, int quantita) {
        Integer attuale = articoli.get(idEsemplare);
        if (attuale == null) {
            articoli.put(idEsemplare, quantita);
        } else {
            articoli.put(idEsemplare, attuale + quantita);
        }
    }

    public void rimuovi(int idEsemplare) {
        articoli.remove(idEsemplare);
    }

    public void aggiornaQuantita(int idEsemplare, int quantita) {
        if (quantita <= 0) {
            rimuovi(idEsemplare);
        } else {
            articoli.put(idEsemplare, quantita);
        }
    }

    public void svuota() {
        articoli.clear();
    }

    public boolean isVuoto() {
        return articoli.isEmpty();
    }

    public int numeroArticoli() {
        return articoli.size();
    }

    public Map<Integer, Integer> getArticoli() {
        return articoli;
    }

    public void setArticoli(Map<Integer, Integer> articoli) {
        this.articoli = articoli;
    }
}