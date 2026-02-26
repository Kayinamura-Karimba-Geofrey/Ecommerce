package ecommerce.Controller;
import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage-orders")
public class AdminManageOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            List<Order> orders = session.createQuery(
                            "FROM Order o ORDER BY o.orderDate DESC",
                            Order.class)
                    .list();

            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/manage-orders.jsp")
                    .forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            var tx = session.beginTransaction();
            Order order = session.get(Order.class, orderId);
            if (order != null) {
                order.setStatus(newStatus);
                session.merge(order);
                System.out.println("[AdminManageOrdersServlet] Updated Order #" + orderId + " to " + newStatus);
            }
            tx.commit();
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
    }
}