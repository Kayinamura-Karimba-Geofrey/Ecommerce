package ecommerce.Controller;

import ecommerce.Util.HibernateUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

@WebServlet("/patch-db")
public class SchemaPatchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println("=== Schema Patch Tool ===");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.doWork(connection -> {
                try (Statement stmt = connection.createStatement()) {
                    out.println("Applying patches to 'users' table...");
                    
                    try {
                        stmt.execute("ALTER TABLE users ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN DEFAULT FALSE NOT EXISTS;");
                        // Postgres uses slightly different syntax for existing column check
                    } catch (Exception e) {
                        // Fallback common SQL
                        try { stmt.execute("ALTER TABLE users ADD COLUMN is_blocked BOOLEAN DEFAULT FALSE;"); out.println("- Added is_blocked"); } catch (Exception ex) {}
                    }

                    try {
                        stmt.execute("ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;");
                        out.println("- Added two_factor_enabled");
                    } catch (Exception e) {}

                    try {
                        stmt.execute("ALTER TABLE users ADD COLUMN secret_key VARCHAR(255);");
                        out.println("- Added secret_key");
                    } catch (Exception e) {}

                    out.println("Patch application complete.");
                }
            });
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
