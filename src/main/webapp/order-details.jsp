<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Order Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">

        <div class="container mt-5">

            <h3>Order #${order.id}</h3>

            <p><strong>Customer:</strong> ${order.user.fullname}</p>
            <p><strong>Date:</strong> ${order.orderDate}</p>
            <p><strong>Status:</strong> ${order.status}</p>

            <hr>

            <h5>Items</h5>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Price</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>${item.quantity}</td>
                            <td>$${item.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h5 class="text-end">Total: $${order.totalAmount}</h5>

        </div>

    </body>

    </html>