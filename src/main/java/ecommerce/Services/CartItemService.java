package ecommerce.Services;

import ecommerce.Model.CartItem;
import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class CartItemService {

    // 🔹 Add product to cart
    public void addToCart(User user, Product product) {

        Transaction transaction = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            // Check if item already exists
            CartItem existingItem = session.createQuery(
                            "FROM CartItem WHERE user = :user AND product = :product",
                            CartItem.class)
                    .setParameter("user", user)
                    .setParameter("product", product)
                    .uniqueResult();

            if (existingItem != null) {
                existingItem.setQuantity(existingItem.getQuantity() + 1);
                session.merge(existingItem);
            } else {
                CartItem cartItem = new CartItem(user, product, 1);
                session.persist(cartItem);
            }

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    // 🔹 Get user's cart
    public List<CartItem> getUserCart(User user) {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery(
                            "FROM CartItem WHERE user = :user",
                            CartItem.class)
                    .setParameter("user", user)
                    .list();
        }
    }

    // 🔹 Remove item
    public void removeItem(int cartItemId) {

        Transaction transaction = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            CartItem item = session.get(CartItem.class, cartItemId);
            if (item != null) {
                session.remove(item);
            }

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
}