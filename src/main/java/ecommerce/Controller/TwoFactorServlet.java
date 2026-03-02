package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Services.TwoFactorService;
import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/2fa-setup")
public class TwoFactorServlet extends HttpServlet {

    private final TwoFactorService twoFactorService = new TwoFactorService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("setup".equals(action)) {
            try {
                // Generate a fresh secret if the user doesn't have one or is setting up
                String secret = twoFactorService.generateNewSecret();
                String qrUri = twoFactorService.getQrCodeAsDataUri(user.getEmail(), secret);
                
                session.setAttribute("tempSecret", secret);
                request.setAttribute("qrUri", qrUri);
                request.setAttribute("secret", secret);
                request.getRequestDispatcher("/setup-2fa.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("profile.jsp?error=setup_failed");
            }
        } else if ("disable".equals(action)) {
            userService.updateTwoFactorStatus(user.getId(), false);
            userService.updateSecretKey(user.getId(), null);
            user.setTwoFactorEnabled(false);
            user.setSecretKey(null);
            session.setAttribute("loggedUser", user);
            response.sendRedirect("profile.jsp?msg=2fa_disabled");
        } else {
            response.sendRedirect("profile.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String code = request.getParameter("code");
        String secret = (String) session.getAttribute("tempSecret");

        if (secret != null && twoFactorService.verifyCode(secret, code)) {
            userService.updateSecretKey(user.getId(), secret);
            userService.updateTwoFactorStatus(user.getId(), true);
            
            user.setSecretKey(secret);
            user.setTwoFactorEnabled(true);
            session.setAttribute("loggedUser", user);
            session.removeAttribute("tempSecret");
            
            response.sendRedirect("profile.jsp?msg=2fa_enabled");
        } else {
            request.setAttribute("error", "Invalid verification code. Please try again.");
            // Re-generate QR for the same secret if verification fails
            try {
                String qrUri = twoFactorService.getQrCodeAsDataUri(user.getEmail(), secret);
                request.setAttribute("qrUri", qrUri);
                request.setAttribute("secret", secret);
            } catch (Exception ignored) {}
            request.getRequestDispatcher("/setup-2fa.jsp").forward(request, response);
        }
    }
}
