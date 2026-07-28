package com.albumshelf.mvc.model.dao;

import java.sql.SQLException;
import java.util.Collection;

public interface DAOInterface<T, K> {

    // T e' il bean e K e' il tipo della chiave
	T doRetrieveByKey(K code) throws SQLException;

	Collection<T> doRetrieveAll(String order) throws SQLException;

	long doSave(T bean) throws SQLException;

	void doUpdate(T bean) throws SQLException;

	boolean doDelete(K code) throws SQLException;

	void close();
}
