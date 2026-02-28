package ecommerce.filter;

import ecommerce.Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/admin",
        "/admin/*",
        "/checkout",
        "/orders"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (user != null) {
            // Re-fetch user to make sure they haven't been blocked mid-session
            ecommerce.Services.UserService uService = new ecommerce.Services.UserService();
            User latestUser = uService.findById(user.getId());
            
            if (latestUser != null && latestUser.isBlocked()) {
                session.invalidate();
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=blocked");
                return;
            }

            // Role-based access for admin routes
            if (path.startsWith("/admin")) {
                if (!"ADMIN".equals(latestUser.getRole())) {
                    System.out.println("[AuthFilter] Access Denied: User role is " + latestUser.getRole() + ", but ADMIN required for " + path);
                    res.sendRedirect(req.getContextPath() + "/products");
                    return;
                }
            }
            chain.doFilter(request, response);
        } else {
            System.out.println("[AuthFilter] Unauthorized access to " + path + ". Redirecting to login.");
            req.getSession(true).setAttribute("redirectAfterLogin", path);
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}