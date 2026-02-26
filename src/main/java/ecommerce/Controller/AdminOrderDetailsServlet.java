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

            Order order = session.get(Order.class, id);

            request.setAttribute("order", order);

            request.getRequestDispatcher("/order-details.jsp")
                    .forward(request, response);
        }
    }
}