package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = userService.findByEmail(email);

        if (user != null) {
            String token = UUID.randomUUID().toString();
            LocalDateTime expiry = LocalDateTime.now().plusHours(1);
            userService.updateResetToken(user.getId(), token, expiry);
            
            // In a real app, send an email. Here we just log it and simulate success.
            System.out.println("DEBUG: Password reset link: http://localhost:8080/demo1/reset-password?token=" + token);
            request.setAttribute("success", "A reset link has been sent to your email (simulated). Check console for link.");
        } else {
            request.setAttribute("error", "No account found with that email.");
        }
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}
