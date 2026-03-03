package ecommerce.Controller;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import  org.hibernate.Session;

@WebServlet("/admin/order-details")
public class AdminOrderDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Order order = session.createQuery(
                            "SELECT o FROM Order o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.product WHERE o.id = :id",
                            Order.class)
                    .setParameter("id", id)
                    .uniqueResult();

            request.setAttribute("order", order);

            request.getRequestDispatcher("/order-details.jsp")
                    .forward(request, response);
        }
    }
}