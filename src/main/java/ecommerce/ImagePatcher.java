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

            // High-quality remote placeholder images (no local uploads needed)
            String[] remoteImages = {
                "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800", // phone
                "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800", // laptop
                "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=800", // headphones
                "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=800"  // watch
            };

            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);

                // Only fix broken/local paths (uploads/ or null/empty)
                String current = p.getImagePath();
                if (current == null || current.isBlank() || current.startsWith("uploads/")) {
                    String newPath = remoteImages[i % remoteImages.length];
                    p.setImagePath(newPath);
                    session.merge(p);
                    System.out.println("Updated Product ID " + p.getId() + " with remote path: " + newPath);
                } else {
                    System.out.println("Skipping Product ID " + p.getId() + " (already has remote imagePath).");
                }
            }
            
            tx.commit();
            System.out.println("Database patch complete!");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}
