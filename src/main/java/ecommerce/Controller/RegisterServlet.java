package ecommerce.Controller;
import ecommerce.Services.UserService;
import ecommerce.Model.User;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.List;
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userDAO;

    @Override
    public void init() {
        userDAO = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String name       = ecommerce.Util.InputSanitizer.sanitizeLine(request.getParameter("name"));
        String email      = ecommerce.Util.InputSanitizer.sanitizeLine(request.getParameter("email"));
        String rawPassword = request.getParameter("password");
        String role = "USER";

        // ── Input Validation ─────────────────────────────────────────────────
        if (name.isBlank()) {
            request.setAttribute("error", "Full name is required.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!ecommerce.Util.InputSanitizer.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!ecommerce.Util.InputSanitizer.isValidPassword(rawPassword)) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
        User user = new User(name, email, hashedPassword, role);
        userDAO.saveUser(user);

        response.sendRedirect("login.jsp");
    }
}