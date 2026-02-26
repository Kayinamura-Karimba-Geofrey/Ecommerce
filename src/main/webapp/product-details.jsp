<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html>

    <head>
        <title>Product Details</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 40px;
            }

            .product-container {
                max-width: 900px;
                margin: auto;
                background: #ffffff;
                display: flex;
                gap: 30px;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .product-image {
                flex: 1;
            }

            .product-image img {
                width: 100%;
                border-radius: 8px;
            }

            .product-details {
                flex: 1;
            }

            h2 {
                margin-top: 0;
            }

            .price {
                color: green;
                font-size: 22px;
                font-weight: bold;
                margin: 15px 0;
            }

            .stock {
                margin-bottom: 15px;
                font-weight: bold;
            }

            .category {
                color: gray;
                margin-bottom: 10px;
            }

            .btn {
                padding: 10px 15px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
                display: inline-block;
                margin-top: 10px;
            }

            .btn-cart {
                background-color: #007bff;
                color: white;
            }

            .btn-back {
                background-color: #6c757d;
                color: white;
            }
        </style>
    </head>

    <body>

        <div class="product-container">

            <div class="product-image">
                <img src="${pageContext.request.contextPath}/${product.imagePath}" alt="Product Image">
            </div>

            <div class="product-details">

                <h2>${product.name}</h2>

                <div class="category">
                    Category: ${product.category.name}
                </div>

                <div class="price">
                    $${product.price}
                </div>

                <div class="stock">
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            In Stock (${product.stock} available)
                        </c:when>
                        <c:otherwise>
                            Out of Stock
                        </c:otherwise>
                    </c:choose>
                </div>

                <p>
                    ${product.description}
                </p>

                <!-- Add To Cart (next feature) -->
                <a href="../cart?action=add&id=${product.id}" class="btn btn-cart">
                    Add to Cart
                </a>

                <br>

                <a href="../products" class="btn btn-back">
                    Back to Products
                </a>

            </div>

        </div>

    </body>

    </html>