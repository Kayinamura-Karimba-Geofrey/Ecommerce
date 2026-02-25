package ecommerce.Controller;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        Map<Integer, CartItem> cart =
                (Map<Integer, CartItem>) session.getAttribute("cart");

        User user = (User) session.getAttribute("loggedUser");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        Order order = new Order();
        order.setOrderDate(java.time.LocalDateTime.now());
        order.setUser(user);

        double total = 0;

        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem cartItem : cart.values()) {

            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(cartItem.getProduct());
            item.setQuantity(cartItem.getQuantity());
            item.setPrice(cartItem.getProduct().getPrice());

            total += cartItem.getTotalPrice();
            orderItems.add(item);
        }

        order.setItems(orderItems);
        order.setTotalAmount(total);

        orderDAO.saveOrder(order);

        // Clear cart
        session.removeAttribute("cart");

        response.sendRedirect("orders");
    }
}