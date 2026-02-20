package ecommerce.Controller;

import ecommerce.Services.CartItemService;
import ecommerce.Services.ProductService;
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
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("pages/login.jsp");
            return;
        }

        if ("add".equals(action)) {

            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);

            cartDAO.addToCart(user, product);

            response.sendRedirect("cart");

        } else if ("remove".equals(action)) {

            int cartItemId = Integer.parseInt(request.getParameter("id"));
            cartDAO.removeItem(cartItemId);

            response.sendRedirect("cart");

        } else {

            List<?> cartItems = cartDAO.getUserCart(user);
            request.setAttribute("cartItems", cartItems);

            request.getRequestDispatcher("pages/cart.jsp")
                    .forward(request, response);
        }
    }
}