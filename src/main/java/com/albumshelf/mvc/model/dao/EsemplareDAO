package com.albumshelf.mvc.model.dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Esemplare;

public class EsemplareDAO extends AbstractDAO implements DAOInterface<Esemplare, Integer> {

	private static final String SELECT_BASE =
			"SELECT es.*, u.nome_utente AS nome_venditore, a.nome_album, a.file_copertina,"
			+ " e.formato, a.id_album"
			+ " FROM esemplare es"
			+ " JOIN utente u ON es.id_utente = u.id_utente"
			+ " JOIN edizione e ON es.id_edizione = e.id_edizione"
			+ " JOIN album a ON e.id_album = a.id_album";

	public EsemplareDAO() throws SQLException {
		super();
	}

	@Override
	public Esemplare doRetrieveByKey(Integer idEsemplare) throws SQLException {
		String query = SELECT_BASE + " WHERE es.id_esemplare = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEsemplare);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractEsemplareFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Esemplare> doRetrieveAll(String order) throws SQLException {
		List<Esemplare> esemplari = new ArrayList<>();
		String query = SELECT_BASE + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) esemplari.add(extractEsemplareFromResultSet(rs));
		}
		return esemplari;
	}

	//offerte per una singola edizione, dalla piu' economica
	public Collection<Esemplare> doRetrieveDisponibiliByEdizione(int idEdizione) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE es.id_edizione = ? AND es.disponibile = TRUE ORDER BY es.prezzo ASC",
				idEdizione);
	}

	//tutte gli esemplari in vendita
	public Collection<Esemplare> doRetrieveDisponibiliByAlbum(int idAlbum) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE a.id_album = ? AND es.disponibile = TRUE ORDER BY es.prezzo ASC",
				idAlbum);
	}

	//annunci di un venditore
	public Collection<Esemplare> doRetrieveByVenditore(int idUtente) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE es.id_utente = ? ORDER BY es.disponibile DESC, a.nome_album",
				idUtente);
	}

	public Collection<Esemplare> doRetrieveDisponibiliByVenditore(int idUtente) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE es.id_utente = ? AND es.disponibile = TRUE ORDER BY a.nome_album",
				idUtente);
	}

	public BigDecimal getPrezzoMinimoAlbum(int idAlbum) throws SQLException {
		String query = "SELECT MIN(es.prezzo) AS minimo FROM esemplare es"
				+ " JOIN edizione e ON es.id_edizione = e.id_edizione"
				+ " WHERE e.id_album = ? AND es.disponibile = TRUE";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getBigDecimal("minimo");
			}
		}
		return null;
	}

	public int contaDisponibiliByAlbum(int idAlbum) throws SQLException {
		String query = "SELECT COUNT(*) AS n FROM esemplare es"
				+ " JOIN edizione e ON es.id_edizione = e.id_edizione"
				+ " WHERE e.id_album = ? AND es.disponibile = TRUE";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getInt("n");
			}
		}
		return 0;
	}

	//utilizza il filtro della condizione del disco per ottenere solo le copie in vendita che soddisfano quel requisito 
	public Collection<Esemplare> doRetrieveConFiltri(String formato, String condizioneDisco,
			BigDecimal prezzoMax) throws SQLException {
		StringBuilder query = new StringBuilder(SELECT_BASE).append(" WHERE es.disponibile = TRUE");
		List<Object> parametri = new ArrayList<>();
		if (formato != null && !formato.isEmpty()) {
			query.append(" AND e.formato = ?");
			parametri.add(formato);
		}
		if (condizioneDisco != null && !condizioneDisco.isEmpty()) {
			query.append(" AND es.condizione_disco = ?");
			parametri.add(condizioneDisco);
		}
		if (prezzoMax != null) {
			query.append(" AND es.prezzo <= ?");
			parametri.add(prezzoMax);
		}
		query.append(" ORDER BY es.prezzo ASC");

		List<Esemplare> esemplari = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
			for (int i = 0; i < parametri.size(); i++) statement.setObject(i + 1, parametri.get(i));
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) esemplari.add(extractEsemplareFromResultSet(rs));
			}
		}
		return esemplari;
	}

	public boolean isDisponibile(int idEsemplare) throws SQLException {
		String query = "SELECT disponibile FROM esemplare WHERE id_esemplare = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEsemplare);
			try (ResultSet rs = statement.executeQuery()) {
				return rs.next() && rs.getBoolean("disponibile");
			}
		}
	}

	public boolean doMarcaVenduto(int idEsemplare) throws SQLException {
		String query = "UPDATE esemplare SET disponibile = FALSE"
				+ " WHERE id_esemplare = ? AND disponibile = TRUE";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEsemplare);
			return statement.executeUpdate() > 0;
		}
	}

	@Override
	public long doSave(Esemplare esemplare) throws SQLException {
		String query = "INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione,"
				+ " impellicolato, id_edizione, id_utente, disponibile) VALUES (?, ?, ?, ?, ?, ?, TRUE)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setBigDecimal(1, esemplare.getPrezzo());
			statement.setString(2, esemplare.getCondizioneDisco());
			statement.setString(3, esemplare.getCondizioneConfezione());
			statement.setBoolean(4, esemplare.isImpellicolato());
			statement.setInt(5, esemplare.getIdEdizione());
			statement.setInt(6, esemplare.getIdUtente());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	public void doSaveMultiplo(Esemplare esemplare, int quante) throws SQLException {
		if (quante < 1) throw new IllegalArgumentException("Serve almeno una copia.");
		String query = "INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione,"
				+ " impellicolato, id_edizione, id_utente, disponibile) VALUES (?, ?, ?, ?, ?, ?, TRUE)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			for (int i = 0; i < quante; i++) {
				statement.setBigDecimal(1, esemplare.getPrezzo());
				statement.setString(2, esemplare.getCondizioneDisco());
				statement.setString(3, esemplare.getCondizioneConfezione());
				statement.setBoolean(4, esemplare.isImpellicolato());
				statement.setInt(5, esemplare.getIdEdizione());
				statement.setInt(6, esemplare.getIdUtente());
				statement.addBatch();
			}
			statement.executeBatch();
		}
	}

	@Override
	public void doUpdate(Esemplare esemplare) throws SQLException {
		String query = "UPDATE esemplare SET prezzo = ?, condizione_disco = ?, condizione_confezione = ?,"
				+ " impellicolato = ?, id_edizione = ?, disponibile = ? WHERE id_esemplare = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setBigDecimal(1, esemplare.getPrezzo());
			statement.setString(2, esemplare.getCondizioneDisco());
			statement.setString(3, esemplare.getCondizioneConfezione());
			statement.setBoolean(4, esemplare.isImpellicolato());
			statement.setInt(5, esemplare.getIdEdizione());
			statement.setBoolean(6, esemplare.isDisponibile());
			statement.setInt(7, esemplare.getIdEsemplare());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idEsemplare) throws SQLException {
		String query = "DELETE FROM esemplare WHERE id_esemplare = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idEsemplare);
			return statement.executeUpdate() > 0;
		}
	}

	private Collection<Esemplare> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Esemplare> esemplari = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) esemplari.add(extractEsemplareFromResultSet(rs));
			}
		}
		return esemplari;
	}

	private Esemplare extractEsemplareFromResultSet(ResultSet rs) throws SQLException {
		Esemplare esemplare = new Esemplare();
		esemplare.setIdEsemplare(rs.getInt("id_esemplare"));
		esemplare.setPrezzo(rs.getBigDecimal("prezzo"));
		esemplare.setCondizioneDisco(rs.getString("condizione_disco"));
		esemplare.setCondizioneConfezione(rs.getString("condizione_confezione"));
		esemplare.setImpellicolato(rs.getBoolean("impellicolato"));
		esemplare.setIdEdizione(rs.getInt("id_edizione"));
		esemplare.setIdUtente(rs.getInt("id_utente"));
		esemplare.setDisponibile(rs.getBoolean("disponibile"));
		esemplare.setNomeVenditore(rs.getString("nome_venditore"));
		esemplare.setNomeAlbum(rs.getString("nome_album"));
		esemplare.setFileCopertina(rs.getString("file_copertina"));
		esemplare.setFormato(rs.getString("formato"));
		esemplare.setIdAlbum(rs.getInt("id_album"));
		return esemplare;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "prezzo":      return " ORDER BY es.prezzo ASC";
			case "prezzo_desc": return " ORDER BY es.prezzo DESC";
			case "album":       return " ORDER BY a.nome_album";
			default:            return "";
		}
	}
}