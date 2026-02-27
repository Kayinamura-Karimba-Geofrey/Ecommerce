package ecommerce.Controller;

import ecommerce.Model.Order;
import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            // ── KPI Stats ──────────────────────────────────────────────────────
            Long totalUsers = session.createQuery("SELECT COUNT(u) FROM User u", Long.class)
                    .uniqueResult();

            Long totalProducts = session.createQuery("SELECT COUNT(p) FROM Product p", Long.class)
                    .uniqueResult();

            Long totalOrders = session.createQuery("SELECT COUNT(o) FROM Order o", Long.class)
                    .uniqueResult();

            Double totalRevenue = session.createQuery("SELECT SUM(o.totalAmount) FROM Order o", Double.class)
                    .uniqueResult();
            if (totalRevenue == null) totalRevenue = 0.0;

            Long pendingOrders = session.createQuery(
                    "SELECT COUNT(o) FROM Order o WHERE o.status = 'PENDING'", Long.class)
                    .uniqueResult();

            // ── Recent Orders (last 8) ─────────────────────────────────────────
            List<Order> recentOrders = session.createQuery(
                    "FROM Order o ORDER BY o.orderDate DESC", Order.class)
                    .setMaxResults(8)
                    .list();

            // ── Monthly Sales Chart (current year) ────────────────────────────
            List<Object[]> results = session.createQuery(
                    "SELECT MONTH(o.orderDate), SUM(o.totalAmount) " +
                    "FROM Order o " +
                    "WHERE YEAR(o.orderDate) = YEAR(CURRENT_DATE) " +
                    "GROUP BY MONTH(o.orderDate) " +
                    "ORDER BY MONTH(o.orderDate)",
                    Object[].class)
                    .list();

            String[] months = {"", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

            // Build a full 12-month map (0 for months with no data)
            Map<String, Double> monthlySales = new LinkedHashMap<>();
            for (int i = 1; i <= 12; i++) monthlySales.put(months[i], 0.0);

            for (Object[] row : results) {
                Integer monthNum = ((Number) row[0]).intValue();
                Double revenue   = row[1] != null ? ((Number) row[1]).doubleValue() : 0.0;
                monthlySales.put(months[monthNum], revenue);
            }

            StringBuilder labels = new StringBuilder();
            StringBuilder data   = new StringBuilder();
            for (Map.Entry<String, Double> entry : monthlySales.entrySet()) {
                if (labels.length() > 0) { labels.append(","); data.append(","); }
                labels.append("'").append(entry.getKey()).append("'");
                data.append(String.format("%.2f", entry.getValue()));
            }

            // ── Low Stock Alerts (stock < 5) ──────────────────────────────────
            List<Product> lowStockProducts = session.createQuery(
                    "FROM Product p WHERE p.stock < 5 ORDER BY p.stock ASC", Product.class)
                    .list();

            // ── Set Attributes ────────────────────────────────────────────────
            request.setAttribute("totalUsers",      totalUsers);
            request.setAttribute("totalProducts",   totalProducts);
            request.setAttribute("totalOrders",     totalOrders);
            request.setAttribute("totalRevenue",    totalRevenue);
            request.setAttribute("pendingOrders",   pendingOrders);
            request.setAttribute("recentOrders",    recentOrders);
            request.setAttribute("salesLabels",     labels.toString());
            request.setAttribute("salesData",       data.toString());
            request.setAttribute("lowStockProducts", lowStockProducts);

            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        }
    }
}