package ecommerce.Controller;
import ecommerce.Services.UserService;
import ecommerce.Model.User;

import ecommerce.Services.UserService;
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
        String rawPassword = request.getParameter("password");

// 🔐 Hash password
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        User user = new User(fullname, email, hashedPassword);
        userDAO.saveUser(user);

        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userDAO.emailExists(email)) {
            request.setAttribute("error",
                    "Email already registered!");
            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);
            return;
        }

        User user = new User(fullname, email, password,role);
        userDAO.saveUser(user);

        response.sendRedirect("login.jsp");
    }
}