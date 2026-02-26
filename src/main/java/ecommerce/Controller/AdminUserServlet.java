package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<User> users = userService.findAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("updateRole".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String newRole = request.getParameter("role");
            
            User user = userService.findById(userId);
            if (user != null) {
                user.setRole(newRole);
                userService.saveUser(user);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
