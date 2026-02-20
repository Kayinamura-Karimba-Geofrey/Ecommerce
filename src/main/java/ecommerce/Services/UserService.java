package ecommerce.Services;

import ecommerce.Model.User;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserService {

    public void saveUser(User user) {
        Transaction transaction = null;

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public User login(String email, String password) {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Query<User> query = session.createQuery(
                    "FROM User WHERE email = :email AND password = :password",
                    User.class);

            query.setParameter("email", email);
            query.setParameter("password", password);

            return query.uniqueResult();
        }
    }

    public boolean emailExists(String email) {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Query<User> query = session.createQuery(
                    "FROM User WHERE email = :email",
                    User.class);

            query.setParameter("email", email);

            return query.uniqueResult() != null;
        }
    }
    public User findByEmail(String email) {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Query<User> query = session.createQuery(
                    "FROM User WHERE email = :email",
                    User.class);

            query.setParameter("email", email);

            return query.uniqueResult();
        }
    }
}