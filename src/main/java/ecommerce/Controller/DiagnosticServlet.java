package ecommerce.Controller;

import ecommerce.Model.User;
import ecommerce.Model.Product;
import ecommerce.Model.CartItem;
import ecommerce.Util.HibernateUtil;
import org.hibernate.Session;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/diag")
public class DiagnosticServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println("=== Store Diagnostics ===");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            HttpSession httpSession = request.getSession(false);
            User loggedUser = (httpSession != null) ? (User) httpSession.getAttribute("loggedUser") : null;
            if (loggedUser != null) {
                out.println("Logged User: " + loggedUser.getEmail());
                out.println("  ID in session: " + loggedUser.getId());
                out.println("  Role in session: " + loggedUser.getRole());
                out.println("  Name in session: " + loggedUser.getFullname());


                User dbUser = session.get(User.class, loggedUser.getId());
                if (dbUser != null) {
                    out.println("  DB Status: FOUND");
                    out.println("  DB ID: " + dbUser.getId());
                    out.println("  DB Role: [" + dbUser.getRole() + "]");
                    out.println("  DB Name: [" + dbUser.getFullname() + "]");
                } else {
                    out.println("  DB Status: NOT FOUND by ID " + loggedUser.getId());
                }
            } else {
                out.println("No user logged in session.");
            }


            out.println("\nAll Users in DB:");
            List<User> users = session.createQuery("FROM User", User.class).list();
            for (User u : users) {
                out.println("- " + u.getEmail() + " (ID: " + u.getId() + ", Role: " + u.getRole() + ", Name: " + u.getFullname() + ")");
            }


            out.println("\nTop 5 Products:");
            List<Product> products = session.createQuery("FROM Product", Product.class).setMaxResults(5).list();
            for (Product p : products) {
                out.println("- " + p.getName() + " (ID: " + p.getId() + ", Stock: " + p.getStock() + ", Price: " + p.getPrice() + ")");
            }



            // Image Patching logic
            String fix = request.getParameter("fix");
            if ("true".equals(fix)) {
                var tx = session.beginTransaction();
                List<Product> allProducts = session.createQuery("FROM Product", Product.class).list();
                String[] commonImages = {"uploads/watch.png", "uploads/headphones.png", "uploads/laptop.png", "uploads/coffee.png"};
                
                for (int i = 0; i < allProducts.size(); i++) {
                    Product p = allProducts.get(i);
                    p.setImagePath(commonImages[i % commonImages.length]);
                    session.merge(p);
                }
                tx.commit();
                out.println("\nSUCCESS: All product image paths have been updated to the premium assets!");
            } else {
                out.println("\nTIP: Visit /diag?fix=true to automatically link all products to the new premium images.");
            }

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
