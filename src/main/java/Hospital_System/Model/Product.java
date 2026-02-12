package Hospital_System.Model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stock;
    private String imageUrl;
    private String category;

    public Product() {
    }
    public Product(int id, String name,String description ,
                   double price,int stock,String imageUrl,
                   String category){
        this.id= id;
        this.name= name ;
        this.description= description;
        this.stock= stock;
        this.price= price;
        this.imageUrl=imageUrl;
        this.category= category;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public int getStock() {
        return stock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
