package ecommerce.Controller;
import java.util.List;
import ecommerce.Util.HibernateUtil;
import ecommerce.Model.Order;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Long totalUsers = session.createQuery(
                            "SELECT COUNT(u) FROM User u", Long.class)
                    .uniqueResult();

            Long totalProducts = session.createQuery(
                            "SELECT COUNT(p) FROM Product p", Long.class)
                    .uniqueResult();

            Long totalOrders = session.createQuery(
                            "SELECT COUNT(o) FROM Order o", Long.class)
                    .uniqueResult();

            Double totalRevenue = session.createQuery(
                            "SELECT SUM(o.totalAmount) FROM Order o",
                            Double.class)
                    .uniqueResult();

            if (totalRevenue == null) {
                totalRevenue = 0.0;
            }

            List<Order> recentOrders = session.createQuery(
                            "FROM Order o ORDER BY o.orderDate DESC",
                            Order.class)
                    .setMaxResults(5)
                    .list();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("recentOrders", recentOrders);
        }
    }
}