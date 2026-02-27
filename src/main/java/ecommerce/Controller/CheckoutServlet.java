package ecommerce.Controller;

import ecommerce.Model.CartItem;
import ecommerce.Model.Order;
import ecommerce.Model.OrderItem;
import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Services.OrderService;
import ecommerce.Util.HibernateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderService orderService;

    private static final String ATTR_LOGGED_USER = "loggedUser";
    private static final String ATTR_CART = "guestCart"; // same cart as CartItemServlet

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(ATTR_LOGGED_USER);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<Integer, Integer> cart = getCart(session);
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        try (org.hibernate.Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            List<CartItem> cartItems = new ArrayList<>();
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product p = hibernateSession.get(Product.class, entry.getKey());
                if (p != null) {
                    CartItem ci = new CartItem(null, p, entry.getValue());
                    ci.setId(p.getId());
                    cartItems.add(ci);
                }
            }

            if (cartItems.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            double subtotal = cartItems.stream().mapToDouble(CartItem::getTotal).sum();
            double tax = subtotal * 0.10; // 10% tax
            double shipping = subtotal > 200 ? 0 : 15.0; // Free shipping over $200
            double total = subtotal + tax + shipping;

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("tax", tax);
            request.setAttribute("shipping", shipping);
            request.setAttribute("total", total);

            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(ATTR_LOGGED_USER);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<Integer, Integer> cart = getCart(session);
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        String billingAddress = request.getParameter("billingAddress");
        String shippingAddress = request.getParameter("shippingAddress");

        try (org.hibernate.Session hibernateSession = HibernateUtil.getSessionFactory().openSession()) {
            org.hibernate.Transaction tx = hibernateSession.beginTransaction();
            try {
                Order order = new Order();
                order.setOrderDate(java.time.LocalDateTime.now());
                order.setUser(hibernateSession.get(User.class, user.getId()));
                order.setStatus("PAID");
                order.setBillingAddress(billingAddress);
                order.setShippingAddress(shippingAddress);

                double subtotal = 0;
                List<OrderItem> orderItemsList = new ArrayList<>();

                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    int productId = entry.getKey();
                    int quantity = entry.getValue();

                    Product managedProduct = hibernateSession.get(Product.class, productId);
                    if (managedProduct == null) {
                        continue;
                    }
                    if (managedProduct.getStock() < quantity) {
                        throw new Exception("Not enough stock for " + managedProduct.getName());
                    }

                    OrderItem item = new OrderItem();
                    item.setOrder(order);
                    item.setProduct(managedProduct);
                    item.setQuantity(quantity);
                    item.setPrice(managedProduct.getPrice());

                    managedProduct.setStock(managedProduct.getStock() - quantity);
                    hibernateSession.merge(managedProduct);

                    subtotal += managedProduct.getPrice() * quantity;
                    orderItemsList.add(item);
                }

                if (orderItemsList.isEmpty()) {
                    response.sendRedirect("cart");
                    return;
                }

                double tax = subtotal * 0.10;
                double shipping = subtotal > 200 ? 0 : 15.0;
                double total = subtotal + tax + shipping;

                order.setItems(orderItemsList);
                order.setSubtotal(subtotal);
                order.setTax(tax);
                order.setShippingCost(shipping);
                order.setTotalAmount(total);

                hibernateSession.persist(order);
                tx.commit();

                // Clear cart after successful order
                session.removeAttribute(ATTR_CART);

                System.out.println("[CheckoutServlet] Order created successfully: " + order.getId());
                response.sendRedirect("order-success?id=" + order.getId());

            } catch (Exception e) {
                if (tx != null) tx.rollback();
                System.err.println("[CheckoutServlet] Error during checkout: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("cart?error=checkout_failed");
            }
        }
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getCart(HttpSession session) {
        return (Map<Integer, Integer>) session.getAttribute(ATTR_CART);
    }
}
