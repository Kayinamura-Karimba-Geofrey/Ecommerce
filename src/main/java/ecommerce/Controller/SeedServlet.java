package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Model.Product;
import ecommerce.Services.UserService;
import ecommerce.Services.ProductService;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/seed")
public class SeedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println("--- Store Diagnostic Seeder ---");

        try {
            UserService userService = new UserService();
            User existingUser = userService.findByEmail("john@gmail.com");

            if (existingUser != null) {
                out.println("User john@gmail.com found. Current Role: " + existingUser.getRole());
                out.println("Force-updating role back to ADMIN...");
                existingUser.setRole("ADMIN");
                // Explicitly update to ensure persistence
                userService.saveUser(existingUser); 
                out.println("Role updated successfully.");
            } else {
                out.println("User john@gmail.com not found. Creating new admin...");
                User admin = new User();
                admin.setFullname("John Admin");
                admin.setEmail("john@gmail.com");
                admin.setPassword(BCrypt.hashpw("1234", BCrypt.gensalt()));
                admin.setRole("ADMIN");
                userService.saveUser(admin);
                out.println("Admin user created successfully.");
            }

            out.println("\n--- Result Summary ---");
            User verifiedUser = userService.findByEmail("john@gmail.com");
            out.println("Final Role for " + verifiedUser.getEmail() + ": " + verifiedUser.getRole());
            
            out.println("\nNext Step: LOGOUT and LOGIN again to refresh your session!");
            
        } catch (Exception e) {
            out.println("ERROR: Seeding failed!");
            e.printStackTrace(out);
        }
    }
}
