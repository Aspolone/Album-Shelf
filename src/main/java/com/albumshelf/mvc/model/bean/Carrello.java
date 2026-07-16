package main.java.com.albumshelf.mvc.model.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

//serivra' probabilmente spostare la logica dentro la servlets e mantere questa classe un interfaccia, ma per ora va bene cosi

public class Carrello {

    private List<RigaCarrello> righe = new ArrayList<>();

    public Carrello() {}

    public void aggiungi(int idEsemplare, int quantita) {
        Optional<RigaCarrello> esistente = trovaRiga(idEsemplare);
        if (esistente.isPresent()) {
            esistente.get().incrementa(quantita);
        } else {
            righe.add(new RigaCarrello(idEsemplare, quantita));
        }
    }

    public void aggiungi(int idEsemplare) {
        aggiungi(idEsemplare, 1);
    }

    public void rimuovi(int idEsemplare) {
        righe.removeIf(r -> r.getIdEsemplare() == idEsemplare);
    }

    public void aggiornaQuantita(int idEsemplare, int quantita) {
        if (quantita <= 0) {
            rimuovi(idEsemplare);
            return;
        }
        trovaRiga(idEsemplare).ifPresent(r -> r.setQuantita(quantita));
    }

    public void svuota() {
        righe.clear();
    }

    public boolean isVuoto() {
        return righe.isEmpty();
    }

    public int numeroArticoli() {
        return righe.size();
    }

    private Optional<RigaCarrello> trovaRiga(int idEsemplare) {
        return righe.stream().filter(r -> r.getIdEsemplare() == idEsemplare).findFirst();
    }

    public List<RigaCarrello> getRighe() {
        return righe;
    }

    public void setRighe(List<RigaCarrello> righe) {
        this.righe = righe;
    }
}