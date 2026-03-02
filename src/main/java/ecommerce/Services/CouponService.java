package ecommerce.Services;

import ecommerce.Model.Coupon;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import java.time.LocalDateTime;
import java.util.Optional;

public class CouponService {

    public Optional<Coupon> validateCoupon(String code) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Coupon WHERE code = :code AND isActive = true", Coupon.class)
                    .setParameter("code", code)
                    .uniqueResultOptional()
                    .filter(coupon -> coupon.getExpiryDate() == null || coupon.getExpiryDate().isAfter(LocalDateTime.now()));
        }
    }

    public void createCoupon(Coupon coupon) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            var tx = session.beginTransaction();
            session.persist(coupon);
            tx.commit();
        }
    }

    public void deactivateCoupon(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            var tx = session.beginTransaction();
            Coupon coupon = session.get(Coupon.class, id);
            if (coupon != null) {
                coupon.setActive(false);
                session.merge(coupon);
            }
            tx.commit();
        }
    }
}
