package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductService productDAO;

    @Override
    public void init() {
        productDAO = new ProductService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = productDAO.getProductById(id);
                request.setAttribute("product", product);
                request.getRequestDispatcher("edit-product.jsp")
                        .forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(deleteId);
                response.sendRedirect("products");
                break;

            default:
                List<Product> list = productDAO.getAllProducts();
                request.setAttribute("productList", list);
                request.getRequestDispatcher("products.jsp")
                        .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = 0;
        if (request.getParameter("id") != null &&
                !request.getParameter("id").isEmpty()) {
            id = Integer.parseInt(request.getParameter("id"));
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("imageurl");
        String category = request.getParameter("category");

        Product product = new Product(name, description, price,
                stock, imageUrl, category);

        if (id > 0) {
            product.setId(id);
            productDAO.updateProduct(product);
        } else {
            productDAO.saveProduct(product);
        }

        response.sendRedirect("products");
    }
}