package ecommerce.Controller;

import ecommerce.Model.Order;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;

import java.io.IOException;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            int id = Integer.parseInt(idStr);
            Order order = session.get(Order.class, id);

            if (order == null) {
                response.sendRedirect("products");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("order-success.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("products");
        }
    }
}
