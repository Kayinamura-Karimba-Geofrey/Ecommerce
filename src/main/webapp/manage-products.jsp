<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Manage Products</h2>

    <table class="table table-bordered table-hover shadow">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th width="200">Actions</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>$${p.price}</td>
                <td>${p.stock}</td>
                <td>

                    <a href="products?action=edit&id=${p.id}"
                       class="btn btn-sm btn-warning">
                        Edit
                    </a>

                    <a href="products?action=delete&id=${p.id}"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Delete this product?')">
                        Delete
                    </a>

                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

    <a href="add-product.jsp" class="btn btn-primary">
        Add New Product
    </a>
</div>

</body>
</html>