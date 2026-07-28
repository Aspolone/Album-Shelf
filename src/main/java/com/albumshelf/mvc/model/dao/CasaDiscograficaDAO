package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.CasaDiscografica;

public class CasaDiscograficaDAO extends AbstractDAO implements DAOInterface<CasaDiscografica, Integer> {

	public CasaDiscograficaDAO() throws SQLException {
		super();
	}

	@Override
	public CasaDiscografica doRetrieveByKey(Integer idCasaDiscografica) throws SQLException {
		String query = "SELECT * FROM casa_discografica WHERE id_casa_discografica = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCasaDiscografica);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractCasaFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<CasaDiscografica> doRetrieveAll(String order) throws SQLException {
		List<CasaDiscografica> case_ = new ArrayList<>();
		String query = "SELECT * FROM casa_discografica" + ("nome".equals(order) ? " ORDER BY nome" : "");
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) case_.add(extractCasaFromResultSet(rs));
		}
		return case_;
	}

	public Collection<CasaDiscografica> doRetrieveByNome(String testo) throws SQLException {
		List<CasaDiscografica> case_ = new ArrayList<>();
		String query = "SELECT * FROM casa_discografica WHERE nome LIKE ? ORDER BY nome";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, "%" + testo + "%");
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) case_.add(extractCasaFromResultSet(rs));
			}
		}
		return case_;
	}

	@Override
	public long doSave(CasaDiscografica casa) throws SQLException {
		String query = "INSERT INTO casa_discografica (nome, sede) VALUES (?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, casa.getNome());
			statement.setString(2, casa.getSede());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(CasaDiscografica casa) throws SQLException {
		String query = "UPDATE casa_discografica SET nome = ?, sede = ? WHERE id_casa_discografica = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, casa.getNome());
			statement.setString(2, casa.getSede());
			statement.setInt(3, casa.getIdCasaDiscografica());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idCasaDiscografica) throws SQLException {
		String query = "DELETE FROM casa_discografica WHERE id_casa_discografica = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idCasaDiscografica);
			return statement.executeUpdate() > 0;
		}
	}

	private CasaDiscografica extractCasaFromResultSet(ResultSet rs) throws SQLException {
		CasaDiscografica casa = new CasaDiscografica();
		casa.setIdCasaDiscografica(rs.getInt("id_casa_discografica"));
		casa.setNome(rs.getString("nome"));
		casa.setSede(rs.getString("sede"));
		return casa;
	}
}
