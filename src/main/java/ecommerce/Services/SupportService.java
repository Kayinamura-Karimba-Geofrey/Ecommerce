package ecommerce.Services;

import ecommerce.Model.SupportTicket;
import ecommerce.Model.TicketMessage;
import ecommerce.Model.User;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class SupportService {

    public void createTicket(SupportTicket ticket) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(ticket);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public void addMessage(TicketMessage message) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(message);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<SupportTicket> getUserTickets(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM SupportTicket WHERE user.id = :uid ORDER BY createdAt DESC", SupportTicket.class)
                    .setParameter("uid", userId)
                    .list();
        }
    }

    public List<SupportTicket> getAllTickets() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM SupportTicket ORDER BY createdAt DESC", SupportTicket.class).list();
        }
    }

    public SupportTicket getTicket(int ticketId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(SupportTicket.class, ticketId);
        }
    }

    public List<TicketMessage> getTicketMessages(int ticketId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM TicketMessage WHERE ticket.id = :tid ORDER BY createdAt ASC", TicketMessage.class)
                    .setParameter("tid", ticketId)
                    .list();
        }
    }

    public void updateTicketStatus(int ticketId, String status) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            SupportTicket ticket = session.get(SupportTicket.class, ticketId);
            if (ticket != null) {
                ticket.setStatus(status);
                session.merge(ticket);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
}
