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

            request.getRequestDispatcher("/admin/manage-orders.jsp")
                    .forward(request, response);
        }
    }
}