package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private ProductService productService;
    private ecommerce.Services.CategoryService categoryService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new ecommerce.Services.CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productService.deleteProduct(id);
            response.sendRedirect("admin");
        } else {
            List<Product> products = productService.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");

        if ("add".equals(action)) {
            ecommerce.Model.Category catObj = categoryService.getOrCreateByName(category);
            Product product = new Product(name, description, price, stock, imageUrl, catObj);
            productService.saveProduct(product);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ecommerce.Model.Category catObj = categoryService.getOrCreateByName(category);
            Product product = new Product(id, name, description, price, stock, imageUrl, catObj);
            productService.updateProduct(product);
        }

        response.sendRedirect("admin");
    }
}