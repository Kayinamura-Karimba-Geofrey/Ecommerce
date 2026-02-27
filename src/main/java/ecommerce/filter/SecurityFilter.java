package ecommerce.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

/**
 * SecurityFilter – applied to every request.
 * Implements:
 *   1. Security response headers (XSS, clickjacking, MIME-sniff prevention)
 *   2. Session timeout enforcement (30 min)
 *   3. CSRF token generation (set in session, validated on POST)
 *   4. Cache-control for sensitive pages
 */
@WebFilter("/*")
public class SecurityFilter implements Filter {

    // Pages that are POST-safe without a CSRF token (public forms)
    private static final java.util.Set<String> CSRF_EXEMPT = java.util.Set.of(
        "/login", "/register"
    );

    // Paths considered "sensitive" — disable caching
    private static final java.util.Set<String> NO_CACHE_PATHS = java.util.Set.of(
        "/cart", "/checkout", "/orders", "/admin"
    );

    private static final int SESSION_TIMEOUT_SECONDS = 30 * 60; // 30 minutes

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // ── 1. Security Headers ───────────────────────────────────────────────
        // Prevent XSS in older browsers
        res.setHeader("X-XSS-Protection", "1; mode=block");
        // Prevent MIME-type sniffing
        res.setHeader("X-Content-Type-Options", "nosniff");
        // Prevent clickjacking
        res.setHeader("X-Frame-Options", "SAMEORIGIN");
        // HSTS (uncomment when using HTTPS in production)
        // res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        // Referrer policy
        res.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // ── 2. No-cache for sensitive paths ───────────────────────────────────
        for (String noCache : NO_CACHE_PATHS) {
            if (path.startsWith(noCache)) {
                res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                res.setHeader("Pragma", "no-cache");
                res.setDateHeader("Expires", 0);
                break;
            }
        }

        // ── 3. Session Timeout ────────────────────────────────────────────────
        HttpSession session = req.getSession(true);
        if (session != null) {
            session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);
        }

        // ── 4. CSRF Protection ────────────────────────────────────────────────
        // Generate a CSRF token for any active session
        if (session != null && session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }

        // Validate CSRF token on state-mutating POST requests (except exempt paths)
        if ("POST".equalsIgnoreCase(req.getMethod()) && !CSRF_EXEMPT.contains(path)) {
            String sessionToken  = (session != null) ? (String) session.getAttribute("csrfToken") : null;
            String requestToken  = req.getParameter("_csrf");

            if (sessionToken == null || !sessionToken.equals(requestToken)) {
                System.out.println("[SecurityFilter] CSRF token mismatch on POST to: " + path);
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
