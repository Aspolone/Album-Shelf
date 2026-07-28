package com.albumshelf.mvc.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnectionPool {

	private static final String JNDI_NAME = "java:comp/env/jdbc/albumshelf_db"; //occhio sempre al nome del db

	private static DataSource dataSource;

	static {
		try {
			Context ctx = new InitialContext();
			dataSource = (DataSource) ctx.lookup(JNDI_NAME);
		} catch (NamingException e) {
			throw new ExceptionInInitializerError(
					"DataSource " + JNDI_NAME + " non trovato: controlla context.xml e web.xml. "
					+ e.getMessage());
		}
	}

	private DBConnectionPool() {}

	public static Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
}
