package ecommerce.Model;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "totalamount")
    private double totalAmount;

    @Column(name = "subtotal")
    private double subtotal;

    @Column(name = "tax")
    private double tax;

    @Column(name = "shippingcost")
    private Double shippingCost;

    @Column(name = "discountamount")
    private Double discountAmount;

    @Column(name = "couponcode")
    private String couponCode;

    @Column(name = "billingaddress", columnDefinition = "TEXT")
    private String billingAddress;

    @Column(name = "shippingaddress", columnDefinition = "TEXT")
    private String shippingAddress;

    @Column(nullable = false)
    private String status;

    @Column(name = "orderdate")
    private java.time.LocalDateTime orderDate;

    // These columns were added via SchemaPatchServlet (with underscore)
    @Column(name = "tracking_number")
    private String trackingNumber;

    @Column(name = "estimated_delivery")
    private java.time.LocalDateTime estimatedDelivery;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private java.util.List<OrderItem> items;

    public Order() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public Double getShippingCost() {
        return shippingCost;
    }

    public void setShippingCost(Double shippingCost) {
        this.shippingCost = shippingCost;
    }

    public Double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(Double discountAmount) { this.discountAmount = discountAmount; }

    public String getCouponCode() { return couponCode; }
    public void setCouponCode(String couponCode) { this.couponCode = couponCode; }

    public String getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(String billingAddress) {
        this.billingAddress = billingAddress;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public java.time.LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(java.time.LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public java.util.List<OrderItem> getItems() {
        return items;
    }

    public void setItems(java.util.List<OrderItem> items) {
        this.items = items;
    }

    public String getTrackingNumber() { return trackingNumber; }
    public void setTrackingNumber(String trackingNumber) { this.trackingNumber = trackingNumber; }

    public java.time.LocalDateTime getEstimatedDelivery() { return estimatedDelivery; }
    public void setEstimatedDelivery(java.time.LocalDateTime estimatedDelivery) { this.estimatedDelivery = estimatedDelivery; }
}

