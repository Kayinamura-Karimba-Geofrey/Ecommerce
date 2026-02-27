package ecommerce;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import java.util.List;

public class DBCheck {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<Product> products = session.createQuery("FROM Product", Product.class).list();
            System.out.println("--- CURRENT PRODUCT PATHS ---");
            for (Product p : products) {
                System.out.println("ID: " + p.getId() + " | Name: " + p.getName() + " | Path: " + p.getImagePath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}
