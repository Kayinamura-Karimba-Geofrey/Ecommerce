package ecommerce.Controller;

import ecommerce.Util.HibernateUtil;
import ecommerce.Model.Order;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            // ===== Dashboard Statistics =====

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

            // ===== Recent Orders =====

            List<Order> recentOrders = session.createQuery(
                            "FROM Order o ORDER BY o.orderDate DESC",
                            Order.class)
                    .setMaxResults(5)
                    .list();

            // ===== Monthly Sales for Chart =====
            // Format: Month Name -> Revenue

            List<Object[]> results = session.createQuery(
                            "SELECT MONTH(o.orderDate), SUM(o.totalAmount) " +
                                    "FROM Order o " +
                                    "GROUP BY MONTH(o.orderDate) " +
                                    "ORDER BY MONTH(o.orderDate)",
                            Object[].class)
                    .list();

            Map<String, Double> monthlySales = new LinkedHashMap<>();

            String[] months = {
                    "", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
            };

            for (Object[] row : results) {
                Integer monthNumber = (Integer) row[0];
                Double revenue = (Double) row[1];

                monthlySales.put(months[monthNumber], revenue);
            }

            // Convert to Chart.js format
            StringBuilder labels = new StringBuilder();
            StringBuilder data = new StringBuilder();

            for (Map.Entry<String, Double> entry : monthlySales.entrySet()) {
                if (labels.length() > 0) labels.append(",");
                if (data.length() > 0) data.append(",");
                
                labels.append("'").append(entry.getKey()).append("'");
                data.append(entry.getValue());
            }

            // ===== Set Attributes =====

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("recentOrders", recentOrders);

            request.setAttribute("salesLabels", labels.toString());
            request.setAttribute("salesData", data.toString());
        }

        // Forward to JSP
        request.getRequestDispatcher("/dashboard.jsp")
                .forward(request, response);
    }
}