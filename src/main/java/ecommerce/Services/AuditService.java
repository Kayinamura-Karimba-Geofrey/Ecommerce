package ecommerce.Services;

import ecommerce.Model.AuditLog;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class AuditService {

    public void logAction(AuditLog log) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(log);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public List<AuditLog> getRecentLogs(int limit) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM AuditLog ORDER BY timestamp DESC", AuditLog.class)
                    .setMaxResults(limit)
                    .list();
        }
    }
}
