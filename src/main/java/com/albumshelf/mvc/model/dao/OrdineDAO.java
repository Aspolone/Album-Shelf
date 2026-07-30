package com.albumshelf.mvc.model.dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.albumshelf.mvc.model.bean.Carrello;
import com.albumshelf.mvc.model.bean.Ordine;
import com.albumshelf.mvc.model.bean.RigaCarrello;
import com.albumshelf.mvc.model.bean.RigaOrdine;

public class OrdineDAO extends AbstractDAO implements DAOInterface<Ordine, Integer> {

	private static final BigDecimal IVA_DEFAULT = new BigDecimal("22.00");

	public OrdineDAO() throws SQLException {
		super();
	}

	/**
	 * Trasforma il carrello di sessione in un ordine sul database.
	 *
	 * @param idUtente  acquirente
	 * @param carrello  contenuto del carrello preso dalla sessione
	 * @param iva       quota da storicizzare sulle righe (null = 22.00)
	 * @return l'ordine creato, con id e totale valorizzati
	 * @throws EsemplareNonDisponibileException per ovviare alla concorrenza, se viene effettuato l'acquisto nel 
	 * momento in cui un altro utente ha gia' acquistato la stessa copia
	 */
	public Ordine doSaveOrdine(int idUtente, Carrello carrello, BigDecimal iva)
			throws SQLException, EsemplareNonDisponibileException {

		if (carrello == null || carrello.isVuoto())
			throw new IllegalArgumentException("Non si puo' creare un ordine da un carrello vuoto.");

		BigDecimal quota = (iva == null) ? IVA_DEFAULT : iva;

		try {
			connection.setAutoCommit(false);

			BigDecimal subtotale = carrello.getTotale();
			BigDecimal totale = subtotale
					.add(subtotale.multiply(quota).divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP));

			int idOrdine;
			String queryOrdine = "INSERT INTO ordine (totale_pagato, stato_ordine, id_utente)"
					+ " VALUES (?, 'confermato', ?)";
			try (PreparedStatement statement =
					connection.prepareStatement(queryOrdine, Statement.RETURN_GENERATED_KEYS)) {
				statement.setBigDecimal(1, totale);
				statement.setInt(2, idUtente);
				statement.executeUpdate();
				try (ResultSet rs = statement.getGeneratedKeys()) {
					if (!rs.next()) throw new SQLException("Impossibile ottenere l'id dell'ordine creato.");
					idOrdine = rs.getInt(1);
				}
			}

			String queryVendi = "UPDATE esemplare SET disponibile = FALSE"
					+ " WHERE id_esemplare = ? AND disponibile = TRUE";
			String queryRiga = "INSERT INTO riga_ordine (id_ordine, id_esemplare, prezzo_storico, iva_storica)"
					+ " VALUES (?, ?, ?, ?)";

			try (PreparedStatement psVendi = connection.prepareStatement(queryVendi);
			     PreparedStatement psRiga = connection.prepareStatement(queryRiga)) {

				for (RigaCarrello riga : carrello.getRighe()) {
					psVendi.setInt(1, riga.getIdEsemplare());
					if (psVendi.executeUpdate() == 0)
						throw new EsemplareNonDisponibileException(riga.getIdEsemplare());
					psRiga.setInt(1, idOrdine);
					psRiga.setInt(2, riga.getIdEsemplare());
					psRiga.setBigDecimal(3, riga.getPrezzo());
					psRiga.setBigDecimal(4, quota);
					psRiga.executeUpdate();
				}
			}

			connection.commit();

			Ordine ordine = new Ordine();
			ordine.setIdOrdine(idOrdine);
			ordine.setTotalePagato(totale);
			ordine.setStatoOrdine("confermato");
			ordine.setIdUtente(idUtente);
			return ordine;

		} catch (SQLException | EsemplareNonDisponibileException e) {
			connection.rollback();   //annulla ordine
			throw e;
		} finally {
			connection.setAutoCommit(true);
		}
	}

	@Override
	public Ordine doRetrieveByKey(Integer idOrdine) throws SQLException {
		String query = "SELECT * FROM ordine WHERE id_ordine = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idOrdine);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return extractOrdineFromResultSet(rs);
			}
		}
		return null;
	}

	@Override
	public Collection<Ordine> doRetrieveAll(String order) throws SQLException {
		List<Ordine> ordini = new ArrayList<>();
		String query = "SELECT * FROM ordine" + ordinamento(order);
		try (PreparedStatement statement = connection.prepareStatement(query);
		     ResultSet rs = statement.executeQuery()) {
			while (rs.next()) ordini.add(extractOrdineFromResultSet(rs));
		}
		return ordini;
	}

	public Collection<Ordine> doRetrieveByUtente(int idUtente) throws SQLException {
		return eseguiConIntero("SELECT * FROM ordine WHERE id_utente = ? ORDER BY data_ordine DESC", idUtente);
	}

	public Collection<Ordine> doRetrieveFiltrati(String stato, Integer idCliente,
			Timestamp da, Timestamp a) throws SQLException {
		List<Ordine> ordini = new ArrayList<>();
		StringBuilder query = new StringBuilder("SELECT * FROM ordine WHERE 1=1");
		List<Object> parametri = new ArrayList<>();

		if (stato != null) {
			query.append(" AND stato_ordine = ?");
			parametri.add(stato);
		}
		if (idCliente != null) {
			query.append(" AND id_utente = ?");
			parametri.add(idCliente);
		}
		if (da != null) {
			query.append(" AND data_ordine >= ?");
			parametri.add(da);
		}
		if (a != null) {
			query.append(" AND data_ordine < ?");
			parametri.add(a);
		}
		query.append(" ORDER BY data_ordine DESC");

		try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
			for (int i = 0; i < parametri.size(); i++) {
				Object p = parametri.get(i);
				if (p instanceof String) statement.setString(i + 1, (String) p);
				else if (p instanceof Integer) statement.setInt(i + 1, (Integer) p);
				else if (p instanceof Timestamp) statement.setTimestamp(i + 1, (Timestamp) p);
			}
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) ordini.add(extractOrdineFromResultSet(rs));
			}
		}
		return ordini;
	}

	public Collection<Ordine> doRetrieveByStato(String stato) throws SQLException {
		List<Ordine> ordini = new ArrayList<>();
		String query = "SELECT * FROM ordine WHERE stato_ordine = ? ORDER BY data_ordine DESC";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, stato);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) ordini.add(extractOrdineFromResultSet(rs));
			}
		}
		return ordini;
	}

	public Collection<Ordine> doRetrieveVenditeDiUtente(int idVenditore) throws SQLException {
		String query = "SELECT DISTINCT o.* FROM ordine o"
				+ " JOIN riga_ordine ro ON o.id_ordine = ro.id_ordine"
				+ " JOIN esemplare es ON ro.id_esemplare = es.id_esemplare"
				+ " WHERE es.id_utente = ? ORDER BY o.data_ordine DESC";
		return eseguiConIntero(query, idVenditore);
	}

	public Collection<RigaOrdine> doRetrieveRighe(int idOrdine) throws SQLException {
		List<RigaOrdine> righe = new ArrayList<>();
		String query = "SELECT ro.*, a.nome_album, a.file_copertina, e.formato"
				+ " FROM riga_ordine ro"
				+ " LEFT JOIN esemplare es ON ro.id_esemplare = es.id_esemplare"
				+ " LEFT JOIN edizione e ON es.id_edizione = e.id_edizione"
				+ " LEFT JOIN album a ON e.id_album = a.id_album"
				+ " WHERE ro.id_ordine = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idOrdine);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					RigaOrdine riga = new RigaOrdine();
					riga.setIdRigaOrdine(rs.getInt("id_riga_ordine"));
					riga.setIdOrdine(rs.getInt("id_ordine"));
					int idEsemplare = rs.getInt("id_esemplare");
					riga.setIdEsemplare(rs.wasNull() ? null : idEsemplare);
					riga.setPrezzoStorico(rs.getBigDecimal("prezzo_storico"));
					riga.setIvaStorica(rs.getBigDecimal("iva_storica"));
					riga.setNomeAlbum(rs.getString("nome_album"));
					riga.setFileCopertina(rs.getString("file_copertina"));
					riga.setFormato(rs.getString("formato"));
					righe.add(riga);
				}
			}
		}
		return righe;
	}

	@Override
	public void doUpdate(Ordine ordine) throws SQLException {
		String query = "UPDATE ordine SET stato_ordine = ? WHERE id_ordine = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, ordine.getStatoOrdine());
			statement.setInt(2, ordine.getIdOrdine());
			statement.executeUpdate();
		}
	}

	public boolean doUpdateStato(int idOrdine, String nuovoStato) throws SQLException {
		String query = "UPDATE ordine SET stato_ordine = ? WHERE id_ordine = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, nuovoStato);
			statement.setInt(2, idOrdine);
			return statement.executeUpdate() > 0;
		}
	}

	public boolean doAnnulla(int idOrdine) throws SQLException {
		try {
			connection.setAutoCommit(false);

			int aggiornati;
			String queryStato = "UPDATE ordine SET stato_ordine = 'annullato'"
					+ " WHERE id_ordine = ? AND stato_ordine <> 'annullato'";
			try (PreparedStatement statement = connection.prepareStatement(queryStato)) {
				statement.setInt(1, idOrdine);
				aggiornati = statement.executeUpdate();
			}

			if (aggiornati > 0) {
				String queryRimetti = "UPDATE esemplare SET disponibile = TRUE WHERE id_esemplare IN"
						+ " (SELECT id_esemplare FROM riga_ordine"
						+ "  WHERE id_ordine = ? AND id_esemplare IS NOT NULL)";
				try (PreparedStatement statement = connection.prepareStatement(queryRimetti)) {
					statement.setInt(1, idOrdine);
					statement.executeUpdate();
				}
			}

			connection.commit();
			return aggiornati > 0;

		} catch (SQLException e) {
			connection.rollback();
			throw e;
		} finally {
			connection.setAutoCommit(true);
		}
	}

	@Override
	public boolean doDelete(Integer idOrdine) throws SQLException {
		String query = "DELETE FROM ordine WHERE id_ordine = ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, idOrdine);
			return statement.executeUpdate() > 0;
		}
	}

	public BigDecimal getTotaleIncassato(Timestamp da, Timestamp a) throws SQLException {
		String query = "SELECT COALESCE(SUM(totale_pagato), 0) AS totale FROM ordine"
				+ " WHERE stato_ordine <> 'annullato' AND data_ordine BETWEEN ? AND ?";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setTimestamp(1, da);
			statement.setTimestamp(2, a);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) return rs.getBigDecimal("totale");
			}
		}
		return BigDecimal.ZERO;
	}

	private Collection<Ordine> eseguiConIntero(String query, int parametro) throws SQLException {
		List<Ordine> ordini = new ArrayList<>();
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setInt(1, parametro);
			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) ordini.add(extractOrdineFromResultSet(rs));
			}
		}
		return ordini;
	}

	private Ordine extractOrdineFromResultSet(ResultSet rs) throws SQLException {
		Ordine ordine = new Ordine();
		ordine.setIdOrdine(rs.getInt("id_ordine"));
		ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
		ordine.setTotalePagato(rs.getBigDecimal("totale_pagato"));
		ordine.setStatoOrdine(rs.getString("stato_ordine"));
		ordine.setIdUtente(rs.getInt("id_utente"));
		return ordine;
	}

	private String ordinamento(String order) {
		if (order == null) return "";
		switch (order) {
			case "data":   return " ORDER BY data_ordine DESC";
			case "totale": return " ORDER BY totale_pagato DESC";
			default:       return "";
		}
	}

	@Override
	public long doSave(Ordine bean) throws SQLException {
		// TODO Auto-generated method stub
		throw new UnsupportedOperationException("Unimplemented method 'doSave'");
	}
}
