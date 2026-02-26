package ecommerce.Services;

import ecommerce.Model.Category;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class CategoryService {

    public Category getOrCreateByName(String name) {
        if (name == null || name.trim().isEmpty()) return null;
        
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Category category = session.createQuery("from Category where name = :name", Category.class)
                    .setParameter("name", name)
                    .uniqueResult();
            
            if (category == null) {
                transaction = session.beginTransaction();
                category = new Category();
                category.setName(name);
                session.persist(category);
                transaction.commit();
            }
            return category;
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<Category> getAllCategories() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Category", Category.class).list();
        }
    }
}
