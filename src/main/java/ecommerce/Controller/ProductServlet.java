package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Model.Category;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet({"/products", "/admin/products"})
@MultipartConfig
public class ProductServlet extends HttpServlet {

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        int page = 1;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            String hql = "FROM Product p";

            if (search != null && !search.isEmpty()) {
                hql += " WHERE p.name LIKE :search";
            }

            var query = session.createQuery(hql, Product.class);

            if (search != null && !search.isEmpty()) {
                query.setParameter("search", "%" + search + "%");
            }

            query.setFirstResult((page - 1) * PAGE_SIZE);
            query.setMaxResults(PAGE_SIZE);

            List<Product> products = query.list();

            Long totalProducts = session.createQuery(
                    "SELECT COUNT(p.id) FROM Product p",
                    Long.class).uniqueResult();

            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);

        }
        
        String path = request.getServletPath();
        String targetJsp = path.contains("/admin") ? "/manage-products.jsp" : "/products.jsp";
        request.getRequestDispatcher(targetJsp).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Part imagePart = request.getPart("image");

        String uploadPath = getServletContext()
                .getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String fileName = imagePart.getSubmittedFileName();
        imagePart.write(uploadPath + File.separator + fileName);

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            Transaction tx = session.beginTransaction();

            Category category = session.get(Category.class, categoryId);

            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);
            product.setImagePath("uploads/" + fileName);
            product.setCategory(category);

            session.persist(product);
            tx.commit();
        }

        response.sendRedirect(request.getContextPath() + "/products");
    }
}