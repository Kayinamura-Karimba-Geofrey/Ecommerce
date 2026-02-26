package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;

import java.io.IOException;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("products");
            return;
        }

        int id = Integer.parseInt(idStr);
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Product product = session.get(Product.class, id);
            if (product == null) {
                response.sendRedirect("products");
                return;
            }
            request.setAttribute("product", product);
            request.getRequestDispatcher("product-details.jsp").forward(request, response);
        }
    }
}
