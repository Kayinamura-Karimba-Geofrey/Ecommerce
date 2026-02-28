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

import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;

@WebServlet("/admin")
@MultipartConfig
public class AdminServlet extends HttpServlet {

    private ProductService productService;
    private ecommerce.Services.CategoryService categoryService;
    private ecommerce.Services.OrderService orderService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new ecommerce.Services.CategoryService();
        orderService = new ecommerce.Services.OrderService();
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
            
            // Dashboard Data
            request.setAttribute("totalRevenue", orderService.getTotalRevenue());
            request.setAttribute("totalOrdersCount", orderService.getTotalOrdersCount());
            request.setAttribute("recentOrders", orderService.getRecentOrders(5));
            request.setAttribute("lowStockProducts", productService.getLowStockProducts(10));
            
            java.util.Map<String, Double> monthlySales = orderService.getMonthlySales();
            StringBuilder labelsJson = new StringBuilder("[");
            StringBuilder dataJson = new StringBuilder("[");
            boolean first = true;
            for (java.util.Map.Entry<String, Double> entry : monthlySales.entrySet()) {
                if (!first) {
                    labelsJson.append(",");
                    dataJson.append(",");
                }
                labelsJson.append("\"").append(entry.getKey()).append("\"");
                dataJson.append(entry.getValue());
                first = false;
            }
            labelsJson.append("]");
            dataJson.append("]");
            
            request.setAttribute("salesLabels", labelsJson.toString());
            request.setAttribute("salesData", dataJson.toString());

            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");

        double price = (priceStr != null) ? Double.parseDouble(priceStr) : 0;
        int stock = (stockStr != null) ? Integer.parseInt(stockStr) : 0;


        Part imagePart = request.getPart("image");
        String imagePath = null;
        
        if (imagePart != null && imagePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String fileName = imagePart.getSubmittedFileName();
            if (fileName != null && !fileName.isEmpty()) {
                imagePart.write(uploadPath + File.separator + fileName);
                imagePath = "uploads/" + fileName;
            }
        }

        if ("add".equals(action)) {
            ecommerce.Model.Category catObj = categoryService.getOrCreateByName(category);
            Product product = new Product(name, description, price, stock, imagePath, catObj);
            productService.saveProduct(product);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product existingProduct = productService.getProductById(id);
            if (existingProduct != null) {
                ecommerce.Model.Category catObj = categoryService.getOrCreateByName(category);
                existingProduct.setName(name);
                existingProduct.setDescription(description);
                existingProduct.setPrice(price);
                existingProduct.setStock(stock);
                existingProduct.setCategory(catObj);
                if (imagePath != null) {
                    existingProduct.setImagePath(imagePath);
                }
                productService.updateProduct(existingProduct);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }
}