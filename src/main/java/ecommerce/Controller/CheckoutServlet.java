package ecommerce.Controller;

import ecommerce.Model.CartItem;
import ecommerce.Model.Order;
import ecommerce.Model.OrderItem;
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
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cartItems = cartService.getUserCart(user);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        Order order = new Order();
        order.setOrderDate(java.time.LocalDateTime.now());
        order.setUser(user);
        order.setStatus("PENDING");

        double total = 0;
        List<OrderItem> orderItemsList = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(cartItem.getProduct());
            item.setQuantity(cartItem.getQuantity());
            item.setPrice(cartItem.getProduct().getPrice());

            total += cartItem.getTotal();
            orderItemsList.add(item);
        }

        order.setItems(orderItemsList);
        order.setTotalAmount(total);

        orderService.saveOrder(order);

        // Clear cart from database
        for (CartItem cartItem : cartItems) {
            cartService.removeItem(cartItem.getId());
        }

        response.sendRedirect("orders");
    }
}
