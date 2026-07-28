package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Edizione;

public class EdizioneDAO extends AbstractDAO implements DAOInterface<Edizione, Integer> {

	private static final String SELECT_BASE =
			"SELECT e.*, a.nome_album FROM edizione e JOIN album a ON e.id_album = a.id_album";

	public EdizioneDAO() throws SQLException {
		super();
	}

	@Override
	public Edizione doRetrieveByKey(Integer idEdizione) throws SQLException {
		String query = SELECT_BASE + " WHERE e.id_edizione = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEdizione);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractEdizioneFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Edizione> doRetrieveAll(String order) throws SQLException {
		List<Edizione> edizioni = new ArrayList<>();
		String query = SELECT_BASE + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) edizioni.add(extractEdizioneFromResultSet(rs));
		}
		return edizioni;
	}

	public Collection<Edizione> doRetrieveByAlbum(int idAlbum) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE e.id_album = ? ORDER BY e.anno_stampa DESC", idAlbum);
	}

	// solo le edizioni in vendita
	public Collection<Edizione> doRetrieveAcquistabiliByAlbum(int idAlbum) throws SQLException {
		String query = "SELECT DISTINCT e.*, a.nome_album FROM edizione e"
				+ " JOIN album a ON e.id_album = a.id_album"
				+ " JOIN esemplare es ON e.id_edizione = es.id_edizione"
				+ " WHERE e.id_album = ? AND es.disponibile = TRUE"
				+ " ORDER BY e.anno_stampa DESC";
		return eseguiConIntero(query, idAlbum);
	}

	public Collection<Edizione> doRetrieveByFormato(String formato) throws SQLException {
		List<Edizione> edizioni = new ArrayList<>();
		String query = SELECT_BASE + " WHERE e.formato = ? ORDER BY a.nome_album";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, formato);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) edizioni.add(extractEdizioneFromResultSet(rs));
			}
		}
		return edizioni;
	}

	@Override
	public long doSave(Edizione edizione) throws SQLException {
		String query = "INSERT INTO edizione (anno_stampa, formato, etichetta, paese, id_album)"
				+ " VALUES (?, ?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			if (edizione.getAnnoStampa() == null) statement.setNull(1, Types.INTEGER);
			else statement.setInt(1, edizione.getAnnoStampa());
			statement.setString(2, edizione.getFormato());
			statement.setString(3, edizione.getEtichetta());
			statement.setString(4, edizione.getPaese());
			statement.setInt(5, edizione.getIdAlbum());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Edizione edizione) throws SQLException {
		String query = "UPDATE edizione SET anno_stampa = ?, formato = ?, etichetta = ?, paese = ?,"
				+ " id_album = ? WHERE id_edizione = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			if (edizione.getAnnoStampa() == null) statement.setNull(1, Types.INTEGER);
			else statement.setInt(1, edizione.getAnnoStampa());
			statement.setString(2, edizione.getFormato());
			statement.setString(3, edizione.getEtichetta());
			statement.setString(4, edizione.getPaese());
			statement.setInt(5, edizione.getIdAlbum());
			statement.setInt(6, edizione.getIdEdizione());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idEdizione) throws SQLException {
		String query = "DELETE FROM edizione WHERE id_edizione = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEdizione);
			return statement.executeUpdate() > 0;
		}
	}

	private Collection<Edizione> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Edizione> edizioni = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) edizioni.add(extractEdizioneFromResultSet(rs));
			}
		}
		return edizioni;
	}

	private Edizione extractEdizioneFromResultSet(ResultSet rs) throws SQLException {
		Edizione edizione = new Edizione();
		edizione.setIdEdizione(rs.getInt("id_edizione"));
		int anno = rs.getInt("anno_stampa");
		edizione.setAnnoStampa(rs.wasNull() ? null : anno);
		edizione.setFormato(rs.getString("formato"));
		edizione.setEtichetta(rs.getString("etichetta"));
		edizione.setPaese(rs.getString("paese"));
		edizione.setIdAlbum(rs.getInt("id_album"));
		edizione.setNomeAlbum(rs.getString("nome_album"));
		return edizione;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "anno":    return " ORDER BY e.anno_stampa DESC";
			case "formato": return " ORDER BY e.formato, a.nome_album";
			case "album":   return " ORDER BY a.nome_album";
			default:        return "";
		}
	}
}
