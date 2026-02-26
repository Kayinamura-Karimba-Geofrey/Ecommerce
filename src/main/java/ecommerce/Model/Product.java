package ecommerce.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    @Column(length = 1000)
    private String description;

    private double price;

    private int stock;

    private String imagePath;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    public Product() {}

    public Product(String name, String description, double price, int stock, String imagePath, Category category) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imagePath = imagePath;
        this.category = category;
    }

    public Product(int id, String name, String description, double price, int stock, String imagePath, Category category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imagePath = imagePath;
        this.category = category;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}