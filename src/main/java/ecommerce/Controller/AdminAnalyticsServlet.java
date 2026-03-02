package ecommerce.Controller;

import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/analytics")
public class AdminAnalyticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ecommerce.Model.User user = (ecommerce.Model.User) session.getAttribute("loggedUser");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(403, "Forbidden");
            return;
        }

        String format = request.getParameter("format");

        try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            List<Order> orders = hibernateSession.createQuery("FROM Order ORDER BY orderDate DESC", Order.class).list();

            if ("csv".equals(format)) {
                exportToCsv(response, orders);
                return;
            }

            // Group sales by date for the chart
            Map<String, Double> salesByDate = orders.stream()
                .collect(Collectors.groupingBy(
                    o -> o.getOrderDate().toLocalDate().toString(),
                    Collectors.summingDouble(Order::getTotalAmount)
                ));

            request.setAttribute("salesData", salesByDate);
            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
        }
    }

    private void exportToCsv(HttpServletResponse response, List<Order> orders) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"sales_report.csv\"");

        PrintWriter writer = response.getWriter();
        writer.println("Order ID,Date,User,Total,Status,Coupon,Discount");

        for (Order o : orders) {
            writer.printf("%d,%s,%s,%.2f,%s,%s,%.2f%n",
                o.getId(),
                o.getOrderDate().toString(),
                o.getUser().getEmail(),
                o.getTotalAmount(),
                o.getStatus(),
                o.getCouponCode() != null ? o.getCouponCode() : "NONE",
                o.getDiscountAmount()
            );
        }
        writer.flush();
        writer.close();
    }
}
