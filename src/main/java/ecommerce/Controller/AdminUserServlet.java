package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserService userService;
    private ecommerce.Services.AuditService auditService;

    @Override
    public void init() {
        userService = new UserService();
        auditService = new ecommerce.Services.AuditService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.findAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.isEmpty()) {
            int userId = Integer.parseInt(idStr);
            User user = userService.findById(userId);
            
            if (user != null) {
                // Prevent admin from modifying their own account status through this panel for safety
                HttpSession session = request.getSession(false);
                User loggedInUser = session != null ? (User) session.getAttribute("loggedUser") : null;
                
                if (loggedInUser != null && loggedInUser.getId() == user.getId()) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=self_modify");
                    return;
                }

                if ("delete".equals(action)) {
                    userService.deleteUser(userId);
                    auditService.logAction(new ecommerce.Model.AuditLog(loggedInUser, "DELETE_USER", String.valueOf(userId), "User " + user.getEmail() + " deleted permanently."));
                } else if ("promote".equals(action)) {
                    user.setRole("ADMIN");
                    userService.saveUser(user);
                    auditService.logAction(new ecommerce.Model.AuditLog(loggedInUser, "PROMOTE_USER", String.valueOf(userId), "User " + user.getEmail() + " promoted to ADMIN."));
                } else if ("block".equals(action)) {
                    user.setBlocked(true);
                    userService.saveUser(user);
                    auditService.logAction(new ecommerce.Model.AuditLog(loggedInUser, "BLOCK_USER", String.valueOf(userId), "User " + user.getEmail() + " blocked."));
                } else if ("unblock".equals(action)) {
                    user.setBlocked(false);
                    userService.saveUser(user);
                    auditService.logAction(new ecommerce.Model.AuditLog(loggedInUser, "UNBLOCK_USER", String.valueOf(userId), "User " + user.getEmail() + " unblocked."));
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
