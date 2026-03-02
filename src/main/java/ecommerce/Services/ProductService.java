package ecommerce.Services;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class ProductService {
    public void saveProduct(Product product) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            session.persist(product);
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

    public List<Product> getAllProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Product p where p.isDeleted = false", Product.class).list();
        }
    }

    public Product getProductById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Product.class, id);
        }
    }

    public void updateProduct(Product product) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            session.merge(product);
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

    public void deleteProduct(int id) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            Product product = session.get(Product.class, id);
            if (product != null) {
                product.setDeleted(true);
                session.merge(product);
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

    public List<Product> getLowStockProducts(int threshold) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Product p where p.isDeleted = false and p.stock < :threshold order by p.stock asc", Product.class)
                    .setParameter("threshold", threshold)
                    .list();
        }
    }

    public List<Product> searchProducts(String query, String category, Double minPrice, Double maxPrice) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from Product p where p.isDeleted = false");
            
            if (query != null && !query.isEmpty()) {
                hql.append(" and (lower(p.name) like :query or lower(p.description) like :query)");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                hql.append(" and p.description like :category"); // Assuming category is in description or add Category entity later
            }
            if (minPrice != null) {
                hql.append(" and p.price >= :minPrice");
            }
            if (maxPrice != null) {
                hql.append(" and p.price <= :maxPrice");
            }

            var hibernateQuery = session.createQuery(hql.toString(), Product.class);

            if (query != null && !query.isEmpty()) {
                hibernateQuery.setParameter("query", "%" + query.toLowerCase() + "%");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                hibernateQuery.setParameter("category", "%" + category + "%");
            }
            if (minPrice != null) {
                hibernateQuery.setParameter("minPrice", minPrice);
            }
            if (maxPrice != null) {
                hibernateQuery.setParameter("maxPrice", maxPrice);
            }

            return hibernateQuery.list();
        }
    }

    public double getAverageRating(int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Double avg = session.createQuery("select avg(r.rating) from Review r where r.product.id = :pid", Double.class)
                    .setParameter("pid", productId)
                    .uniqueResult();
            return avg != null ? avg : 0.0;
        }
    }
}
