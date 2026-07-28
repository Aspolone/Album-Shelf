package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Canzone;

public class CanzoneDAO extends AbstractDAO implements DAOInterface<Canzone, Integer> {

	private static final String SELECT_BASE =
			"SELECT c.*, a.nome_album FROM canzone c JOIN album a ON c.id_album = a.id_album";

	public CanzoneDAO() throws SQLException {
		super();
	}

	@Override
	public Canzone doRetrieveByKey(Integer idCanzone) throws SQLException {
		String query = SELECT_BASE + " WHERE c.id_canzone = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractCanzoneFromResultSet(rs);
			}
		}
		return null;
	}

	public Canzone doRetrieveDettaglio(int idCanzone) throws SQLException {
		String query = "SELECT c.*, a.nome_album,"
				+ " (SELECT AVG(r.voto) FROM recensione r WHERE r.id_canzone = c.id_canzone) AS media_voto"
				+ " FROM canzone c JOIN album a ON c.id_album = a.id_album WHERE c.id_canzone = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) {
					Canzone canzone = extractCanzoneFromResultSet(rs);
					canzone.setMediaVoto(rs.getBigDecimal("media_voto"));
					return canzone;
				}
			}
		}
		return null;
	}

	@Override
	public Collection<Canzone> doRetrieveAll(String order) throws SQLException {
		List<Canzone> canzoni = new ArrayList<>();
		String query = SELECT_BASE + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) canzoni.add(extractCanzoneFromResultSet(rs));
		}
		return canzoni;
	}

	//tutte le canzoni di un album
	public Collection<Canzone> doRetrieveByAlbum(int idAlbum) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE c.id_album = ? ORDER BY c.id_canzone", idAlbum);
	}

	public Collection<Canzone> doRetrieveByTesto(String testo) throws SQLException {
		List<Canzone> canzoni = new ArrayList<>();
		String query = SELECT_BASE + " WHERE c.nome LIKE ? ORDER BY c.nome";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, "%" + testo + "%");
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) canzoni.add(extractCanzoneFromResultSet(rs));
			}
		}
		return canzoni;
	}

	public Collection<Canzone> doRetrieveByGenere(String genere) throws SQLException {
		List<Canzone> canzoni = new ArrayList<>();
		String query = "SELECT c.*, a.nome_album FROM canzone c"
				+ " JOIN album a ON c.id_album = a.id_album"
				+ " JOIN canzone_genere cg ON c.id_canzone = cg.id_canzone"
				+ " WHERE cg.genere = ? ORDER BY c.visite DESC";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) canzoni.add(extractCanzoneFromResultSet(rs));
			}
		}
		return canzoni;
	}

	public Collection<Canzone> doRetrievePiuVisitate(int limite) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " ORDER BY c.visite DESC, c.nome ASC LIMIT ?", limite);
	}

	//da chiamare sempre con il format dentro util
	public int getDurataTotaleAlbum(int idAlbum) throws SQLException {
		String query = "SELECT COALESCE(SUM(durata), 0) AS totale FROM canzone WHERE id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getInt("totale");
			}
		}
		return 0;
	}

	public void incrementaVisite(int idCanzone) throws SQLException {
		String query = "UPDATE canzone SET visite = visite + 1 WHERE id_canzone = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			statement.executeUpdate();
		}
	}

	@Override
	public long doSave(Canzone canzone) throws SQLException {
		String query = "INSERT INTO canzone (nome, testo, durata, id_album) VALUES (?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, canzone.getNome());
			statement.setString(2, canzone.getTesto());
			if (canzone.getDurata() == null) statement.setNull(3, Types.INTEGER);
			else statement.setInt(3, canzone.getDurata());
			statement.setInt(4, canzone.getIdAlbum());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Canzone canzone) throws SQLException {
		String query = "UPDATE canzone SET nome = ?, testo = ?, durata = ?, id_album = ? WHERE id_canzone = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, canzone.getNome());
			statement.setString(2, canzone.getTesto());
			if (canzone.getDurata() == null) statement.setNull(3, Types.INTEGER);
			else statement.setInt(3, canzone.getDurata());
			statement.setInt(4, canzone.getIdAlbum());
			statement.setInt(5, canzone.getIdCanzone());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idCanzone) throws SQLException {
		String query = "DELETE FROM canzone WHERE id_canzone = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			return statement.executeUpdate() > 0;
		}
	}

	public Collection<String> doRetrieveGeneri(int idCanzone) throws SQLException {
		List<String> generi = new ArrayList<>();
		String query = "SELECT genere FROM canzone_genere WHERE id_canzone = ? ORDER BY genere";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) generi.add(rs.getString("genere"));
			}
		}
		return generi;
	}

	public void doAssociaGenere(int idCanzone, String genere) throws SQLException {
		String query = "INSERT IGNORE INTO canzone_genere (id_canzone, genere) VALUES (?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			statement.setString(2, genere);
			statement.executeUpdate();
		}
	}

	public boolean doRimuoviGenere(int idCanzone, String genere) throws SQLException {
		String query = "DELETE FROM canzone_genere WHERE id_canzone = ? AND genere = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCanzone);
			statement.setString(2, genere);
			return statement.executeUpdate() > 0;
		}
	}

	private Collection<Canzone> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Canzone> canzoni = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) canzoni.add(extractCanzoneFromResultSet(rs));
			}
		}
		return canzoni;
	}

	private Canzone extractCanzoneFromResultSet(ResultSet rs) throws SQLException {
		Canzone canzone = new Canzone();
		canzone.setIdCanzone(rs.getInt("id_canzone"));
		canzone.setNome(rs.getString("nome"));
		canzone.setTesto(rs.getString("testo"));
		int durata = rs.getInt("durata");
		canzone.setDurata(rs.wasNull() ? null : durata);   // durata e' opzionale in schema.sql
		canzone.setIdAlbum(rs.getInt("id_album"));
		canzone.setVisite(rs.getInt("visite"));
		canzone.setNomeAlbum(rs.getString("nome_album"));
		return canzone;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "nome":   return " ORDER BY c.nome";
			case "visite": return " ORDER BY c.visite DESC";
			case "album":  return " ORDER BY a.nome_album, c.id_canzone";
			default:       return "";
		}
	}
}
