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
        System.out.println("[CartItemService] addToCart started. User ID: " + (user != null ? user.getId() : "null") + 
                           ", Product ID: " + (product != null ? product.getId() : "null"));
        
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            // Refetch to ensure management
            User managedUser = session.get(User.class, user.getId());
            Product managedProduct = session.get(Product.class, product.getId());
            
            if (managedUser == null || managedProduct == null) {
                System.out.println("[CartItemService] Error: User or Product not found.");
                return;
            }

            // Check if item already exists - Using IDs in query for robustness
            CartItem existingItem = session.createQuery(
                            "FROM CartItem WHERE user.id = :userId AND product.id = :productId",
                            CartItem.class)
                    .setParameter("userId", managedUser.getId())
                    .setParameter("productId", managedProduct.getId())
                    .uniqueResult();

            if (existingItem != null) {
                System.out.println("[CartItemService] Updating existing item ID: " + existingItem.getId());
                existingItem.setQuantity(existingItem.getQuantity() + 1);
                session.merge(existingItem);
            } else {
                System.out.println("[CartItemService] Persisting new CartItem.");
                CartItem cartItem = new CartItem(managedUser, managedProduct, 1);
                session.persist(cartItem);
            }

            transaction.commit();
            System.out.println("[CartItemService] Transaction committed.");
        } catch (Exception e) {
            System.out.println("[CartItemService] Exception in addToCart: " + e.getMessage());
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    // 🔹 Get user's cart
    public List<CartItem> getUserCart(User user) {
        System.out.println("[CartItemService] getUserCart for User ID: " + (user != null ? user.getId() : "null"));
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Querying by user.id to avoid issues with detached user objects in session
            List<CartItem> items = session.createQuery(
                            "FROM CartItem WHERE user.id = :userId",
                            CartItem.class)
                    .setParameter("userId", user.getId())
                    .list();
            System.out.println("[CartItemService] Database returned " + items.size() + " items.");
            return items;
        } catch (Exception e) {
            System.out.println("[CartItemService] Exception in getUserCart: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    // 🔹 Remove item
    public void removeItem(int cartItemId) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            CartItem item = session.get(CartItem.class, cartItemId);
            if (item != null) {
                session.remove(item);
                System.out.println("[CartItemService] Removed CartItem ID: " + cartItemId);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }

    // 🔹 Update quantity
    public void updateQuantity(int cartItemId, int newQuantity) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            CartItem item = session.get(CartItem.class, cartItemId);
            if (item != null) {
                if (newQuantity > 0) {
                    item.setQuantity(newQuantity);
                    session.merge(item);
                } else {
                    session.remove(item);
                }
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
}