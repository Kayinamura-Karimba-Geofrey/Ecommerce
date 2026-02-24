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
        System.out.println("[CartItemServlet] Action received: " + action);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            System.out.println("[CartItemServlet] No logged user found. Redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        if ("add".equals(action)) {
            String idStr = request.getParameter("id");
            System.out.println("[CartItemServlet] Adding product ID: " + idStr);
            
            if (idStr != null) {
                int productId = Integer.parseInt(idStr);
                Product product = productDAO.getProductById(productId);

                if (product != null) {
                    cartDAO.addToCart(user, product);
                } else {
                    System.out.println("[CartItemServlet] Product not found for ID: " + productId);
                }
            }

            response.sendRedirect("cart");

        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("id"));
            System.out.println("[CartItemServlet] Removing cart item ID: " + cartItemId);
            cartDAO.removeItem(cartItemId);

            response.sendRedirect("cart");

        } else if ("update".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            System.out.println("[CartItemServlet] Updating cart item ID: " + cartItemId + " to quantity: " + quantity);
            cartDAO.updateQuantity(cartItemId, quantity);

            response.sendRedirect("cart");

        } else {
            System.out.println("[CartItemServlet] Listing cart items for user: " + user.getEmail());
            List<CartItem> cartItems = cartDAO.getUserCart(user);
            double total = cartItems.stream().mapToDouble(CartItem::getTotal).sum();
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", total);

            request.getRequestDispatcher("cart.jsp")
                    .forward(request, response);
        }
    }
}