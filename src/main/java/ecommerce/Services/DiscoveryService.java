package ecommerce.Services;

import ecommerce.Model.Review;
import ecommerce.Model.Subscriber;
import ecommerce.Model.WishlistItem;
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

    // --- Wishlist ---
    public void addToWishlist(WishlistItem item) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(item);
            tx.commit();
        }
    }

    public void removeFromWishlist(int userId, int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.createMutationQuery("delete from WishlistItem w where w.user.id = :uid and w.product.id = :pid")
                    .setParameter("uid", userId)
                    .setParameter("pid", productId)
                    .executeUpdate();
            tx.commit();
        }
    }

    public List<WishlistItem> getWishlistByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from WishlistItem w where w.user.id = :uid", WishlistItem.class)
                    .setParameter("uid", userId)
                    .list();
        }
    }

    public boolean isInWishlist(int userId, int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery("select count(w) from WishlistItem w where w.user.id = :uid and w.product.id = :pid", Long.class)
                    .setParameter("uid", userId)
                    .setParameter("pid", productId)
                    .uniqueResult();
            return count != null && count > 0;
        }
    }
}
