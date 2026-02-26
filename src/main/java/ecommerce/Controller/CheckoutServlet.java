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
        // Direct access to checkout via GET is not allowed, redirect to cart
        response.sendRedirect("cart");
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

        try (org.hibernate.Session hibernateSession = ecommerce.Util.HibernateUtil.getSessionFactory().openSession()) {
            org.hibernate.Transaction tx = hibernateSession.beginTransaction();
            try {
                // Fetch cart items for the user
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
                order.setStatus("PENDING");

                double total = 0;
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

                    // Reduce stock
                    managedProduct.setStock(managedProduct.getStock() - cartItem.getQuantity());
                    hibernateSession.merge(managedProduct);

                    total += cartItem.getTotal();
                    orderItemsList.add(item);
                    
                    // Cleanup cart item
                    hibernateSession.remove(cartItem);
                }

                order.setItems(orderItemsList);
                order.setTotalAmount(total);

                hibernateSession.persist(order);
                tx.commit();
                
                System.out.println("[CheckoutServlet] Order created successfully for user: " + user.getEmail());
                response.sendRedirect("orders");
                
            } catch (Exception e) {
                if (tx != null) tx.rollback();
                System.err.println("[CheckoutServlet] Error during checkout: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("cart?error=checkout_failed");
            }
        }
    }
}
