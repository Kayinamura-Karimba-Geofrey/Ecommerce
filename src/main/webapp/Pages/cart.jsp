<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h2>Your Cart</h2>

<table border="1" cellpadding="10">
    <tr>
        <th>Product</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
        <th>Action</th>
    </tr>

    <c:choose>
        <c:when test="${not empty cartItems}">
            <c:forEach var="item" items="${cartItems}">
                <tr>
                    <td>${item.product.name}</td>
                    <td>$${item.product.price}</td>
                    <td>${item.quantity}</td>
                    <td>$${item.total}</td>
                    <td>
                        <a href="cart?action=remove&id=${item.id}">
                            Remove
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="5">Your cart is empty.</td>
            </tr>
        </c:otherwise>
    </c:choose>
</table>

<br>
<a href="products">Continue Shopping</a>