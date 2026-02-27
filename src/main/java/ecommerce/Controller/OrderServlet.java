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

            if ("ADMIN".equals(user.getRole())) {
                // Admins see all orders, sorted newest first
                orders = hibernateSession
                        .createQuery("FROM Order ORDER BY orderDate DESC", Order.class)
                        .list();
            } else {
                // Users see only their own orders
                orders = hibernateSession
                        .createQuery("FROM Order WHERE user.id = :userId ORDER BY orderDate DESC", Order.class)
                        .setParameter("userId", user.getId())
                        .list();
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
                hibernateSession.merge(order);
                System.out.println("[OrderServlet] Updated order #" + orderId + " to status: " + newStatus);
            }
            tx.commit();
        }
        response.sendRedirect("orders");
    }
}