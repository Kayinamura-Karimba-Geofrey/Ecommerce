package ecommerce.Controller;

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

    private ProductService productDAO;

    private static final String ATTR_LOGGED_USER = "loggedUser";
    private static final String ATTR_CART = "guestCart"; // reused for all users

    @Override
    public void init() {
        productDAO = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(ATTR_LOGGED_USER);

        System.out.println("[CartItemServlet] Rendering cart. User: " +
                (user != null ? user.getEmail() + " (ID: " + user.getId() + ")" : "guest"));

        Map<Integer, Integer> cartMap = getOrCreateCart(session);
        List<CartItem> cartItems = new java.util.ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : cartMap.entrySet()) {
            Product p = productDAO.getProductById(entry.getKey());
            if (p != null) {
                CartItem ci = new CartItem(null, p, entry.getValue());
                ci.setId(p.getId());
                cartItems.add(ci);
            }
        }
        System.out.println("[CartItemServlet] Found " + cartItems.size() + " items for display.");

        double total = cartItems.stream().mapToDouble(CartItem::getTotal).sum();

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);

        System.out.println("[CartItemServlet] Forwarding to cart.jsp with total: " + total);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(ATTR_LOGGED_USER);

        System.out.println("[CartItemServlet] POST action: " + action + ", User: " +
                (user != null ? user.getEmail() + " (ID: " + user.getId() + ")" : "guest"));

        try {
            if ("add".equals(action)) {
                handleAdd(request, session);
            } else if ("remove".equals(action)) {
                handleRemove(request, session);
            } else if ("update".equals(action)) {
                handleUpdate(request, session);
            }
        } catch (Exception e) {
            System.out.println("[CartItemServlet] Exception handling POST action '" + action + "': " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleAdd(HttpServletRequest request, HttpSession session) {
        String idParam = request.getParameter("productId");
        if (idParam == null || idParam.isBlank()) {
            idParam = request.getParameter("id"); // backward compatibility
        }

        int productId = Integer.parseInt(idParam);
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            System.out.println("[CartItemServlet] handleAdd: Product not found for ID " + productId);
            return;
        }

        Map<Integer, Integer> cart = getOrCreateCart(session);
        cart.put(productId, cart.getOrDefault(productId, 0) + 1);
        session.setAttribute(ATTR_CART, cart);
        System.out.println("[CartItemServlet] handleAdd: Cart now has " + cart.size() + " distinct products.");
    }

    private void handleRemove(HttpServletRequest request, HttpSession session) {
        int id = Integer.parseInt(request.getParameter("id"));
        Map<Integer, Integer> cart = getOrCreateCart(session);
        cart.remove(id);
        session.setAttribute(ATTR_CART, cart);
    }

    private void handleUpdate(HttpServletRequest request, HttpSession session) {
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Map<Integer, Integer> cart = getOrCreateCart(session);
        if (quantity > 0) {
            cart.put(id, quantity);
        } else {
            cart.remove(id);
        }
        session.setAttribute(ATTR_CART, cart);
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getOrCreateCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute(ATTR_CART);
        if (cart == null) {
            cart = new java.util.HashMap<>();
            session.setAttribute(ATTR_CART, cart);
        }
        return cart;
    }
}