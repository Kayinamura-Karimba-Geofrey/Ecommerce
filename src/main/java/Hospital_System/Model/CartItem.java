package Hospital_System.Model;

public class CartItem {
    private int id ;
    private int UserId;
    private int productId;
    private int quantity;
    public CartItem() {
    }
    public CartItem(int id,int UserId, int productId, int quantity){
        this.id= id;
        this.UserId= UserId;
        this.productId= productId;
        this.quantity= quantity;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return UserId;
    }

    public int getProductId() {
        return productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        UserId = userId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
