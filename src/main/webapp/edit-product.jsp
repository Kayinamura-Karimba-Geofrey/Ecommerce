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
    <h2>Edit Product</h2>

    <form action="products" method="post" class="shadow p-4 bg-white">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

        <input type="hidden" name="id" value="${product.id}" />

        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name"
                   value="${product.name}"
                   class="form-control" required />
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description"
                      class="form-control"
                      required>${product.description}</textarea>
        </div>

        <div class="mb-3">
            <label>Price</label>
            <input type="number" step="0.01"
                   name="price"
                   value="${product.price}"
                   class="form-control" required />
        </div>

        <div class="mb-3">
            <label>Stock</label>
            <input type="number"
                   name="stock"
                   value="${product.stock}"
                   class="form-control" required />
        </div>

        <button type="submit"
                class="btn btn-success">
            Update Product
        </button>

        <a href="products"
           class="btn btn-secondary">
            Cancel
        </a>

    </form>
</div>

</body>
</html>