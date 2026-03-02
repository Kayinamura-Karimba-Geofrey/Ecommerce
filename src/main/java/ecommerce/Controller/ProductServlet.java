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

    private static final int PAGE_SIZE = 16;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");
        Double minPrice = request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty() ? Double.parseDouble(request.getParameter("minPrice")) : null;
        Double maxPrice = request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty() ? Double.parseDouble(request.getParameter("maxPrice")) : null;
        int page = 1;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        try (Session session =
                     HibernateUtil.getSessionFactory().openSession()) {

            StringBuilder hql = new StringBuilder("FROM Product p WHERE p.isDeleted = false");
            if (search != null && !search.isEmpty()) {
                hql.append(" AND (lower(p.name) LIKE :search OR lower(p.description) LIKE :search)");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                hql.append(" AND p.category.name = :category");
            }
            if (minPrice != null) {
                hql.append(" AND p.price >= :minPrice");
            }
            if (maxPrice != null) {
                hql.append(" AND p.price <= :maxPrice");
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
                query.setParameter("search", "%" + search.toLowerCase() + "%");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                query.setParameter("category", category);
            }
            if (minPrice != null) query.setParameter("minPrice", minPrice);
            if (maxPrice != null) query.setParameter("maxPrice", maxPrice);

            query.setFirstResult((page - 1) * PAGE_SIZE);
            query.setMaxResults(PAGE_SIZE);

            List<Product> products = query.list();

            StringBuilder countHql = new StringBuilder("SELECT COUNT(p.id) FROM Product p WHERE p.isDeleted = false");
            if (search != null && !search.isEmpty()) {
                countHql.append(" AND (lower(p.name) LIKE :search OR lower(p.description) LIKE :search)");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                countHql.append(" AND p.category.name = :category");
            }
            if (minPrice != null) countHql.append(" AND p.price >= :minPrice");
            if (maxPrice != null) countHql.append(" AND p.price <= :maxPrice");

            var countQuery = session.createQuery(countHql.toString(), Long.class);
            if (search != null && !search.isEmpty()) {
                countQuery.setParameter("search", "%" + search.toLowerCase() + "%");
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)) {
                countQuery.setParameter("category", category);
            }
            if (minPrice != null) countQuery.setParameter("minPrice", minPrice);
            if (maxPrice != null) countQuery.setParameter("maxPrice", maxPrice);

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
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
        }
        
        String path = request.getServletPath();
        String targetJsp = path.contains("/admin") ? "/manage-products.jsp" : "/products.jsp";
        request.getRequestDispatcher(targetJsp).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "add"; // default to add for backwards comp
        
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = session.get(Product.class, id);
                if (product != null) {
                    product.setDeleted(true); // Soft delete
                    session.merge(product);
                }
                tx.commit();
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Add or Edit
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            
            Category category = session.get(Category.class, categoryId);
            Product product;
            
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                product = session.get(Product.class, id);
            } else {
                product = new Product();
            }
            
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);
            product.setCategory(category);
            
            // Handle optional image upload
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                File tempFile = new File(uploadPath + File.separator + fileName);
                imagePart.write(tempFile.getAbsolutePath());
                
                ecommerce.Services.CloudinaryService cloudinaryService = new ecommerce.Services.CloudinaryService();
                String cloudinaryUrl = cloudinaryService.uploadImage(tempFile);
                
                if (cloudinaryUrl != null) {
                    product.setImagePath(cloudinaryUrl);
                    // Optionally delete temp file after upload
                    tempFile.delete();
                } else {
                    product.setImagePath("uploads/" + fileName);
                }
            }
            
            if ("edit".equals(action)) {
                session.merge(product);
            } else {
                session.persist(product);
            }
            
            tx.commit();
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

}