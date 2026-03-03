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
                    out.println("Current Database: " + connection.getCatalog());
                    out.println("Current Schema: " + connection.getSchema());
                    
                    // 1. List existing columns for diagnostics
                    out.println("\nExisting columns in 'users':");
                    try (var rs = connection.getMetaData().getColumns(null, null, "users", null)) {
                        while (rs.next()) {
                            out.println("- " + rs.getString("COLUMN_NAME") + " (" + rs.getString("TYPE_NAME") + ")");
                        }
                    }

                    out.println("\nExisting columns in 'products':");
                    try (var rs = connection.getMetaData().getColumns(null, null, "products", null)) {
                        while (rs.next()) {
                            out.println("- " + rs.getString("COLUMN_NAME") + " (" + rs.getString("TYPE_NAME") + ")");
                        }
                    }

                    out.println("\nExisting columns in 'orders':");
                    try (var rs = connection.getMetaData().getColumns(null, null, "orders", null)) {
                        while (rs.next()) {
                            out.println("- " + rs.getString("COLUMN_NAME") + " (" + rs.getString("TYPE_NAME") + ")");
                        }
                    }

                    // 2. Run patches
                    String[] queries = {
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN DEFAULT FALSE;",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE;",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS secret_key VARCHAR(255);",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS fullname VARCHAR(255);",
                        "ALTER TABLE products ADD COLUMN IF NOT EXISTS is_featured BOOLEAN DEFAULT FALSE;",
            "CREATE TABLE IF NOT EXISTS coupons (" +
                    "id SERIAL PRIMARY KEY, " +
                    "code VARCHAR(50) UNIQUE NOT NULL, " +
                    "discount_percent DOUBLE PRECISION NOT NULL, " +
                    "expiry_date TIMESTAMP, " +
                    "is_active BOOLEAN DEFAULT TRUE)",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS reset_token VARCHAR(255);",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS reset_token_expiry TIMESTAMP;",
                        "ALTER TABLE orders ADD COLUMN IF NOT EXISTS tracking_number VARCHAR(100);",
                        "ALTER TABLE orders ADD COLUMN IF NOT EXISTS estimated_delivery TIMESTAMP;",
                        "ALTER TABLE orders ADD COLUMN IF NOT EXISTS discount_amount DOUBLE PRECISION DEFAULT 0;",
                        "ALTER TABLE orders ADD COLUMN IF NOT EXISTS coupon_code VARCHAR(50);",
                        "CREATE TABLE IF NOT EXISTS subscribers (id SERIAL PRIMARY KEY, email VARCHAR(255) UNIQUE NOT NULL, subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);",
                        "CREATE TABLE IF NOT EXISTS reviews (id SERIAL PRIMARY KEY, user_id INT NOT NULL, product_id INT NOT NULL, rating INT NOT NULL, comment TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id), FOREIGN KEY (product_id) REFERENCES products(id));",
                        "CREATE TABLE IF NOT EXISTS support_tickets (id SERIAL PRIMARY KEY, user_id INT NOT NULL, subject VARCHAR(255) NOT NULL, description TEXT, status VARCHAR(50) DEFAULT 'OPEN', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));",
                        "CREATE TABLE IF NOT EXISTS ticket_messages (id SERIAL PRIMARY KEY, ticket_id INT NOT NULL, sender_id INT NOT NULL, message TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (ticket_id) REFERENCES support_tickets(id), FOREIGN KEY (sender_id) REFERENCES users(id));",
                        "CREATE TABLE IF NOT EXISTS audit_logs (id SERIAL PRIMARY KEY, admin_id INT, action VARCHAR(100) NOT NULL, target_id VARCHAR(50), details TEXT, timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (admin_id) REFERENCES users(id));"
                    };

                    boolean oldAutoCommit = connection.getAutoCommit();
                    connection.setAutoCommit(true); // Ensure direct execution
                    
                    for (String sql : queries) {
                        try (Statement patchStmt = connection.createStatement()) {
                            patchStmt.execute(sql);
                            out.println("SUCCESS: Executed [" + sql + "]");
                        } catch (Exception e) {
                            out.println("INFO: Could not execute [" + sql + "]. Error: " + e.getMessage());
                        }
                    }
                    
                    connection.setAutoCommit(oldAutoCommit);

                    out.println("\nPatch application complete. PLEASE REFRESH THIS PAGE TO VERIFY COLUMNS ABOVE.");
                }
            });
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
