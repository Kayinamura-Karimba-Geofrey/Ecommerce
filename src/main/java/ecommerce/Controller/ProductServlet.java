package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            // ===== EDIT =====
            if ("edit".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Product product = session.get(Product.class, id);

                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/edit-product.jsp")
                        .forward(request, response);
                return;
            }

            // ===== DELETE =====
            if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                Transaction tx = session.beginTransaction();
                Product product = session.get(Product.class, id);

                if (product != null) {
                    session.remove(product);
                }

                tx.commit();
                response.sendRedirect("products");
                return;
            }

            // ===== LIST PRODUCTS =====
            List<Product> products =
                    session.createQuery("FROM Product",
                            Product.class).list();

            request.setAttribute("products", products);
        }

        request.getRequestDispatcher("/admin/manage-products.jsp")
                .forward(request, response);
    }

    // ===== UPDATE PRODUCT =====
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Transaction tx = session.beginTransaction();

            Product product = session.get(Product.class, id);

            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);

            session.merge(product);

            tx.commit();
        }

        response.sendRedirect("products");
    }
}