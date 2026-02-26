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

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String totpCode = request.getParameter("totp"); // may be null initially

        User user = userDAO.findByEmail(email);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("tempUser", user); // store temp user until 2FA verified

            if (Boolean.TRUE.equals(user.isTwoFactorEnabled())) {
                // If TOTP code not yet provided, redirect to 2FA page
                if (totpCode == null) {
                    request.getRequestDispatcher("/2fa.jsp").forward(request, response);
                    return;
                }

                // Verify TOTP code safely using String
                boolean isCodeValid = false;
                if (totpCode != null && !totpCode.trim().isEmpty()) {
                    isCodeValid = codeVerifier.isValidCode(user.getSecretKey(), totpCode.trim());
                }

                if (!isCodeValid) {
                    request.setAttribute("error", "Invalid 2FA code!");
                    request.getRequestDispatcher("/2fa.jsp").forward(request, response);
                    return;
                }
            }

            // 2FA passed or not required → login
            session.setAttribute("loggedUser", user);
            session.removeAttribute("tempUser"); // cleanup temp user
            System.out.println("[LoginServlet] User logged in: " + user.getEmail() + ", Role: " + user.getRole());

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("products");
            }

        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}