package ecommerce.Controller;

import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import ecommerce.Model.User;

import dev.samstevens.totp.code.CodeVerifier;
import dev.samstevens.totp.code.DefaultCodeGenerator;
import dev.samstevens.totp.time.SystemTimeProvider;
import dev.samstevens.totp.code.DefaultCodeVerifier;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userDAO;
    private CodeVerifier codeVerifier;

    @Override
    public void init() {
        userDAO = new UserService();

        // Initialize TOTP verifier
        DefaultCodeGenerator codeGenerator = new DefaultCodeGenerator();
        SystemTimeProvider timeProvider = new SystemTimeProvider();
        codeVerifier = new DefaultCodeVerifier(codeGenerator, timeProvider);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // If we already validated password and are waiting for 2FA, we should NOT require email/password again.
        User pending2faUser = (User) session.getAttribute("tempUser");
        String totpCode = request.getParameter("totp");

        if (pending2faUser != null && Boolean.TRUE.equals(pending2faUser.isTwoFactorEnabled())) {
            request.setAttribute("email", pending2faUser.getEmail());

            if (totpCode == null || totpCode.trim().isEmpty()) {
                request.getRequestDispatcher("/2FA.jsp").forward(request, response);
                return;
            }

            boolean isCodeValid = codeVerifier.isValidCode(pending2faUser.getSecretKey(), totpCode.trim());
            if (!isCodeValid) {
                request.setAttribute("error", "Invalid 2FA code!");
                request.getRequestDispatcher("/2FA.jsp").forward(request, response);
                return;
            }

            finishLogin(session, pending2faUser);
            redirectAfterLogin(request, response, pending2faUser);
            return;
        }

        // Normal email/password login flow
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = (email == null || email.isBlank()) ? null : userDAO.findByEmail(email);

        if (user == null || password == null || !BCrypt.checkpw(password, user.getPassword())) {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (Boolean.TRUE.equals(user.isTwoFactorEnabled())) {
            // Password verified; now require 2FA code in a separate step.
            session.setAttribute("tempUser", user);
            request.setAttribute("email", user.getEmail());
            request.getRequestDispatcher("/2FA.jsp").forward(request, response);
            return;
        }

        finishLogin(session, user);
        redirectAfterLogin(request, response, user);
    }

    private void finishLogin(HttpSession session, User user) {
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("USER");
        }
        if (user.getFullname() == null || user.getFullname().isEmpty()) {
            user.setFullname("Valued Customer");
        }

        session.setAttribute("loggedUser", user);

        session.removeAttribute("tempUser"); // cleanup temp user (2FA pending)
        System.out.println("[LoginServlet] User logged in: " + user.getEmail() + ", Role: " + user.getRole());
    }

    private void redirectAfterLogin(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        jakarta.servlet.http.HttpSession session = request.getSession();
        String redirectPath = (String) session.getAttribute("redirectAfterLogin");
        
        if (redirectPath != null && !redirectPath.isEmpty()) {
            session.removeAttribute("redirectAfterLogin");
            response.sendRedirect(request.getContextPath() + redirectPath);
            return;
        }

        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect("admin"); // Using /admin for admin dashboard redirect
        } else {
            response.sendRedirect("products");
        }
    }
}