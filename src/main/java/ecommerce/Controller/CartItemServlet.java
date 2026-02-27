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
import java.util.Map;

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

        // if (user == null) {
        //     response.sendRedirect("login.jsp");
        //     return;
        // }


        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                if (user != null) {
                    cartDAO.addToCart(user, product);
                } else {
                    // Guest Cart
                    Map<Integer, Integer> guestCart = getGuestCart(session);
                    guestCart.put(productId, guestCart.getOrDefault(productId, 0) + 1);
                    session.setAttribute("guestCart", guestCart);
                }
            }
            response.sendRedirect("cart");

        } else if ("remove".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (user != null) {
                cartDAO.removeItem(id);
            } else {
                Map<Integer, Integer> guestCart = getGuestCart(session);
                guestCart.remove(id); // id is productId for guests
                session.setAttribute("guestCart", guestCart);
            }
            response.sendRedirect("cart");

        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (user != null) {
                    cartDAO.updateQuantity(id, quantity);
                } else {
                    Map<Integer, Integer> guestCart = getGuestCart(session);
                    if (quantity > 0) {
                        guestCart.put(id, quantity);
                    } else {
                        guestCart.remove(id);
                    }
                    session.setAttribute("guestCart", guestCart);
                }
            } catch (NumberFormatException e) {
                System.out.println("[CartItemServlet] Invalid number format in update: " + e.getMessage());
            }
            response.sendRedirect("cart");

        } else {
            List<CartItem> cartItems;
            if (user != null) {
                cartItems = cartDAO.getUserCart(user);
                System.out.println("[CartItemServlet] Found " + cartItems.size() + " items for display.");
            } else {
                // Build CartItems from session for display
                Map<Integer, Integer> guestCart = getGuestCart(session);
                cartItems = new java.util.ArrayList<>();
                for (Map.Entry<Integer, Integer> entry : guestCart.entrySet()) {
                    Product p = productDAO.getProductById(entry.getKey());
                    if (p != null) {
                        // For guests, we use Product ID as the CartItem ID so links work
                        CartItem ci = new CartItem(null, p, entry.getValue());
                        ci.setId(p.getId()); 
                        cartItems.add(ci);
                    }
                }
                System.out.println("[CartItemServlet] Found " + cartItems.size() + " items in guest cart for display.");
            }
            
            double total = cartItems.stream().mapToDouble(CartItem::getTotal).sum();
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", total);

            System.out.println("[CartItemServlet] Forwarding to cart.jsp with total: " + total);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    private Map<Integer, Integer> getGuestCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("guestCart");
        if (cart == null) {
            cart = new java.util.HashMap<>();
        }
        return cart;
    }
}