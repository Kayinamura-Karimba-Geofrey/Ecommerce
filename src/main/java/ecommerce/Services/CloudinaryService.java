package ecommerce.Services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Properties;

public class CloudinaryService {
    private Cloudinary cloudinary;
    private boolean isConfigured = false;

    public CloudinaryService() {
        try {
            // In a real app, these would come from environment variables or a properties file
            // String cloudName = System.getenv("CLOUDINARY_NAME");
            // String apiKey = System.getenv("CLOUDINARY_API_KEY");
            // String apiSecret = System.getenv("CLOUDINARY_API_SECRET");
            
            // For now, we'll check if a placeholder is replaced or if we should use local fallback
            String cloudName = null; 
            String apiKey = null;
            String apiSecret = null;

            if (cloudName != null && apiKey != null && apiSecret != null) {
                cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", cloudName,
                    "api_key", apiKey,
                    "api_secret", apiSecret,
                    "secure", true
                ));
                isConfigured = true;
            }
        } catch (Exception e) {
            System.err.println("Cloudinary configuration failed: " + e.getMessage());
        }
    }

    public String uploadImage(File file) throws IOException {
        if (!isConfigured || cloudinary == null) {
            System.out.println("Cloudinary not configured. Using local path.");
            return null; // Signals to caller to handle locally
        }

        try {
            Map uploadResult = cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
            return (String) uploadResult.get("secure_url");
        } catch (Exception e) {
            System.err.println("Cloudinary upload failed: " + e.getMessage());
            return null;
        }
    }

    public boolean isConfigured() {
        return isConfigured;
    }
}
