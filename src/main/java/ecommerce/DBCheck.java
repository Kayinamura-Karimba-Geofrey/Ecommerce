package ecommerce;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import java.util.List;

public class DBCheck {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<Product> products = session.createQuery("FROM Product", Product.class).list();
            System.out.println("--- PRODUCT IMAGE PATHS ---");
            for (Product p : products) {
                System.out.println("ID: " + p.getId() + " | Name: " + p.getName() + " | ImagePath: " + p.getImagePath());
            }
            System.out.println("---------------------------");
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }
}
