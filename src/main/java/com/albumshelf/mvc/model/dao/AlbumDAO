package com.albumshelf.mvc.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Album;

// gestisce sia album che la N:N album_genere 
public class AlbumDAO extends AbstractDAO implements DAOInterface<Album, Integer> {

	private static final String SELECT_BASE =
			"SELECT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica"
			+ " FROM album a"
			+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
			+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica";

	public AlbumDAO() throws SQLException {
		super();
	}

	@Override
	public Album doRetrieveByKey(Integer idAlbum) throws SQLException {
		String query = SELECT_BASE + " WHERE a.id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractAlbumFromResultSet(rs);
			}
		}
		return null;
	}

	//media voto e numero recensioni
	public Album doRetrieveDettaglio(int idAlbum) throws SQLException {
		String query = "SELECT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica,"
				+ " (SELECT AVG(r.voto) FROM recensione r WHERE r.id_album = a.id_album) AS media_voto,"
				+ " (SELECT COUNT(*) FROM recensione r WHERE r.id_album = a.id_album) AS n_recensioni"
				+ " FROM album a"
				+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
				+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica"
				+ " WHERE a.id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) {
					Album album = extractAlbumFromResultSet(rs);
					album.setMediaVoto(rs.getBigDecimal("media_voto"));
					album.setNumeroRecensioni(rs.getInt("n_recensioni"));
					return album;
				}
			}
		}
		return null;
	}

	@Override
	public Collection<Album> doRetrieveAll(String order) throws SQLException {
		List<Album> album = new ArrayList<>();
		String query = SELECT_BASE + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) album.add(extractAlbumFromResultSet(rs));
		}
		return album;
	}

	// barra di ricerca, ajax?
	public Collection<Album> doRetrieveByTesto(String testo) throws SQLException {
		List<Album> album = new ArrayList<>();
		String query = SELECT_BASE + " WHERE a.nome_album LIKE ? OR g.nome LIKE ? ORDER BY a.nome_album";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			String pattern = "%" + testo + "%";
			statement.setString(1, pattern);
			statement.setString(2, pattern);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) album.add(extractAlbumFromResultSet(rs));
			}
		}
		return album;
	}

	public Collection<Album> doRetrieveByGruppo(int idGruppo) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " WHERE a.id_gruppo = ? ORDER BY a.data_rilascio DESC", idGruppo);
	}

	public Collection<Album> doRetrieveByCasaDiscografica(int idCasaDiscografica) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE a.id_casa_discografica = ? ORDER BY a.data_rilascio DESC",
				idCasaDiscografica);
	}

	public Collection<Album> doRetrieveByGenere(String genere) throws SQLException {
		List<Album> album = new ArrayList<>();
		String query = "SELECT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica"
				+ " FROM album a"
				+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
				+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica"
				+ " JOIN album_genere ag ON a.id_album = ag.id_album"
				+ " WHERE ag.genere = ? ORDER BY a.visite DESC";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, genere);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) album.add(extractAlbumFromResultSet(rs));
			}
		}
		return album;
	}

	//i piu' visti
	public Collection<Album> doRetrievePiuVisitati(int limite) throws SQLException {
		return eseguiConIntero(SELECT_BASE + " ORDER BY a.visite DESC, a.nome_album ASC LIMIT ?", limite);
	}

	//in arrivo / novita'
	public Collection<Album> doRetrieveUltimiUsciti(int limite) throws SQLException {
		return eseguiConIntero(
				SELECT_BASE + " WHERE a.data_rilascio IS NOT NULL ORDER BY a.data_rilascio DESC LIMIT ?",
				limite);
	}

	// i piu' recensiti / i classici
	// minRecensioni esiste per rendere coerente la ricerca (1 rec da 5 stelle batte un classico con 100 rec ma la media del 4)
	public Collection<Album> doRetrieveMeglioRecensiti(int limite, int minRecensioni) throws SQLException {
		List<Album> album = new ArrayList<>();
		String query = "SELECT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica,"
				+ " AVG(r.voto) AS media_voto, COUNT(r.id_recensione) AS n_recensioni"
				+ " FROM album a"
				+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
				+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica"
				+ " JOIN recensione r ON a.id_album = r.id_album"
				+ " GROUP BY a.id_album, g.nome, cd.nome"
				+ " HAVING COUNT(r.id_recensione) >= ?"
				+ " ORDER BY media_voto DESC LIMIT ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, minRecensioni);
			statement.setInt(2, limite);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Album a = extractAlbumFromResultSet(rs);
					a.setMediaVoto(rs.getBigDecimal("media_voto"));
					a.setNumeroRecensioni(rs.getInt("n_recensioni"));
					album.add(a);
				}
			}
		}
		return album;
	}

	//album piu' acquistati (?)
	public Collection<Album> doRetrievePiuAcquistati(int limite) throws SQLException {
		String query = "SELECT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica,"
				+ " COUNT(ro.id_riga_ordine) AS n_vendite"
				+ " FROM album a"
				+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
				+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica"
				+ " JOIN edizione e ON a.id_album = e.id_album"
				+ " JOIN esemplare es ON e.id_edizione = es.id_edizione"
				+ " JOIN riga_ordine ro ON es.id_esemplare = ro.id_esemplare"
				+ " JOIN ordine o ON ro.id_ordine = o.id_ordine"
				+ " WHERE o.stato_ordine <> 'annullato'"
				+ " GROUP BY a.id_album, g.nome, cd.nome"
				+ " ORDER BY n_vendite DESC LIMIT ?";
		return eseguiConIntero(query, limite);
	}

	//album acquistabili (?)
	public Collection<Album> doRetrieveAcquistabili(String formato, int limite) throws SQLException {
		List<Album> album = new ArrayList<>();
		StringBuilder query = new StringBuilder(
				"SELECT DISTINCT a.*, g.nome AS nome_gruppo, cd.nome AS nome_casa_discografica"
				+ " FROM album a"
				+ " JOIN gruppo g ON a.id_gruppo = g.id_gruppo"
				+ " JOIN casa_discografica cd ON a.id_casa_discografica = cd.id_casa_discografica"
				+ " JOIN edizione e ON a.id_album = e.id_album"
				+ " JOIN esemplare es ON e.id_edizione = es.id_edizione"
				+ " WHERE es.disponibile = TRUE");
		if (formato != null && !formato.isEmpty()) query.append(" AND e.formato = ?");
		query.append(" ORDER BY a.visite DESC LIMIT ?");

		try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
			int i = 1;
			if (formato != null && !formato.isEmpty()) statement.setString(i++, formato);
			statement.setInt(i, limite);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) album.add(extractAlbumFromResultSet(rs));
			}
		}
		return album;
	}

	public void incrementaVisite(int idAlbum) throws SQLException {
		String query = "UPDATE album SET visite = visite + 1 WHERE id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			statement.executeUpdate();
		}
	}

	@Override
	public long doSave(Album album) throws SQLException {
		String query = "INSERT INTO album (nome_album, nazione, tipo, data_rilascio, data_inizio_registrazione,"
				+ " data_fine_registrazione, nome_autore_copertina, file_copertina, descrittori,"
				+ " id_gruppo, id_casa_discografica) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		long generatedKey = -1;
		try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, album.getNomeAlbum());
			statement.setString(2, album.getNazione());
			statement.setString(3, album.getTipo());
			statement.setDate(4, album.getDataRilascio());
			statement.setDate(5, album.getDataInizioRegistrazione());
			statement.setDate(6, album.getDataFineRegistrazione());
			statement.setString(7, album.getNomeAutoreCopertina());
			statement.setString(8, album.getFileCopertina());
			statement.setString(9, album.getDescrittori());
			statement.setInt(10, album.getIdGruppo());
			statement.setInt(11, album.getIdCasaDiscografica());
			if (statement.executeUpdate() > 0) {
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (rs.next()) generatedKey = rs.getLong(1);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void doUpdate(Album album) throws SQLException {
		String query = "UPDATE album SET nome_album = ?, nazione = ?, tipo = ?, data_rilascio = ?,"
				+ " data_inizio_registrazione = ?, data_fine_registrazione = ?, nome_autore_copertina = ?,"
				+ " file_copertina = ?, descrittori = ?, id_gruppo = ?, id_casa_discografica = ?"
				+ " WHERE id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, album.getNomeAlbum());
			statement.setString(2, album.getNazione());
			statement.setString(3, album.getTipo());
			statement.setDate(4, album.getDataRilascio());
			statement.setDate(5, album.getDataInizioRegistrazione());
			statement.setDate(6, album.getDataFineRegistrazione());
			statement.setString(7, album.getNomeAutoreCopertina());
			statement.setString(8, album.getFileCopertina());
			statement.setString(9, album.getDescrittori());
			statement.setInt(10, album.getIdGruppo());
			statement.setInt(11, album.getIdCasaDiscografica());
			statement.setInt(12, album.getIdAlbum());
			statement.executeUpdate();
		}
	}

	@Override
	public boolean doDelete(Integer idAlbum) throws SQLException {
		String query = "DELETE FROM album WHERE id_album = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			return statement.executeUpdate() > 0;
		}
	}

	// tabella N:N

	public Collection<String> doRetrieveGeneri(int idAlbum) throws SQLException {
		List<String> generi = new ArrayList<>();
		String query = "SELECT genere FROM album_genere WHERE id_album = ? ORDER BY genere";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) generi.add(rs.getString("genere"));
			}
		}
		return generi;
	}

	public void doAssociaGenere(int idAlbum, String genere) throws SQLException {
		String query = "INSERT IGNORE INTO album_genere (id_album, genere) VALUES (?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			statement.setString(2, genere);
			statement.executeUpdate();
		}
	}

	public boolean doRimuoviGenere(int idAlbum, String genere) throws SQLException {
		String query = "DELETE FROM album_genere WHERE id_album = ? AND genere = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idAlbum);
			statement.setString(2, genere);
			return statement.executeUpdate() > 0;
		}
	}

	private Collection<Album> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Album> album = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) album.add(extractAlbumFromResultSet(rs));
			}
		}
		return album;
	}

	private Album extractAlbumFromResultSet(ResultSet rs) throws SQLException {
		Album album = new Album();
		album.setIdAlbum(rs.getInt("id_album"));
		album.setNomeAlbum(rs.getString("nome_album"));
		album.setNazione(rs.getString("nazione"));
		album.setTipo(rs.getString("tipo"));
		album.setDataRilascio(rs.getDate("data_rilascio"));
		album.setDataInizioRegistrazione(rs.getDate("data_inizio_registrazione"));
		album.setDataFineRegistrazione(rs.getDate("data_fine_registrazione"));
		album.setNomeAutoreCopertina(rs.getString("nome_autore_copertina"));
		album.setFileCopertina(rs.getString("file_copertina"));
		album.setDescrittori(rs.getString("descrittori"));
		album.setIdGruppo(rs.getInt("id_gruppo"));
		album.setIdCasaDiscografica(rs.getInt("id_casa_discografica"));
		album.setVisite(rs.getInt("visite"));
		album.setNomeGruppo(rs.getString("nome_gruppo"));
		album.setNomeCasaDiscografica(rs.getString("nome_casa_discografica"));
		return album;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "nome":          return " ORDER BY a.nome_album";
			case "visite":        return " ORDER BY a.visite DESC";
			case "data_rilascio": return " ORDER BY a.data_rilascio DESC";
			case "gruppo":        return " ORDER BY g.nome, a.data_rilascio";
			default:              return "";
		}
	}
}
