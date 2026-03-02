package ecommerce.Controller;

import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Model.WishlistItem;
import ecommerce.Services.DiscoveryService;
import ecommerce.Services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private final DiscoveryService discoveryService = new DiscoveryService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            if (!discoveryService.isInWishlist(user.getId(), productId)) {
                Product product = productService.getProductById(productId);
                WishlistItem item = new WishlistItem();
                item.setUser(user);
                item.setProduct(product);
                discoveryService.addToWishlist(item);
            }
            response.sendRedirect("product-details?id=" + productId + "&msg=wishlist_added");
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            discoveryService.removeFromWishlist(user.getId(), productId);
            response.sendRedirect("wishlist");
        } else {
            List<WishlistItem> items = discoveryService.getWishlistByUser(user.getId());
            request.setAttribute("wishlistItems", items);
            request.getRequestDispatcher("/wishlist.jsp").forward(request, response);
        }
    }
}
