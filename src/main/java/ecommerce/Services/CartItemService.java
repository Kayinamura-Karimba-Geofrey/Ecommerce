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
        System.out.println("[CartItemService] addToCart started for User: " + (user != null ? user.getEmail() : "null") + 
                           ", Product: " + (product != null ? product.getName() : "null"));
        
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            // Ensure we are working with persistent/managed entities
            User managedUser = session.get(User.class, user.getId());
            Product managedProduct = session.get(Product.class, product.getId());
            
            System.out.println("[CartItemService] Managed User ID: " + (managedUser != null ? managedUser.getId() : "null"));
            System.out.println("[CartItemService] Managed Product ID: " + (managedProduct != null ? managedProduct.getId() : "null"));

            if (managedUser == null || managedProduct == null) {
                System.out.println("[CartItemService] Error: User or Product not found in database.");
                return;
            }

            // Check if item already exists
            CartItem existingItem = session.createQuery(
                            "FROM CartItem WHERE user = :user AND product = :product",
                            CartItem.class)
                    .setParameter("user", managedUser)
                    .setParameter("product", managedProduct)
                    .uniqueResult();

            if (existingItem != null) {
                System.out.println("[CartItemService] Item already exists. Increasing quantity from " + existingItem.getQuantity());
                existingItem.setQuantity(existingItem.getQuantity() + 1);
                session.merge(existingItem);
            } else {
                System.out.println("[CartItemService] Item does not exist. Creating new CartItem.");
                CartItem cartItem = new CartItem(managedUser, managedProduct, 1);
                session.persist(cartItem);
            }

            transaction.commit();
            System.out.println("[CartItemService] Transaction committed successfully.");
        } catch (Exception e) {
            System.out.println("[CartItemService] Transaction failed. Rolling back.");
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
                System.out.println("[CartItemService] Session closed.");
            }
        }
    }

    // 🔹 Get user's cart
    public List<CartItem> getUserCart(User user) {
        System.out.println("[CartItemService] Fetching cart for User: " + (user != null ? user.getEmail() : "null"));
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<CartItem> items = session.createQuery(
                            "FROM CartItem WHERE user = :user",
                            CartItem.class)
                    .setParameter("user", user)
                    .list();
            System.out.println("[CartItemService] Found " + items.size() + " items in cart.");
            return items;
        }
    }

    // 🔹 Remove item
    public void removeItem(int cartItemId) {
        System.out.println("[CartItemService] Removing CartItem ID: " + cartItemId);
        Session session = null;
        Transaction transaction = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            CartItem item = session.get(CartItem.class, cartItemId);
            if (item != null) {
                session.remove(item);
                System.out.println("[CartItemService] Item removed.");
            } else {
                System.out.println("[CartItemService] Item not found.");
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // 🔹 Update quantity
    public void updateQuantity(int cartItemId, int newQuantity) {
        System.out.println("[CartItemService] Updating CartItem ID: " + cartItemId + " to Quantity: " + newQuantity);
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
                    System.out.println("[CartItemService] Quantity updated.");
                } else {
                    session.remove(item);
                    System.out.println("[CartItemService] Quantity reached 0. Item removed.");
                }
            } else {
                System.out.println("[CartItemService] Item not found.");
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}