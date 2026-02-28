package ecommerce.Services;


import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class OrderService {

    public void saveOrder(Order order) {

        Transaction transaction = null;

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.persist(order);


            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public long getTotalOrdersCount() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery("select count(o) from Order o where o.status != 'Cancelled'", Long.class).uniqueResult();
            return count != null ? count : 0;
        }
    }

    public double getTotalRevenue() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Double total = session.createQuery("select sum(o.totalAmount) from Order o where o.status != 'Cancelled'", Double.class).uniqueResult();
            return total != null ? total : 0.0;
        }
    }

    public java.util.List<Order> getRecentOrders(int limit) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Order o order by o.orderDate desc", Order.class)
                    .setMaxResults(limit)
                    .list();
        }
    }

    public java.util.Map<String, Double> getMonthlySales() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            java.util.List<Order> orders = session.createQuery("from Order o where o.status != 'Cancelled' order by o.orderDate", Order.class).list();
            java.util.Map<String, Double> sales = new java.util.LinkedHashMap<>();
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy");
            
            for (Order order : orders) {
                if (order.getOrderDate() != null) {
                    String month = order.getOrderDate().format(formatter);
                    sales.put(month, sales.getOrDefault(month, 0.0) + order.getTotalAmount());
                }
            }
            return sales;
        }
    }
}