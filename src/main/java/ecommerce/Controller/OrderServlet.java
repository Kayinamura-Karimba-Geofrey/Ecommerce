package ecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import ecommerce.Model.User;
import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {

            List<Order> orders;

            try {
                if ("ADMIN".equals(user.getRole())) {
                    // Admins see all orders, sorted newest first. Use JOIN FETCH to avoid LazyInitializationException in JSP
                    orders = hibernateSession
                            .createQuery("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.product ORDER BY o.orderDate DESC", Order.class)
                            .list();
                } else {
                    // Users see only their own orders. Use JOIN FETCH for efficiency
                    orders = hibernateSession
                            .createQuery("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.product WHERE o.user.id = :userId ORDER BY o.orderDate DESC", Order.class)
                            .setParameter("userId", user.getId())
                            .list();
                }
            } catch (Exception e) {
                System.err.println("[OrderServlet] Failed to fetch orders: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Failed to load orders: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(403, "Forbidden");
            return;
        }

        String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        try (Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = hibernateSession.beginTransaction();
            Order order = hibernateSession.get(Order.class, Integer.parseInt(orderId));
            if (order != null) {
                order.setStatus(newStatus);
                String tracking = request.getParameter("trackingNumber");
                String delivery = request.getParameter("estimatedDelivery");
                if (tracking != null) order.setTrackingNumber(tracking);
                if (delivery != null && !delivery.trim().isEmpty()) {
                    try {
                        // Handle potential format differences (T vs space, seconds vs no seconds)
                        String formattedDate = delivery.replace(" ", "T");
                        if (formattedDate.length() == 16) formattedDate += ":00"; 
                        order.setEstimatedDelivery(java.time.LocalDateTime.parse(formattedDate));
                    } catch (Exception e) {
                        System.err.println("[OrderServlet] Failed to parse delivery date: " + delivery);
                    }
                }
                hibernateSession.merge(order);
                System.out.println("[OrderServlet] Updated order #" + orderId);
            }
            tx.commit();
        }
        response.sendRedirect("orders");
    }
}