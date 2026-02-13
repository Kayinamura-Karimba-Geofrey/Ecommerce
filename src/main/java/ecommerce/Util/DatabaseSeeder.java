package ecommerce.Util;

import ecommerce.Model.Product;
import ecommerce.Services.ProductService;

public class DatabaseSeeder {
    public static void main(String[] args) {
        ProductService productService = new ProductService();
        
        Product sampleProduct = new Product(
            "Premium Wireless Headphones",
            "High-quality noise-canceling headphones with 30-hour battery life.",
            199.99,
            50,
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80",
            "Electronics"
        );
        
        System.out.println("Seeding initial product...");
        productService.saveProduct(sampleProduct);
        System.out.println("Product saved successfully: " + sampleProduct.getName());
        
        System.exit(0);
    }
}
