<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Your Cart | Premium Store</title>

            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">

            <style>
                :root {
                    --primary: #6366f1;
                    --primary-hover: #4f46e5;
                    --bg-dark: #0f172a;
                    --card-bg: rgba(30, 41, 59, 0.7);
                    --text-main: #f8fafc;
                    --text-muted: #94a3b8;
                    --accent: #10b981;
                    --glass-border: rgba(255, 255, 255, 0.1);
                    --danger: #ef4444;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: 'Outfit', sans-serif;
                }

                body {
                    background-color: var(--bg-dark);
                    background-image:
                        radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 50%),
                        radial-gradient(at 50% 0%, rgba(16, 185, 129, 0.1) 0, transparent 50%);
                    color: var(--text-main);
                    min-height: 100vh;
                    padding: 60px 20px;
                }

                .container {
                    max-width: 1000px;
                    margin: 0 auto;
                }

                .header {
                    margin-bottom: 40px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .header h1 {
                    font-size: 2.5rem;
                    font-weight: 700;
                    background: linear-gradient(to right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .back-link {
                    color: var(--text-muted);
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    transition: color 0.3s;
                }

                .back-link:hover {
                    color: var(--primary);
                }

                .cart-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 30px;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                }

                .cart-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .cart-table th {
                    text-align: left;
                    padding-bottom: 20px;
                    color: var(--text-muted);
                    font-weight: 600;
                    text-transform: uppercase;
                    font-size: 0.8rem;
                    letter-spacing: 0.05em;
                    border-bottom: 1px solid var(--glass-border);
                }

                .cart-item td {
                    padding: 24px 0;
                    border-bottom: 1px solid var(--glass-border);
                }

                .product-info {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .product-img {
                    width: 80px;
                    height: 80px;
                    border-radius: 12px;
                    object-fit: cover;
                    border: 1px solid var(--glass-border);
                }

                .product-name {
                    font-weight: 600;
                    font-size: 1.1rem;
                }

                .product-cat {
                    font-size: 0.8rem;
                    color: var(--text-muted);
                }

                .price {
                    font-weight: 600;
                    color: var(--text-main);
                }

                .qty-controls {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    background: rgba(15, 23, 42, 0.4);
                    border-radius: 12px;
                    padding: 5px;
                    width: fit-content;
                    border: 1px solid var(--glass-border);
                }

                .qty-btn {
                    width: 32px;
                    height: 32px;
                    border-radius: 8px;
                    border: none;
                    background: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    text-decoration: none;
                    font-weight: bold;
                    transition: all 0.2s;
                }

                .qty-btn:hover {
                    background: var(--primary);
                    transform: scale(1.1);
                }

                .qty-val {
                    font-weight: 600;
                    min-width: 20px;
                    text-align: center;
                }

                .total-col {
                    color: var(--accent);
                    font-weight: 700;
                    font-size: 1.1rem;
                }

                .remove-btn {
                    color: var(--danger);
                    text-decoration: none;
                    font-size: 0.8rem;
                    font-weight: 600;
                    opacity: 0.7;
                    transition: opacity 0.3s;
                }

                .remove-btn:hover {
                    opacity: 1;
                    text-decoration: underline;
                }

                .cart-footer {
                    margin-top: 30px;
                    display: flex;
                    justify-content: flex-end;
                    align-items: center;
                    gap: 40px;
                }

                .grand-total {
                    text-align: right;
                }

                .grand-total p {
                    font-size: 0.9rem;
                    color: var(--text-muted);
                    margin-bottom: 5px;
                }

                .grand-total h2 {
                    font-size: 2rem;
                    color: var(--accent);
                    font-weight: 700;
                }

                .btn-checkout {
                    background: var(--primary);
                    color: white;
                    padding: 16px 40px;
                    border-radius: 16px;
                    text-decoration: none;
                    font-weight: 700;
                    transition: all 0.3s;
                    box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
                }

                .btn-checkout:hover {
                    background: var(--primary-hover);
                    transform: translateY(-3px);
                    box-shadow: 0 20px 25px -5px rgba(99, 102, 241, 0.5);
                }

                .empty-cart {
                    text-align: center;
                    padding: 60px 0;
                }

                .empty-cart p {
                    font-size: 1.2rem;
                    color: var(--text-muted);
                    margin-bottom: 30px;
                }

                .btn-shop {
                    background: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    padding: 12px 24px;
                    border-radius: 12px;
                    text-decoration: none;
                    border: 1px solid var(--glass-border);
                    transition: 0.3s;
                }

                .btn-shop:hover {
                    background: rgba(255, 255, 255, 0.1);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <header class="header">
                        <div>
                            <h1>Your Cart</h1>
                        </div>
                    </header>

                    <div class="cart-card">
                        <c:choose>
                            <c:when test="${not empty cartItems}">
                                <table class="cart-table">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cartItems}">
                                            <tr class="cart-item">
                                                <td>
                                                    <div class="product-info">
                                                        <img src="${item.product.imagePath}" alt="${item.product.name}"
                                                            class="product-img">
                                                        <div>
                                                            <div class="product-name">${item.product.name}</div>
                                                            <div class="product-cat">${item.product.category.name}</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="price">$${item.product.price}</span>
                                                </td>
                                                <td>
                                                    <div class="qty-controls">
                                                        <a href="cart?action=update&id=${item.id}&quantity=${item.quantity - 1}"
                                                            class="qty-btn">-</a>
                                                        <span class="qty-val">${item.quantity}</span>
                                                        <a href="cart?action=update&id=${item.id}&quantity=${item.quantity + 1}"
                                                            class="qty-btn">+</a>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="total-col">$${item.total}</span>
                                                </td>
                                                <td>
                                                    <a href="cart?action=remove&id=${item.id}" class="remove-btn"
                                                        onclick="return confirm('Remove item?')">Remove</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="cart-footer">
                                    <div class="grand-total">
                                        <p>Grand Total</p>
                                        <h2>$${cartTotal}</h2>
                                    </div>
                                    <form action="checkout" method="post">
                                        <button type="submit" class="btn-checkout"
                                            style="border: none; cursor: pointer;">
                                            Checkout Now
                                        </button>
                                    </form>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-cart">
                                    <p>Your cart feels a bit light...</p>
                                    <a href="products" class="btn-shop">Explore Collection</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

        </body>

        </html>