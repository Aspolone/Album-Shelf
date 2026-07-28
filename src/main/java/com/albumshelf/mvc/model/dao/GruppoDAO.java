package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Composizione;
import com.albumshelf.mvc.model.bean.Gruppo;
import com.albumshelf.mvc.model.bean.NomeGruppo;

public class GruppoDAO extends AbstractDAO implements DAOInterface<Gruppo, Integer> {

	public GruppoDAO() throws SQLException {
		super();
	}

	@Override
	public Gruppo doRetrieveByKey(Integer idGruppo) throws SQLException {
		String query = "SELECT * FROM gruppo WHERE id_gruppo = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractGruppoFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Gruppo> doRetrieveAll(String order) throws SQLException {
		List<Gruppo> gruppi = new ArrayList<>();
		String query = "SELECT * FROM gruppo" + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) gruppi.add(extractGruppoFromResultSet(rs));
		}
		return gruppi;
	}

	public Collection<Gruppo> doRetrieveByNome(String testo) throws SQLException {
		List<Gruppo> gruppi = new ArrayList<>();
		String query = "SELECT DISTINCT g.* FROM gruppo g"
				+ " LEFT JOIN nome_gruppo ng ON g.id_gruppo = ng.id_gruppo"
				+ " WHERE g.nome LIKE ? OR ng.nome LIKE ? ORDER BY g.nome";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			String pattern = "%" + testo + "%";
			statement.setString(1, pattern);
			statement.setString(2, pattern);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) gruppi.add(extractGruppoFromResultSet(rs));
			}
		}
		return gruppi;
	}

	public Collection<Gruppo> doRetrievePiuVisitati(int limite) throws SQLException {
		List<Gruppo> gruppi = new ArrayList<>();
		String query = "SELECT * FROM gruppo ORDER BY visite DESC, nome ASC LIMIT ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, limite);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) gruppi.add(extractGruppoFromResultSet(rs));
			}
		}
		return gruppi;
	}

	public void incrementaVisite(int idGruppo) throws SQLException {
		String query = "UPDATE gruppo SET visite = visite + 1 WHERE id_gruppo = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			statement.executeUpdate();
		}
	}

	@Override
	public long doSave(Gruppo gruppo) throws SQLException {
		String query = "INSERT INTO gruppo (nome, data_creazione, nazione, data_scioglimento)"
				+ " VALUES (?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, gruppo.getNome());
			statement.setDate(2, gruppo.getDataCreazione());
			statement.setString(3, gruppo.getNazione());
			statement.setDate(4, gruppo.getDataScioglimento());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Gruppo gruppo) throws SQLException {
		String query = "UPDATE gruppo SET nome = ?, data_creazione = ?, nazione = ?, data_scioglimento = ?"
				+ " WHERE id_gruppo = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, gruppo.getNome());
			statement.setDate(2, gruppo.getDataCreazione());
			statement.setString(3, gruppo.getNazione());
			statement.setDate(4, gruppo.getDataScioglimento());
			statement.setInt(5, gruppo.getIdGruppo());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idGruppo) throws SQLException {
		String query = "DELETE FROM gruppo WHERE id_gruppo = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			return statement.executeUpdate() > 0;
		}
	}

	public Collection<NomeGruppo> doRetrieveNomiStorici(int idGruppo) throws SQLException {
		List<NomeGruppo> nomi = new ArrayList<>();
		String query = "SELECT * FROM nome_gruppo WHERE id_gruppo = ? ORDER BY data_inizio";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					NomeGruppo nome = new NomeGruppo();
					nome.setIdGruppo(rs.getInt("id_gruppo"));
					nome.setNome(rs.getString("nome"));
					nome.setDataInizio(rs.getDate("data_inizio"));
					nome.setDataFine(rs.getDate("data_fine"));
					nomi.add(nome);
				}
			}
		}
		return nomi;
	}

	public void doSaveNomeStorico(NomeGruppo nome) throws SQLException {
		String query = "INSERT INTO nome_gruppo (id_gruppo, nome, data_inizio, data_fine) VALUES (?, ?, ?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, nome.getIdGruppo());
			statement.setString(2, nome.getNome());
			statement.setDate(3, nome.getDataInizio());
			statement.setDate(4, nome.getDataFine());
			statement.executeUpdate();
		}
	}

	public boolean doDeleteNomeStorico(int idGruppo, String nome) throws SQLException {
		String query = "DELETE FROM nome_gruppo WHERE id_gruppo = ? AND nome = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			statement.setString(2, nome);
			return statement.executeUpdate() > 0;
		}
	}

	public Collection<Composizione> doRetrieveFormazione(int idGruppo) throws SQLException {
		String query = "SELECT c.*, comp.nome AS nome_componente, comp.cognome AS cognome_componente"
				+ " FROM composizione c JOIN componente comp ON c.id_componente = comp.id_componente"
				+ " WHERE c.id_gruppo = ? ORDER BY c.data_ingresso";
		return eseguiFormazione(query, idGruppo);
	}

	public Collection<Composizione> doRetrieveFormazioneAttuale(int idGruppo) throws SQLException {
		String query = "SELECT c.*, comp.nome AS nome_componente, comp.cognome AS cognome_componente"
				+ " FROM composizione c JOIN componente comp ON c.id_componente = comp.id_componente"
				+ " WHERE c.id_gruppo = ? AND c.data_uscita IS NULL ORDER BY comp.cognome, comp.nome";
		return eseguiFormazione(query, idGruppo);
	}

	public Collection<Composizione> doRetrieveGruppiDiComponente(int idComponente) throws SQLException {
		List<Composizione> formazione = new ArrayList<>();
		String query = "SELECT c.*, g.nome AS nome_gruppo FROM composizione c"
				+ " JOIN gruppo g ON c.id_gruppo = g.id_gruppo"
				+ " WHERE c.id_componente = ? ORDER BY c.data_ingresso";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idComponente);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Composizione c = extractComposizioneFromResultSet(rs);
					c.setNomeGruppo(rs.getString("nome_gruppo"));
					formazione.add(c);
				}
			}
		}
		return formazione;
	}

	public void doSaveComposizione(Composizione composizione) throws SQLException {
		String query = "INSERT INTO composizione (id_componente, id_gruppo, data_ingresso, data_uscita, ruolo)"
				+ " VALUES (?, ?, ?, ?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, composizione.getIdComponente());
			statement.setInt(2, composizione.getIdGruppo());
			statement.setDate(3, composizione.getDataIngresso());
			statement.setDate(4, composizione.getDataUscita());
			statement.setString(5, composizione.getRuolo());
			statement.executeUpdate();
		}
	}

	public boolean doDeleteComposizione(int idComponente, int idGruppo, java.sql.Date dataIngresso)
			throws SQLException {
		String query = "DELETE FROM composizione WHERE id_componente = ? AND id_gruppo = ? AND data_ingresso = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idComponente);
			statement.setInt(2, idGruppo);
			statement.setDate(3, dataIngresso);
			return statement.executeUpdate() > 0;
		}
	}

	private Collection<Composizione> eseguiFormazione(String query, int idGruppo) throws SQLException {
		List<Composizione> formazione = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idGruppo);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Composizione c = extractComposizioneFromResultSet(rs);
					c.setNomeComponente(rs.getString("nome_componente"));
					c.setCognomeComponente(rs.getString("cognome_componente"));
					formazione.add(c);
				}
			}
		}
		return formazione;
	}

	private Composizione extractComposizioneFromResultSet(ResultSet rs) throws SQLException {
		Composizione c = new Composizione();
		c.setIdComponente(rs.getInt("id_componente"));
		c.setIdGruppo(rs.getInt("id_gruppo"));
		c.setDataIngresso(rs.getDate("data_ingresso"));
		c.setDataUscita(rs.getDate("data_uscita"));
		c.setRuolo(rs.getString("ruolo"));
		return c;
	}

	private Gruppo extractGruppoFromResultSet(ResultSet rs) throws SQLException {
		Gruppo gruppo = new Gruppo();
		gruppo.setIdGruppo(rs.getInt("id_gruppo"));
		gruppo.setNome(rs.getString("nome"));
		gruppo.setDataCreazione(rs.getDate("data_creazione"));
		gruppo.setNazione(rs.getString("nazione"));
		gruppo.setDataScioglimento(rs.getDate("data_scioglimento"));
		gruppo.setVisite(rs.getInt("visite"));
		return gruppo;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "nome":           return " ORDER BY nome";
			case "visite":         return " ORDER BY visite DESC";
			case "data_creazione": return " ORDER BY data_creazione DESC";
			default:               return "";
		}
	}
}
