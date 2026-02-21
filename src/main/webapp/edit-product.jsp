<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4>Edit Product</h4>
        </div>

        <div class="card-body">
            <form action="products" method="post">

                <input type="hidden" name="id" value="${product.id}"/>

                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text" name="name"
                           value="${product.name}"
                           class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description"
                              class="form-control"
                              required>${product.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number" step="0.01"
                           name="price"
                           value="${product.price}"
                           class="form-control"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Quantity</label>
                    <input type="number"
                           name="quantity"
                           value="${product.quantity}"
                           class="form-control"
                           required/>
                </div>

                <button type="submit" class="btn btn-warning">
                    Update Product
                </button>

                <a href="products" class="btn btn-secondary">
                    Cancel
                </a>

            </form>
        </div>
    </div>
</div>

</body>
</html>