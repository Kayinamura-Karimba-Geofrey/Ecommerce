package ecommerce.Util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

public class ReCaptchaValidator {

    // Using Google's public testing reCAPTCHA keys (These will always pass if correctly verified)
    public static final String SITE_KEY = "6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI";
    private static final String SECRET_KEY = "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe";
    private static final String VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public static boolean verify(String gRecaptchaResponse) {
        if (gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) {
            return false;
        }

        try {
            URL url = new URL(VERIFY_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Add POST Request configuration
            connection.setRequestMethod("POST");
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            connection.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            String postParams = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;

            // Send POST Request
            connection.setDoOutput(true);
            try (OutputStream outStream = connection.getOutputStream()) {
                outStream.write(postParams.getBytes());
                outStream.flush();
            }

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                StringBuilder responseString = new StringBuilder();
                try (Scanner scanner = new Scanner(connection.getInputStream())) {
                    while (scanner.hasNextLine()) {
                        responseString.append(scanner.nextLine());
                    }
                }

                // Simple JSON parsing to check for "success": true or "success":true
                String responseBody = responseString.toString();
                return responseBody.contains("\"success\": true") || responseBody.contains("\"success\":true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
