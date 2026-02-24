package ecommerce.filter;

import ecommerce.Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/products",
        "/cart",
        "/admin"
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
            System.out.println("[AuthFilter] Authenticated user: " + user.getEmail() + ", Role: " + user.getRole() + ", Requesting: " + path);
            // Role-based access for admin
            if (path.startsWith("/admin") && !"ADMIN".equals(user.getRole())) {
                System.out.println("[AuthFilter] Access Denied: User role is " + user.getRole() + ", but ADMIN required.");
                res.sendRedirect(req.getContextPath() + "/products");
                return;
            }
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}