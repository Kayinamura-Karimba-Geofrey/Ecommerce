package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import java.util.List;

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

            // Fetch Related Products (same category, excluding current)
            List<Product> relatedProducts = session.createQuery(
                "FROM Product p WHERE p.category = :cat AND p.id != :pid", Product.class)
                .setParameter("cat", product.getCategory())
                .setParameter("pid", product.getId())
                .setMaxResults(4)
                .list();

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            request.getRequestDispatcher("product-details.jsp").forward(request, response);
        }
    }
}
