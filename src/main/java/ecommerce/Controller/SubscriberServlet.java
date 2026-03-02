package ecommerce.Controller;

import ecommerce.Services.DiscoveryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/subscribe")
public class SubscriberServlet extends HttpServlet {
    private final DiscoveryService discoveryService = new DiscoveryService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            discoveryService.subscribe(email);
            response.sendRedirect("products?msg=subscribed");
        } else {
            response.sendRedirect("products?error=invalid_email");
        }
    }
}
