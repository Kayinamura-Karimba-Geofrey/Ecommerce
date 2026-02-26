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
        String totpCode = request.getParameter("totp");

        User user = userDAO.findByEmail(email);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("tempUser", user);

            if (user.isTwoFactorEnabled()) {
                if (totpCode == null) {
                    request.getRequestDispatcher("/2fa.jsp").forward(request, response);
                    return;
                }


                boolean isCodeValid = false;
                try {
                    int code = Integer.parseInt(totpCode);
                    isCodeValid = codeVerifier.isValidCode(user.getSecretKey(), code);
                } catch (NumberFormatException e) {
                    isCodeValid = false;
                }

                if (!isCodeValid) {
                    request.setAttribute("error", "Invalid 2FA code!");
                    request.getRequestDispatcher("/2fa.jsp").forward(request, response);
                    return;
                }
            }


            session.setAttribute("loggedUser", user);
            session.removeAttribute("tempUser");
            System.out.println("[LoginServlet] User logged in: " + user.getEmail() + ", Role: " + user.getRole());

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("products");
            }

        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}