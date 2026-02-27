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

    private static final String ATTR_LOGGED_USER = "loggedUser";
    private static final String ATTR_GUEST_CART = "guestCart";

    @Override
    public void init() {
        cartDAO= new CartItemService();
        productDAO = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(ATTR_LOGGED_USER);

        System.out.println("[CartItemServlet] Rendering cart. User: " +
                (user != null ? user.getEmail() + " (ID: " + user.getId() + ")" : "guest"));

        List<CartItem> cartItems;

        if (user != null) {
            cartItems = cartDAO.getUserCart(user);
            System.out.println("[CartItemServlet] Found " + cartItems.size() + " DB items for user cart.");
        } else {
            Map<Integer, Integer> guestCart = getOrCreateGuestCart(session);
            cartItems = new java.util.ArrayList<>();
            for (Map.Entry<Integer, Integer> entry : guestCart.entrySet()) {
                Product p = productDAO.getProductById(entry.getKey());
                if (p != null) {
                    CartItem ci = new CartItem(null, p, entry.getValue());
                    ci.setId(p.getId());
                    cartItems.add(ci);
                }
            }
            System.out.println("[CartItemServlet] Found " + cartItems.size() + " guest items for display.");
        }

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
                handleAdd(request, session, user);
            } else if ("remove".equals(action)) {
                handleRemove(request, session, user);
            } else if ("update".equals(action)) {
                handleUpdate(request, session, user);
            }
        } catch (Exception e) {
            System.out.println("[CartItemServlet] Exception handling POST action '" + action + "': " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleAdd(HttpServletRequest request, HttpSession session, User user) {
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

        if (user != null) {
            cartDAO.addToCart(user, product);
        } else {
            Map<Integer, Integer> guestCart = getOrCreateGuestCart(session);
            guestCart.put(productId, guestCart.getOrDefault(productId, 0) + 1);
            session.setAttribute(ATTR_GUEST_CART, guestCart);
            System.out.println("[CartItemServlet] handleAdd: Guest cart now has " + guestCart.size() + " distinct products.");
        }
    }

    private void handleRemove(HttpServletRequest request, HttpSession session, User user) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (user != null) {
            cartDAO.removeItem(id);
        } else {
            Map<Integer, Integer> guestCart = getOrCreateGuestCart(session);
            guestCart.remove(id);
            session.setAttribute(ATTR_GUEST_CART, guestCart);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpSession session, User user) {
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (user != null) {
            cartDAO.updateQuantity(id, quantity);
        } else {
            Map<Integer, Integer> guestCart = getOrCreateGuestCart(session);
            if (quantity > 0) {
                guestCart.put(id, quantity);
            } else {
                guestCart.remove(id);
            }
            session.setAttribute(ATTR_GUEST_CART, guestCart);
        }
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getOrCreateGuestCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute(ATTR_GUEST_CART);
        if (cart == null) {
            cart = new java.util.HashMap<>();
            session.setAttribute(ATTR_GUEST_CART, cart);
        }
        return cart;
    }
}