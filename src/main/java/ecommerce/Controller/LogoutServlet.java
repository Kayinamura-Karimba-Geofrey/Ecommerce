package ecommerce.Controller;
import jakarta.servlet.http.*;
import java.io.IOException;
import  jakarta.servlet.annotation.WebServlet;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        request.getSession().invalidate();
        response.sendRedirect("login.jsp");
    }
}