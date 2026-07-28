package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Componente;

public class ComponenteDAO extends AbstractDAO implements DAOInterface<Componente, Integer> {

	public ComponenteDAO() throws SQLException {
		super();
	}

	@Override
	public Componente doRetrieveByKey(Integer idComponente) throws SQLException {
		String query = "SELECT * FROM componente WHERE id_componente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idComponente);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractComponenteFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Componente> doRetrieveAll(String order) throws SQLException {
		List<Componente> componenti = new ArrayList<>();
		String query = "SELECT * FROM componente" + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) componenti.add(extractComponenteFromResultSet(rs));
		}
		return componenti;
	}

	public Collection<Componente> doRetrieveByNome(String testo) throws SQLException {
		List<Componente> componenti = new ArrayList<>();
		String query = "SELECT * FROM componente WHERE nome LIKE ? OR cognome LIKE ? ORDER BY cognome, nome";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			String pattern = "%" + testo + "%";
			statement.setString(1, pattern);
			statement.setString(2, pattern);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) componenti.add(extractComponenteFromResultSet(rs));
			}
		}
		return componenti;
	}

	@Override
	public long doSave(Componente componente) throws SQLException {
		String query = "INSERT INTO componente (nome, cognome, data_nascita, data_morte, strumento)"
				+ " VALUES (?, ?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, componente.getNome());
			statement.setString(2, componente.getCognome());
			statement.setDate(3, componente.getDataNascita());
			statement.setDate(4, componente.getDataMorte());
			statement.setString(5, componente.getStrumento());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Componente componente) throws SQLException {
		String query = "UPDATE componente SET nome = ?, cognome = ?, data_nascita = ?, data_morte = ?,"
				+ " strumento = ? WHERE id_componente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, componente.getNome());
			statement.setString(2, componente.getCognome());
			statement.setDate(3, componente.getDataNascita());
			statement.setDate(4, componente.getDataMorte());
			statement.setString(5, componente.getStrumento());
			statement.setInt(6, componente.getIdComponente());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idComponente) throws SQLException {
		String query = "DELETE FROM componente WHERE id_componente = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idComponente);
			return statement.executeUpdate() > 0;
		}
	}

	private Componente extractComponenteFromResultSet(ResultSet rs) throws SQLException {
		Componente componente = new Componente();
		componente.setIdComponente(rs.getInt("id_componente"));
		componente.setNome(rs.getString("nome"));
		componente.setCognome(rs.getString("cognome"));
		componente.setDataNascita(rs.getDate("data_nascita"));
		componente.setDataMorte(rs.getDate("data_morte"));
		componente.setStrumento(rs.getString("strumento"));
		return componente;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "cognome":      return " ORDER BY cognome, nome";
			case "data_nascita": return " ORDER BY data_nascita";
			default:             return "";
		}
	}
}
