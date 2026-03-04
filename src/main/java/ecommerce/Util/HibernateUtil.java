package ecommerce.Util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {
        try {
            Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

            // Check for Render/Cloud environment variables to override localhost settings dynamically
            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USERNAME");
            String dbPass = System.getenv("DB_PASSWORD");

            if (dbUrl != null && !dbUrl.trim().isEmpty()) {
                configuration.setProperty("hibernate.connection.url", dbUrl);
            }
            if (dbUser != null && !dbUser.trim().isEmpty()) {
                configuration.setProperty("hibernate.connection.username", dbUser);
            }
            if (dbPass != null && !dbPass.trim().isEmpty()) {
                configuration.setProperty("hibernate.connection.password", dbPass);
            }

            sessionFactory = configuration.buildSessionFactory();

        } catch (Throwable ex) {
            System.err.println("SessionFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
