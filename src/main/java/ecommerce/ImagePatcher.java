package ecommerce;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class ImagePatcher {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            List<Product> products = session.createQuery("FROM Product", Product.class).list();
            
            String[] commonImages = {"uploads/watch.png", "uploads/headphones.png", "uploads/laptop.png", "uploads/coffee.png"};
            
            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                p.setImagePath(commonImages[i % commonImages.length]);
                session.merge(p);
                System.out.println("Updated Product ID " + p.getId() + " with path: " + p.getImagePath());
            }
            
            tx.commit();
            System.out.println("Database patch complete!");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}
