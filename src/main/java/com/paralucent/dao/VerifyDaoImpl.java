package com.paralucent.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.paralucent.model.Member;
import com.paralucent.model.Status;
import com.paralucent.model.VerifyAccount;

@Repository
public class VerifyDaoImpl extends BaseDao implements VerifyDao {

	public VerifyDaoImpl() {
		super();
		genLogger();
	}

	@Override
	public Member searchByMember(Member member) {
		log.info("userMail: " + member.getUserMail());
		if (StringUtils.isBlank(member.getUserMail())) {
			return null;
		}
		log.info("password: " + member.getUserPassword());
		if (StringUtils.isBlank(member.getUserPassword())) {
			return null;
		}

		List<Member> result = createQuery(
				"select m from Member m join m.mailStatus s"
						+ " where m.userMail = :userMail and m.userPassword = :userPassword"
						+ " and s.stuType = :stuType and s.usageTable = :usageTable", Member.class)
				.setParameter("userMail", member.getUserMail())
				.setParameter("userPassword", member.getUserPassword())
				.setParameter("stuType", "validated")
				.setParameter("usageTable", "member")
				.list();
		log.info("login search result: " + result);
		clearSession();
		if (!result.isEmpty() && result.size() > 0) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public int insertVerify(VerifyAccount verify) {
		log.info("enter insert");
		Session session = beginTransaction();
		VerifyAccount merged = session.merge(verify);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;

	}

	@Override
	public List<Member> queryDuplicateMember(Member member) {
		log.info("enter queryDuplicateMember");
		List<Member> result = new ArrayList<Member>(0);
		if (StringUtils.isBlank(member.getUserMail())) {
			return null;
		}
		result = createQuery("from Member where userMail = :userMail", Member.class)
				.setParameter("userMail", member.getUserMail())
				.list();
		log.info("Query duplicate member size: " + result.size());
		clearSession();
		return result;
	}

	@Override
	public int insertUpdateMember(Member member) {
		log.info("enter insertMember");
		Session session = beginTransaction();
		Member merged = session.merge(member);
		commit();
		Object id = session.getIdentifier(merged);
		clearSession();
		return (Integer) id;
	}

	@Override
	public Status searchStatusByCode(int code) {
		log.info("enter searchStatusByCode");
		List<Status> result = createQuery("from Status where stuCode = :stuCode", Status.class)
				.setParameter("stuCode", code)
				.list();
		clearSession();
		if (!result.isEmpty() && result.size() > 0) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Member searchByKOL(Member memberData) {
		StringBuilder hql = new StringBuilder("from Member where 1 = 1");
		if (StringUtils.isNotBlank(memberData.getUserMail())) {
			hql.append(" and userMail = :userMail");
		}
		if (StringUtils.isNotBlank(memberData.getUserUuid())) {
			hql.append(" and userUuid = :userUuid");
		}
		if (StringUtils.isNotBlank(memberData.getUserName())) {
			hql.append(" and userName = :userName");
		}

		Query<Member> query = createQuery(hql.toString(), Member.class);
		if (StringUtils.isNotBlank(memberData.getUserMail())) {
			query.setParameter("userMail", memberData.getUserMail());
		}
		if (StringUtils.isNotBlank(memberData.getUserUuid())) {
			query.setParameter("userUuid", memberData.getUserUuid());
		}
		if (StringUtils.isNotBlank(memberData.getUserName())) {
			query.setParameter("userName", memberData.getUserName());
		}
		List<Member> result = query.list();
		clearSession();
		if (!result.isEmpty() && result.size() > 0) {
			return result.get(0);
		}
		return null;
	}
}
