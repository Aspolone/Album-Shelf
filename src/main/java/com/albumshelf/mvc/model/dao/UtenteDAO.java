package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Utente;


public class UtenteDAO extends AbstractDAO implements DAOInterface<Utente, Integer> {

	public UtenteDAO() throws SQLException {
		super();
	}

	@Override
	public Utente doRetrieveByKey(Integer idUtente) throws SQLException {
		String query = "SELECT * FROM utente WHERE id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idUtente);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractUtenteFromResultSet(rs);
			}
		}
		return null;
	}

	public Utente doRetrieveByNomeUtente(String nomeUtente) throws SQLException {
		String query = "SELECT * FROM utente WHERE nome_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, nomeUtente);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractUtenteFromResultSet(rs);
			}
		}
		return null;
	}

	public Utente doRetrieveByNomeUtenteOEmail(String nomeUtenteOEmail) throws SQLException {
		String query = "SELECT * FROM utente WHERE nome_utente = ? OR email = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, nomeUtenteOEmail);
			statement.setString(2, nomeUtenteOEmail);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractUtenteFromResultSet(rs);
			}
		}
		return null;
	}

	public boolean esisteNomeUtenteOEmail(String nomeUtente, String email) throws SQLException {
		String query = "SELECT 1 FROM utente WHERE nome_utente = ? OR email = ? LIMIT 1";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, nomeUtente);
			statement.setString(2, email);
			try (ResultSet rs = statement.executeQuery()) {
				return rs.next();
			}
		}
	}

	@Override
	public Collection<Utente> doRetrieveAll(String order) throws SQLException {
		List<Utente> utenti = new ArrayList<>();
		String query = "SELECT * FROM utente" + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) utenti.add(extractUtenteFromResultSet(rs));
		}
		return utenti;
	}

	@Override
	public long doSave(Utente utente) throws SQLException {
		String query = "INSERT INTO utente (nome_utente, email, password, descrizione, nazione, ruolo)"
				+ " VALUES (?, ?, ?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, utente.getNomeUtente());
			statement.setString(2, utente.getEmail());
			statement.setString(3, utente.getPassword());
			statement.setString(4, utente.getDescrizione());
			statement.setString(5, utente.getNazione());
			statement.setString(6, utente.getRuolo() == null ? "cliente" : utente.getRuolo());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Utente utente) throws SQLException {
		String query = "UPDATE utente SET nome_utente = ?, email = ?, descrizione = ?, nazione = ?, ruolo = ?"
				+ " WHERE id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, utente.getNomeUtente());
			statement.setString(2, utente.getEmail());
			statement.setString(3, utente.getDescrizione());
			statement.setString(4, utente.getNazione());
			statement.setString(5, utente.getRuolo());
			statement.setInt(6, utente.getIdUtente());
			statement.executeUpdate();
		}
	}

	public Collection<Utente> doRetrieveByTesto(String testo) throws SQLException {
    List<Utente> utenti = new ArrayList<>();
    String query = "SELECT * FROM utente WHERE nome_utente LIKE ? ORDER BY nome_utente";
    try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, "%" + testo + "%");
        try (ResultSet rs = statement.executeQuery()) {
            while (rs.next()) utenti.add(extractUtenteFromResultSet(rs));
        }
    }
    return utenti;
}

	public void doUpdatePassword(int idUtente, String nuovoHash) throws SQLException {
		String query = "UPDATE utente SET password = ? WHERE id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, nuovoHash);
			statement.setInt(2, idUtente);
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idUtente) throws SQLException {
		String query = "DELETE FROM utente WHERE id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idUtente);
			return statement.executeUpdate() > 0;
		}
	}

	private Utente extractUtenteFromResultSet(ResultSet rs) throws SQLException {
		Utente utente = new Utente();
		utente.setIdUtente(rs.getInt("id_utente"));
		utente.setNomeUtente(rs.getString("nome_utente"));
		utente.setEmail(rs.getString("email"));
		utente.setPassword(rs.getString("password"));   // e' l'hash "salt:hash",
		utente.setDescrizione(rs.getString("descrizione"));
		utente.setNazione(rs.getString("nazione"));
		utente.setDataIscrizione(rs.getTimestamp("data_iscrizione"));
		utente.setRuolo(rs.getString("ruolo"));
		return utente;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "nome_utente":     return " ORDER BY nome_utente";
			case "data_iscrizione": return " ORDER BY data_iscrizione DESC";
			default:                return "";
		}
	}
}