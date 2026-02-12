package Hospital_System.Model;
import java.sql.Timestamp;

public class Order {
    private  int id ;
    private int userId;
    private int totalAmaount;
    private String status;
    private Timestamp createdAt;

    public Order() {
    }
    public Order(int id, int userId,int totalAmaount,String status, Timestamp createdAt){
        this.id= id;
        this.userId= userId;
        this.totalAmaount= totalAmaount;
        this.status= status;
        this.createdAt= createdAt;

    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public int getTotalAmaount() {
        return totalAmaount;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTotalAmaount(int totalAmaount) {
        this.totalAmaount = totalAmaount;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
