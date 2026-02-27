package ecommerce.Controller;

import ecommerce.Model.CartItem;
import ecommerce.Model.Order;
import ecommerce.Model.OrderItem;
import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Services.CartItemService;
import ecommerce.Services.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderService orderService;
    private CartItemService cartService;

    @Override
    public void init() {
        orderService = new OrderService();
        cartService = new CartItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (org.hibernate.Session hibernateSession = ecommerce.Util.HibernateUtil.getSessionFactory().openSession()) {
            List<CartItem> cartItems = hibernateSession.createQuery(
                            "FROM CartItem WHERE user.id = :userId", CartItem.class)
                    .setParameter("userId", user.getId())
                    .list();

            if (cartItems == null || cartItems.isEmpty()) {
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
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String billingAddress = request.getParameter("billingAddress");
        String shippingAddress = request.getParameter("shippingAddress");

        try (org.hibernate.Session hibernateSession = ecommerce.Util.HibernateUtil.getSessionFactory().openSession()) {
            org.hibernate.Transaction tx = hibernateSession.beginTransaction();
            try {

                List<CartItem> cartItems = hibernateSession.createQuery(
                                "FROM CartItem WHERE user.id = :userId", CartItem.class)
                        .setParameter("userId", user.getId())
                        .list();

                if (cartItems == null || cartItems.isEmpty()) {
                    response.sendRedirect("cart");
                    return;
                }

                Order order = new Order();
                order.setOrderDate(java.time.LocalDateTime.now());
                order.setUser(hibernateSession.get(User.class, user.getId()));
                order.setStatus("PAID"); // Assuming payment is confirmed for this flow
                order.setBillingAddress(billingAddress);
                order.setShippingAddress(shippingAddress);

                double subtotal = 0;
                List<OrderItem> orderItemsList = new ArrayList<>();

                for (CartItem cartItem : cartItems) {
                    Product managedProduct = hibernateSession.get(Product.class, cartItem.getProduct().getId());
                    if (managedProduct.getStock() < cartItem.getQuantity()) {
                        throw new Exception("Not enough stock for " + managedProduct.getName());
                    }
                    
                    OrderItem item = new OrderItem();
                    item.setOrder(order);
                    item.setProduct(managedProduct);
                    item.setQuantity(cartItem.getQuantity());
                    item.setPrice(managedProduct.getPrice());

                    managedProduct.setStock(managedProduct.getStock() - cartItem.getQuantity());
                    hibernateSession.merge(managedProduct);

                    subtotal += cartItem.getTotal();
                    orderItemsList.add(item);
                    
                    hibernateSession.remove(cartItem);
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
}
