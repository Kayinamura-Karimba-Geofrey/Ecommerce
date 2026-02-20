<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html>
<html>
<head>
    <title>All Products</title>

    <!-- Simple Clean Styling -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .products-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .product-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 5px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }

        .price {
            color: green;
            font-size: 16px;
            font-weight: bold;
        }

        .category {
            font-size: 13px;
            color: gray;
        }

        .btn {
            display: inline-block;
            padding: 6px 10px;
            margin-top: 8px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
        }

        .btn-view {
            background-color: #007bff;
            color: white;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<h2>Our Products</h2>

<div class="products-container">

    <c:forEach var="product" items="${products}">

        <div class="product-card">

            <img src="${product.imageUrl}" alt="Product Image">

            <div class="product-title">
                    ${product.name}
            </div>

            <div class="category">
                Category: ${product.category}
            </div>

            <div class="price">
                $${product.price}
            </div>

            <p>
                    ${product.description}
            </p>

            <!-- View Button -->
            <a href="products?action=view&id=${product.id}" class="btn btn-view">
                View
            </a>

            <!-- Delete Button (Admin Only Later) -->
            <a href="products?action=delete&id=${product.id}"
               class="btn btn-delete"
               onclick="return confirm('Are you sure you want to delete this product?');">
                Delete
            </a>
            <a href="products?action=edit&id=${product.id}"
               class="btn btn-sm btn-warning">
                Edit
            </a>

        </div>

    </c:forEach>

</div>

</body>
</html>
