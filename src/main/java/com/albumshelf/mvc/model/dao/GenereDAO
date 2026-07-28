package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Genere;

public class GenereDAO extends AbstractDAO implements DAOInterface<Genere, String> {

	public GenereDAO() throws SQLException {
		super();
	}

	@Override
	public Genere doRetrieveByKey(String genere) throws SQLException {
		String query = "SELECT * FROM genere WHERE genere = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractGenereFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Genere> doRetrieveAll(String order) throws SQLException {
		List<Genere> generi = new ArrayList<>();
		String query = "SELECT * FROM genere ORDER BY genere";
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) generi.add(extractGenereFromResultSet(rs));
		}
		return generi;
	}

	public Collection<Genere> doRetrieveOrdinatiPerPopolarita() throws SQLException {
		List<Genere> generi = new ArrayList<>();
		String query = "SELECT g.genere, g.descrizione, COUNT(ag.id_album) AS n_album"
				+ " FROM genere g LEFT JOIN album_genere ag ON g.genere = ag.genere"
				+ " GROUP BY g.genere, g.descrizione ORDER BY n_album DESC, g.genere";
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) generi.add(extractGenereFromResultSet(rs));
		}
		return generi;
	}

	@Override
	public long doSave(Genere genere) throws SQLException {
		String query = "INSERT INTO genere (genere, descrizione) VALUES (?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere.getGenere());
			statement.setString(2, genere.getDescrizione());
			statement.executeUpdate();
		}
		return -1;
	}

	@Override
	public void doUpdate(Genere genere) throws SQLException {
		String query = "UPDATE genere SET descrizione = ? WHERE genere = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere.getDescrizione());
			statement.setString(2, genere.getGenere());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(String genere) throws SQLException {
		String query = "DELETE FROM genere WHERE genere = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere);
			return statement.executeUpdate() > 0;
		}
	}

	private Genere extractGenereFromResultSet(ResultSet rs) throws SQLException {
		Genere genere = new Genere();
		genere.setGenere(rs.getString("genere"));
		genere.setDescrizione(rs.getString("descrizione"));
		return genere;
	}
}
