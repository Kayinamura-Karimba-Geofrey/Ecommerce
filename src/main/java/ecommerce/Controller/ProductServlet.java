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
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");
        int page = 1;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            StringBuilder hql = new StringBuilder("FROM Product p WHERE 1=1");
            if (search != null && !search.isEmpty()) {
                hql.append(" AND p.name LIKE :search");
            }
            if (category != null && !category.isEmpty()) {
                hql.append(" AND p.category.name = :category");
            }

            // Apply Sorting
            if ("price_low".equals(sort)) {
                hql.append(" ORDER BY p.price ASC");
            } else if ("price_high".equals(sort)) {
                hql.append(" ORDER BY p.price DESC");
            } else if ("newest".equals(sort)) {
                hql.append(" ORDER BY p.id DESC");
            }

            var query = session.createQuery(hql.toString(), Product.class);
            if (search != null && !search.isEmpty()) {
                query.setParameter("search", "%" + search + "%");
            }
            if (category != null && !category.isEmpty()) {
                query.setParameter("category", category);
            }

            query.setFirstResult((page - 1) * PAGE_SIZE);
            query.setMaxResults(PAGE_SIZE);

            List<Product> products = query.list();

            StringBuilder countHql = new StringBuilder("SELECT COUNT(p.id) FROM Product p WHERE 1=1");
            if (search != null && !search.isEmpty()) {
                countHql.append(" AND p.name LIKE :search");
            }
            if (category != null && !category.isEmpty()) {
                countHql.append(" AND p.category.name = :category");
            }

            var countQuery = session.createQuery(countHql.toString(), Long.class);
            if (search != null && !search.isEmpty()) {
                countQuery.setParameter("search", "%" + search + "%");
            }
            if (category != null && !category.isEmpty()) {
                countQuery.setParameter("category", category);
            }

            Long totalProducts = countQuery.uniqueResult();
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

            List<ecommerce.Model.Category> categories = session.createQuery("FROM Category", ecommerce.Model.Category.class).list();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedSort", sort);
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