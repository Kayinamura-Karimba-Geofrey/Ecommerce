package ecommerce.Util;

import ecommerce.Model.Product;
import ecommerce.Model.User;
import ecommerce.Services.ProductService;
import ecommerce.Services.UserService;
import org.mindrot.jbcrypt.BCrypt;

public class DatabaseSeeder {
    public static void main(String[] args) {
        ProductService productService = new ProductService();
        
        Product[] products = {
            // Electronics
            new Product("Smartphone X1", "Latest flagship smartphone with AMOLED display.", 799.99, 50, "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800", "Electronics"),
            new Product("Laptop Pro 15", "High-performance laptop for professionals.", 1299.99, 30, "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800", "Electronics"),
            new Product("Ultra Tab 10", "Slim tablet with 10-inch crystal clear display.", 349.99, 45, "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800", "Electronics"),
            new Product("DSLR Camera Z9", "Professional grade camera for stunning photography.", 899.99, 15, "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800", "Electronics"),
            new Product("Smartwatch Series 5", "Track your health and stay connected.", 199.99, 100, "https://images.unsplash.com/photo-1544117518-30df57809ca7?w=800", "Electronics"),
            
            // Home Appliances
            new Product("Smoothie Blender", "Powerful blender for healthy smoothies.", 59.99, 40, "https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=800", "Home Appliances"),
            new Product("Espresso Maker", "Brew professional quality coffee at home.", 149.99, 25, "https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=800", "Home Appliances"),
            new Product("Modern Toaster", "Two-slot toaster with adjustable browning.", 29.99, 60, "https://images.unsplash.com/photo-1520627993041-399ea4348631?w=800", "Home Appliances"),
            new Product("Robot Vacuum", "Keep your floors clean effortlessly.", 249.99, 20, "https://images.unsplash.com/photo-1518349619113-03114f06ac3a?w=800", "Home Appliances"),
            new Product("Air Purifier Pro", "Clean air for a healthier home environment.", 129.99, 35, "https://images.unsplash.com/photo-1585771724684-2827df011421?w=800", "Home Appliances"),
            
            // Fashion
            new Product("Classic White T-Shirt", "Essential cotton t-shirt for daily wear.", 19.99, 200, "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800", "Fashion"),
            new Product("Slim Fit Jeans", "Stylish denim jeans for a modern look.", 49.99, 150, "https://images.unsplash.com/photo-1542272604-787c3835535d?w=800", "Fashion"),
            new Product("Winter Bomber Jacket", "Keep warm and stylish this winter.", 89.99, 80, "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800", "Fashion"),
            new Product("Urban Sneakers", "Comfortable sneakers for city walks.", 59.99, 120, "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800", "Fashion"),
            new Product("Retro Sunglasses", "Iconic style with UV protection.", 24.99, 90, "https://images.unsplash.com/photo-1511499767da1-09757f04071b?w=800", "Fashion"),
            
            // Books & Hobbies
            new Product("Science Fiction Novel", "An epic journey through the stars.", 14.99, 300, "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800", "Books"),
            new Product("Gourmet Cookbook", "Master the art of fine dining at home.", 29.99, 110, "https://images.unsplash.com/photo-1589923188900-85dae523321c?w=800", "Books"),
            new Product("Eco-Friendly Yoga Mat", "Durable and non-slip mat for your practice.", 34.99, 75, "https://images.unsplash.com/photo-1599447421416-3414500d18a5?w=800", "Hobbies"),
            new Product("Dumbbell Set (10kg)", "Perfect for home strength training.", 44.99, 40, "https://images.unsplash.com/photo-1583454110551-21f2fa200c0f?w=800", "Hobbies"),
            new Product("Strategy Board Game", "Fun for all ages with endless replayability.", 39.99, 55, "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=800", "Hobbies"),
            
            // Beauty & Personal Care
            new Product("Hydrating Moisturizer", "Keep your skin soft and hydrated all day.", 22.99, 140, "https://images.unsplash.com/photo-1556228720-195a672e8a03?w=800", "Beauty"),
            new Product("Organic Shampoo", "Gentle care with natural ingredients.", 18.99, 180, "https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=800", "Beauty"),
            new Product("Midnight Perfume", "A captivating scent for evening wear.", 74.99, 65, "https://images.unsplash.com/photo-1541643600914-78b084683601?w=800", "Beauty"),
            new Product("Electric Toothbrush", "Advanced cleaning for a brighter smile.", 69.99, 85, "https://images.unsplash.com/photo-1559591937-e62058428384?w=800", "Beauty"),
            new Product("Ionic Hair Dryer", "Fast drying with reduced frizz.", 49.99, 50, "https://images.unsplash.com/photo-1522338140262-f434253a479a?w=800", "Beauty"),
            
            // Home Decor & Furniture
            new Product("Minimalist Floor Lamp", "Warm lighting for a cozy atmosphere.", 84.99, 30, "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=800", "Home Decor"),
            new Product("Velvet Cushion Set", "Add a touch of luxury to your sofa.", 39.99, 100, "https://images.unsplash.com/photo-1584132967334-10e028bd69f7?w=800", "Home Decor"),
            new Product("Modern Wall Clock", "Keep time with style.", 24.99, 70, "https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?w=800", "Home Decor"),
            new Product("Ergonomic Office Chair", "Comfortable support for long working hours.", 189.99, 25, "https://images.unsplash.com/photo-1505797149-35ebcb05a6fd?w=800", "Furniture"),
            new Product("Wooden Bookshelf", "Elegant storage for your home library.", 149.99, 15, "https://images.unsplash.com/photo-1594620302200-9a7622d4a137?w=800", "Furniture")
        };
        
        System.out.println("Seeding 30 products into the database...");
        for (Product p : products) {
            productService.saveProduct(p);
            System.out.println("Saved: " + p.getName());
        }
        System.out.println("Database seeding completed successfully.");

        // Seed Admin User
        UserService userService = new UserService();
        if (!userService.emailExists("john@gmail.com")) {
            System.out.println("Seeding admin user...");
            User admin = new User();
            admin.setFullname("John Admin");
            admin.setEmail("john@gmail.com");
            admin.setPassword(BCrypt.hashpw("1234", BCrypt.gensalt()));
            admin.setRole("ADMIN");
            userService.saveUser(admin);
            System.out.println("Admin user seeded: john@gmail.com / 1234");
        } else {
            System.out.println("Admin user already exists.");
        }
        
        System.exit(0);
    }
}
