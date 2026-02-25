package ecommerce.Controller;

import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
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
                    .createQuery("FROM Order WHERE user = :user",
                            Order.class)
                    .setParameter("user", user)
                    .list();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orders.jsp")
                    .forward(request, response);
        }
    }
}