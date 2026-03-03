package ecommerce.Services;

import ecommerce.Model.Review;
import ecommerce.Model.Subscriber;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class DiscoveryService {

    // --- Newsletter ---
    public boolean subscribe(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(new Subscriber(email));
            tx.commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // --- Reviews ---
    public void addReview(Review review) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(review);
            tx.commit();
        }
    }

    public List<Review> getReviewsByProduct(int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Review r where r.product.id = :pid order by r.createdAt desc", Review.class)
                    .setParameter("pid", productId)
                    .list();
        }
    }

}
