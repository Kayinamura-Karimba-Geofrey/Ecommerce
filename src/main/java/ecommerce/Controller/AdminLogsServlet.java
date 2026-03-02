package ecommerce.Controller;

import ecommerce.Model.AuditLog;
import ecommerce.Model.User;
import ecommerce.Services.AuditService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/logs")
public class AdminLogsServlet extends HttpServlet {

    private AuditService auditService;

    @Override
    public void init() {
        auditService = new AuditService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(403);
            return;
        }

        List<AuditLog> logs = auditService.getRecentLogs(100);
        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/admin-logs.jsp").forward(request, response);
    }
}
