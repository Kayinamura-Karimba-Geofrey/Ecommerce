package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Model.Review;
import ecommerce.Model.User;
import ecommerce.Services.DiscoveryService;
import ecommerce.Services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-review")
public class ReviewServlet extends HttpServlet {
    private final DiscoveryService discoveryService = new DiscoveryService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Product product = productService.getProductById(productId);
        if (product != null) {
            Review review = new Review();
            review.setUser(user);
            review.setProduct(product);
            review.setRating(rating);
            review.setComment(comment);
            
            discoveryService.addReview(review);
            response.sendRedirect("product-details?id=" + productId + "&msg=review_added");
        } else {
            response.sendRedirect("products");
        }
    }
}
