package ecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import ecommerce.Model.User;
import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        try (Session hibernateSession =
                     HibernateUtil.getSessionFactory().openSession()) {

            List<Order> orders = hibernateSession
                    .createQuery("FROM Order WHERE user.id = :userId",
                            Order.class)
                    .setParameter("userId", user.getId())
                    .list();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orders.jsp")
                    .forward(request, response);
        }
    }
}