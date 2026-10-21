package com.paralucent.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import com.paralucent.controller.BaseController;

public class BaseDao {

	@Autowired
	SessionFactory sessionFactory;
	Logger log;
	Session session = null;
	Transaction trx = null;

	protected <T> Query<T> createQuery(String hql, Class<T> resultClass){
		return getSession().createQuery(hql, resultClass);
	}

	private Session getSession(){
		if(session != null && session.isConnected() && session.isOpen()) {
			log.info("keeping use current ConnectionSession");
			return session;
		} else {
			log.info("open new ConnectionSession");
			session = sessionFactory.openSession();
			return session;
		}
	}


	protected void genLogger() {
		log = LoggerFactory.getLogger(BaseController.class.getClass().getName());
	}

	protected Session beginTransaction(){
		if(trx==null || !trx.isActive()){
			trx = getSession().beginTransaction();
		}
		return session;
	}

	protected void commit(){
		trx.commit();
	}

	protected void clearSession() {
		session.clear();
		session.close();
	}

}
