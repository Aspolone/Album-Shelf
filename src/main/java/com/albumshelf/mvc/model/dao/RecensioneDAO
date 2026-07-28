package com.albumshelf.mvc.model.dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Recensione;

public class RecensioneDAO extends AbstractDAO implements DAOInterface<Recensione, Integer> {

	private static final String SELECT_BASE =
			"SELECT r.*, u.nome_utente FROM recensione r JOIN utente u ON r.id_utente = u.id_utente";

	public RecensioneDAO() throws SQLException {
		super();
	}

	@Override
	public Recensione doRetrieveByKey(Integer idRecensione) throws SQLException {
		String query = SELECT_BASE + " WHERE r.id_recensione = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idRecensione);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractRecensioneFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Recensione> doRetrieveAll(String order) throws SQLException {
		List<Recensione> recensioni = new ArrayList<>();
		String query = SELECT_BASE + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) recensioni.add(extractRecensioneFromResultSet(rs));
		}
		return recensioni;
	}

	public Collection<Recensione> doRetrieveByAlbum(int idAlbum) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE r.id_album = ? ORDER BY r.data_recensione DESC", idAlbum);
	}

	public Collection<Recensione> doRetrieveByCanzone(int idCanzone) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE r.id_canzone = ? ORDER BY r.data_recensione DESC", idCanzone);
	}

	// recensioni scritte da un utente: profilo
	public Collection<Recensione> doRetrieveByUtente(int idUtente) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE r.id_utente = ? ORDER BY r.data_recensione DESC", idUtente);
	}

	public Recensione doRetrieveByUtenteEAlbum(int idUtente, int idAlbum) throws SQLException {
		return eseguiSingola(SELECT_BASE + " WHERE r.id_utente = ? AND r.id_album = ?", idUtente, idAlbum);
	}

	public Recensione doRetrieveByUtenteECanzone(int idUtente, int idCanzone) throws SQLException {
		return eseguiSingola(SELECT_BASE + " WHERE r.id_utente = ? AND r.id_canzone = ?", idUtente, idCanzone);
	}

	public BigDecimal getMediaVotoAlbum(int idAlbum) throws SQLException {
		return media("id_album", idAlbum);
	}

	public BigDecimal getMediaVotoCanzone(int idCanzone) throws SQLException {
		return media("id_canzone", idCanzone);
	}

	public int contaRecensioniAlbum(int idAlbum) throws SQLException {
		return conta("id_album", idAlbum);
	}

	public int contaRecensioniCanzone(int idCanzone) throws SQLException {
		return conta("id_canzone", idCanzone);
	}


	public int[] getDistribuzioneVotiAlbum(int idAlbum) throws SQLException {
		int[] distribuzione = new int[10];
		String query = "SELECT voto, COUNT(*) AS n FROM recensione WHERE id_album = ? GROUP BY voto";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					int indice = rs.getBigDecimal("voto").multiply(new BigDecimal("2")).intValue() - 1;
					if (indice >= 0 && indice < 10) distribuzione[indice] = rs.getInt("n");
				}
			}
		}
		return distribuzione;
	}

	@Override
	public long doSave(Recensione recensione) throws SQLException {
		String query = "INSERT INTO recensione (voto, commento, id_utente, id_album, id_canzone)"
				+ " VALUES (?, ?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setBigDecimal(1, recensione.getVoto());
			statement.setString(2, recensione.getCommento());
			statement.setInt(3, recensione.getIdUtente());
			if (recensione.getIdAlbum() == null) statement.setNull(4, Types.INTEGER);
			else statement.setInt(4, recensione.getIdAlbum());
			if (recensione.getIdCanzone() == null) statement.setNull(5, Types.INTEGER);
			else statement.setInt(5, recensione.getIdCanzone());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Recensione recensione) throws SQLException {
		String query = "UPDATE recensione SET voto = ?, commento = ? WHERE id_recensione = ? AND id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setBigDecimal(1, recensione.getVoto());
			statement.setString(2, recensione.getCommento());
			statement.setInt(3, recensione.getIdRecensione());
			statement.setInt(4, recensione.getIdUtente());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idRecensione) throws SQLException {
		String query = "DELETE FROM recensione WHERE id_recensione = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idRecensione);
			return statement.executeUpdate() > 0;
		}
	}

	public boolean doDelete(int idRecensione, int idUtente) throws SQLException {
		String query = "DELETE FROM recensione WHERE id_recensione = ? AND id_utente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idRecensione);
			statement.setInt(2, idUtente);
			return statement.executeUpdate() > 0;
		}
	}

	private BigDecimal media(String colonna, int id) throws SQLException {
		String query = "SELECT AVG(voto) AS media FROM recensione WHERE " + colonna + " = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, id);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getBigDecimal("media");
			}
		}
		return null;
	}

	private int conta(String colonna, int id) throws SQLException {
		String query = "SELECT COUNT(*) AS n FROM recensione WHERE " + colonna + " = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, id);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getInt("n");
			}
		}
		return 0;
	}

	private Recensione eseguiSingola(String query, int p1, int p2) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, p1);
			statement.setInt(2, p2);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractRecensioneFromResultSet(rs);
			}
		}
		return null;
	}

	private Collection<Recensione> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Recensione> recensioni = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) recensioni.add(extractRecensioneFromResultSet(rs));
			}
		}
		return recensioni;
	}

	private Recensione extractRecensioneFromResultSet(ResultSet rs) throws SQLException {
		Recensione recensione = new Recensione();
		recensione.setIdRecensione(rs.getInt("id_recensione"));
		recensione.setVoto(rs.getBigDecimal("voto"));
		recensione.setCommento(rs.getString("commento"));
		recensione.setDataRecensione(rs.getTimestamp("data_recensione"));
		recensione.setIdUtente(rs.getInt("id_utente"));
		int idAlbum = rs.getInt("id_album");
		recensione.setIdAlbum(rs.wasNull() ? null : idAlbum);
		int idCanzone = rs.getInt("id_canzone");
		recensione.setIdCanzone(rs.wasNull() ? null : idCanzone);
		recensione.setNomeUtente(rs.getString("nome_utente"));
		return recensione;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "data": return " ORDER BY r.data_recensione DESC";
			case "voto": return " ORDER BY r.voto DESC";
			default:     return "";
		}
	}
}
