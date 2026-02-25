package ecommerce.Services;


import ecommerce.Model.Order;
import com.yourpackage.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class OrderDAO {

    public void saveOrder(Order order) {

        Transaction transaction = null;

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.save(order);

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
}