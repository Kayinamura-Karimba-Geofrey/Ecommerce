package ecommerce.Util;

/**
 * InputSanitizer – centralized utility for input validation and XSS prevention.
 * Use these methods when reading user-supplied text that will be stored or rendered.
 */
public class InputSanitizer {

    /**
     * Escape HTML special characters to prevent XSS when echoing user input.
     * Even though JSTL's ${} escapes by default, use this in Servlets.
     */
    public static String escapeHtml(String input) {
        if (input == null) return "";
        return input
            .replace("&",  "&amp;")
            .replace("<",  "&lt;")
            .replace(">",  "&gt;")
            .replace("\"", "&quot;")
            .replace("'",  "&#x27;")
            .replace("/",  "&#x2F;");
    }

    /**
     * Strip any characters that are not printable ASCII.
     * Used for single-line text fields (names, emails, addresses).
     */
    public static String sanitizeLine(String input) {
        if (input == null) return "";
        // Keep only printable ASCII + common international characters
        return input.trim().replaceAll("[\\x00-\\x1F\\x7F]", "");
    }

    /**
     * Validate that an email address has a basic valid format.
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.isBlank()) return false;
        return email.matches("^[a-zA-Z0-9._%+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$");
    }

    /**
     * Validate that a password meets minimum requirements.
     * (at least 6 characters)
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    /**
     * Validate that a string is a safe positive integer within a range.
     */
    public static boolean isValidPositiveInt(String value, int max) {
        try {
            int v = Integer.parseInt(value);
            return v > 0 && v <= max;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
