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

                    // 2. Run patches
                    String[] queries = {
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN DEFAULT FALSE;",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE;",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS secret_key VARCHAR(255);",
                        "ALTER TABLE users ADD COLUMN IF NOT EXISTS fullname VARCHAR(255);"
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
