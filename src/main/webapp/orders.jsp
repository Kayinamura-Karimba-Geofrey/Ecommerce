<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3>My Orders</h3>

    <c:forEach var="order" items="${orders}">

        <div class="card mb-3 shadow">
            <div class="card-header">
                Order #${order.id}
                | Date: ${order.orderDate}
                | Total: $${order.totalAmount}
            </div>

            <div class="card-body">
                <ul>
                    <c:forEach var="item" items="${order.items}">
                        <li>
                                ${item.product.name}
                            - Qty: ${item.quantity}
                            - $${item.price}
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

    </c:forEach>

</div>

</body>
</html>