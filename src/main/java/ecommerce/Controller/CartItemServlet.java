package ecommerce.Controller;

import ecommerce.Services.CartItemService;
import ecommerce.Services.ProductService;
import ecommerce.Model.CartItem;
import ecommerce.Model.Product;
import ecommerce.Model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartItemServlet extends HttpServlet {

    private CartItemService cartDAO;
    private ProductService productDAO;

    @Override
    public void init() {
        cartDAO= new CartItemService();
        productDAO = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        System.out.println("[CartItemServlet] Action: " + action + ", User: " + (user != null ? user.getEmail() + " (ID: " + user.getId() + ")" : "null"));

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                cartDAO.addToCart(user, product);
            }
            response.sendRedirect("cart");

        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("id"));
            cartDAO.removeItem(cartItemId);
            response.sendRedirect("cart");

        } else if ("update".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                cartDAO.updateQuantity(cartItemId, quantity);
            } catch (NumberFormatException e) {
                System.out.println("[CartItemServlet] Invalid number format in update: " + e.getMessage());
            }
            response.sendRedirect("cart");

        } else {
            List<CartItem> cartItems = cartDAO.getUserCart(user);
            System.out.println("[CartItemServlet] Found " + cartItems.size() + " items for display.");
            
            double total = cartItems.stream().mapToDouble(CartItem::getTotal).sum();
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", total);

            System.out.println("[CartItemServlet] Forwarding to cart.jsp with total: " + total);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }
}