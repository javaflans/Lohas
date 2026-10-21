package com.paralucent.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import jakarta.transaction.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.paralucent.model.Beacon;
import com.paralucent.model.Customer;
import com.paralucent.model.Event;
import com.paralucent.model.EventView;
import com.paralucent.model.HistoryView;
import com.paralucent.model.Member;
import com.paralucent.model.Menus;
import com.paralucent.model.VerifyAccount;
import com.paralucent.viewmodel.HistoryBO;

@Repository
public class DataDaoImpl extends BaseDao implements DataDao {

	public DataDaoImpl() {
		super();
		genLogger();
	}

	@Override
	@Transactional
	public int insert(Member member) {
		Session session = beginTransaction();
		Member merged = session.merge(member);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;
	}

	@Override
	public List<Member> search() {
		beginTransaction();
		List<Member> list = createQuery("from Member", Member.class).list();
		commit();
		clearSession();
		return list;
	}

	@Override
	public Member searchById(String id) {
		Query<Member> query = createQuery("from Member where id = :id", Member.class);
		query.setCacheable(Boolean.TRUE);
		query.setParameter("id", Integer.valueOf(id));
		Member result = query.uniqueResult();
		clearSession();
		return result;
	}

	@Override
	public int update(Member member) {
		Session session = beginTransaction();
		Member merged = session.merge(member);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;
	}

	@Override
	public int delete(Member member) {
		Session session = beginTransaction();
		session.remove(session.merge(member));
		commit();
		clearSession();
		return member.getId();
	}

	@Override
	public int deleteById(String id) {
		Session session = beginTransaction();
		Member member = searchById(id);
		session.remove(session.merge(member));
		commit();
		clearSession();
		return member.getId();
	}

	@Override
	public List<Customer> searchCustomers() {
		beginTransaction();
		List<Customer> result = createQuery("from Customer", Customer.class).list();
		commit();
		clearSession();
		return result;
	}

	@Override
	public List<Menus> searhMenus() {
		List<Menus> result = createQuery(
				"select m from Menus m join m.status s where s.stuType = :stuType and s.usageTable = :usageTable", Menus.class)
				.setParameter("stuType", "enabled")
				.setParameter("usageTable", "menus")
				.list();
		clearSession();
		return result;
	}

	@Override
	public int insert(VerifyAccount verify) {
		Session session = beginTransaction();
		VerifyAccount merged = session.merge(verify);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;

	}

	@Override
	public List<Beacon> queryBeaconList() {
		List<Beacon> result = createQuery("from Beacon where canbeEvent = :canbeEvent", Beacon.class)
				.setParameter("canbeEvent", Boolean.TRUE)
				.list();
		clearSession();
		return result;
	}

	@Override
	public List<Event> queryDuplicateEvent(Event eventBO) {
		log.info("enter queryDuplicateEvent");
		List<Event> result = new ArrayList<Event>(0);

		log.info("event start: " + eventBO.getEventStartDate());
		log.info("event end: " + eventBO.getEventEndDate());

		boolean hasDates = eventBO.getEventStartDate() != null && eventBO.getEventEndDate() != null;
		StringBuilder hql = new StringBuilder("from Event where 1 = 1");
		if (hasDates) {
			hql.append(" and ((eventStartDate <= :startDate and eventEndDate >= :startDate)")
					.append(" or (eventStartDate <= :endDate and eventEndDate >= :endDate))");
		}

		if (eventBO.getBeaconID() != null) {
			hql.append(" and beaconID = :beaconID");
		} else {
			return null;
		}

		Query<Event> query = createQuery(hql.toString(), Event.class);
		if (hasDates) {
			query.setParameter("startDate", eventBO.getEventStartDate());
			query.setParameter("endDate", eventBO.getEventEndDate());
		}
		query.setParameter("beaconID", eventBO.getBeaconID());
		result = query.list();
		log.info("Query duplicate event size: " + result.size());
		clearSession();
		return result;
	}

	@Override
	public int insertUpdateEvent(Event event) {
		log.info("enter insertUpdateEvent");
		Session session = beginTransaction();
		Event merged = session.merge(event);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;
	}

	@Override
	public List<EventView> searchEvents(Event eventBO) {
		log.info("enter searchEvents");
		List<EventView> result = new ArrayList<EventView>(0);
		StringBuilder hql = new StringBuilder("from EventView where 1 = 1");
		if (StringUtils.isNotBlank(eventBO.getEventType())) {
			hql.append(" and eventType = :eventType");
		}

		if (eventBO.getEventStartDate() != null) {
			hql.append(" and eventStartDate >= :eventStartDate");
		}

		if (eventBO.getBeaconID() != null) {
			hql.append(" and beaconID = :beaconID");
		}

		Query<EventView> query = createQuery(hql.toString(), EventView.class);
		if (StringUtils.isNotBlank(eventBO.getEventType())) {
			query.setParameter("eventType", eventBO.getEventType());
		}
		if (eventBO.getEventStartDate() != null) {
			query.setParameter("eventStartDate", eventBO.getEventStartDate());
		}
		if (eventBO.getBeaconID() != null) {
			query.setParameter("beaconID", eventBO.getBeaconID());
		}
		result = query.list();
		log.info("Search event size: " + result.size());
		clearSession();
		return result;
	}

	@Override
	public List<HistoryView> searchHistorys(HistoryBO historyBO) {
		log.info("enter searchHistorys");
		List<HistoryView> result = new ArrayList<HistoryView>(0);
		StringBuilder hql = new StringBuilder("from HistoryView where 1 = 1");
		if (StringUtils.isNotBlank(historyBO.getContactLocalName())) {
			hql.append(" and localName = :localName");
		}

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boolean hasDates = historyBO.getStartDate() != null && historyBO.getEndDate() != null;
		if (hasDates) {
			hql.append(" and tagTime >= :startTime and tagTime <= :endTime");
		}

		Query<HistoryView> query = createQuery(hql.toString(), HistoryView.class);
		if (StringUtils.isNotBlank(historyBO.getContactLocalName())) {
			query.setParameter("localName", historyBO.getContactLocalName());
		}
		if (hasDates) {
			query.setParameter("startTime", formatter.format(historyBO.getStartDate()));
			query.setParameter("endTime", formatter.format(historyBO.getEndDate()));
		}
		result = query.list();

		// Analysis
		int count = 0;
		String name = "-1";
		log.info("Search history size: " + result.size());
		List<HistoryView> views = new ArrayList<HistoryView>(0);
		for (int c = 0; c < result.size(); c++) {
//			log.info(result.get(c).getResidentLocalName() + " TagTime: " + result.get(c).getTagTime() + " beaconID: " + result.get(c).getBeaconID());
			if (StringUtils.equals(result.get(c).getLinkedName(), name)) {
//				if (count < 1 && !StringUtils.equals(result.get(c).getBeaconID(), "00000")) {
				if (count < 1) {
					count++;
				}
			} else {
				count = 0;
				name = result.get(c).getLinkedName();
				if (StringUtils.equals(result.get(c).getBeaconID(), "00000")) {
					views.add(result.get(c));
					int i = 1;
					while (StringUtils.equals((result.get(c+i).getBeaconID()),"00000")) {
						i++;
					}
					views.add(result.get(c+i));
				} else {
					views.add(result.get(c));
				}
			}
		}

//		log.info("==========================================================");

//		for(HistoryView view : views) {
//			log.info(view);
//			log.info(view.getResidentLocalName() + " TagTime: " + view.getTagTime() + " beaconID: " + view.getBeaconID());
//		}

		log.info("Search history size: " + views.size());
		clearSession();

		if(views!=null && views.size()>0){
			Object[] ids = new Object[views.size()];
			for(int i = 0;i<views.size();i++){
				ids[i] = views.get(i).getId();
			}

			views = createQuery("from HistoryView where id in :ids"
					+ " order by isSOS desc, isFreezed2 desc, isFreezed1 desc, isLost desc", HistoryView.class)
					.setParameterList("ids", Arrays.asList(ids))
					.list();
			clearSession();
		}
		return views;
	}

	@Override
	public Event queryEventByTagTime(String tagTime, String beaconID) {
		log.info("enter queryEventByTagTime");
		List<Event> result = new ArrayList<Event>(0);
		StringBuilder hql = new StringBuilder("from Event where 1 = 1");
		if (StringUtils.isNotBlank(beaconID)) {
			hql.append(" and beaconID = :beaconID");
		}

		Date tagDate = null;
		if (tagTime != null) {
			try {
				tagDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tagTime);
				hql.append(" and eventStartDate <= :tagDate and eventEndDate >= :tagDate");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		Query<Event> query = createQuery(hql.toString(), Event.class);
		if (StringUtils.isNotBlank(beaconID)) {
			query.setParameter("beaconID", beaconID);
		}
		if (tagDate != null) {
			query.setParameter("tagDate", tagDate);
		}
		result = query.list();

		clearSession();

		for(Event event : result) {
			log.info("queryEventByTagTime result: " + event.getEventType());
		}


		if(result!=null && result.size()>0){
			return result.get(0);
		} else {
			return null;
		}
	}

	@Override
	public void deleteEvent(EventView event) {
		Session session = beginTransaction();
		List<Event> evts = createQuery("from Event where id = :id", Event.class)
				.setParameter("id", event.getId())
				.list();
		if( evts!=null && evts.size()>0){
			for(Event evt : evts){
				session.remove(evt);
			}
			commit();
		}
		clearSession();
	}
}
