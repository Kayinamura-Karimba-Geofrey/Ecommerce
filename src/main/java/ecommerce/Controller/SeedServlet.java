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
        out.println("Starting seeding process...");

        try {
            // Seed Admin User
            UserService userService = new UserService();
            if (!userService.emailExists("john@gmail.com")) {
                out.println("Seeding admin user...");
                User admin = new User();
                admin.setFullname("John Admin");
                admin.setEmail("john@gmail.com");
                admin.setPassword(BCrypt.hashpw("1234", BCrypt.gensalt()));
                admin.setRole("ADMIN");
                userService.saveUser(admin);
                out.println("Admin user seeded: john@gmail.com / 1234");
            } else {
                out.println("Admin user already exists.");
            }

            // Optional: Seed products if needed
            out.println("Seeding products...");
            ProductService productService = new ProductService();
            // Add a few test products if the list is empty
            if (productService.getAllProducts().isEmpty()) {
                productService.saveProduct(new Product("Admin Test Product", "Verified by seeder", 99.99, 10, "", "Test"));
                out.println("Test product added.");
            }

            out.println("Seeding completed successfully.");
        } catch (Exception e) {
            out.println("Error during seeding:");
            e.printStackTrace(out);
        }
    }
}
