package ecommerce.Controller;

import ecommerce.Services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userDAO;

    @Override
    public void init() {
        userDAO = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserService user = user.login(email, password);

        if (user == null) {
            request.setAttribute("error",
                    "Invalid email or password!");
            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);
        } else {

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            response.sendRedirect("products");
        }
    }
}