package com.albumshelf.mvc.model.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.albumshelf.mvc.util.DBConnectionPool;

public abstract class AbstractDAO implements AutoCloseable {

	protected Connection connection;

	public AbstractDAO() throws SQLException {
		this.connection = DBConnectionPool.getConnection();
	}

	@Override
	public void close() {
		if (connection != null) {
			try {
				connection.close();   //restituisce la connessione
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
