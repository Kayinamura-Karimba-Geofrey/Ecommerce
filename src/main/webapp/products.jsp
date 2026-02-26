<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Premium Store | Discover Excellence</title>

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
                    padding-bottom: 50px;
                }

                .header {
                    padding: 40px 20px 40px;
                    text-align: center;
                }

                .header h1 {
                    font-size: 3rem;
                    font-weight: 700;
                    margin-bottom: 10px;
                    background: linear-gradient(to right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .header p {
                    color: var(--text-muted);
                    font-size: 1.1rem;
                }

                .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 0 20px;
                }

                .products-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 25px;
                }

                .product-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    overflow: hidden;
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    display: flex;
                    flex-direction: column;
                }

                .product-card:hover {
                    transform: translateY(-10px);
                    border-color: var(--primary);
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                }

                .image-container {
                    position: relative;
                    height: 220px;
                    overflow: hidden;
                }

                .image-container img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.6s ease;
                }

                .product-card:hover .image-container img {
                    transform: scale(1.1);
                }

                .category-badge {
                    position: absolute;
                    top: 15px;
                    right: 15px;
                    background: rgba(15, 23, 42, 0.6);
                    backdrop-filter: blur(5px);
                    padding: 5px 12px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    border: 1px solid var(--glass-border);
                    color: var(--text-main);
                }

                .content {
                    padding: 20px;
                    flex-grow: 1;
                    display: flex;
                    flex-direction: column;
                }

                .product-name {
                    font-size: 1.25rem;
                    font-weight: 600;
                    margin-bottom: 10px;
                    color: var(--text-main);
                }

                .product-desc {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                    line-height: 1.5;
                    margin-bottom: 20px;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .footer-action {
                    margin-top: auto;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .price {
                    font-size: 1.4rem;
                    font-weight: 700;
                    color: var(--accent);
                }

                .btn-buy {
                    background: var(--primary);
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 12px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.3s;
                    text-decoration: none;
                    font-size: 0.9rem;
                }

                .btn-buy:hover {
                    background: var(--primary-hover);
                    transform: scale(1.05);
                }

                .admin-controls {
                    padding: 10px 20px 20px;
                    display: flex;
                    gap: 10px;
                }

                .btn-admin {
                    flex: 1;
                    text-align: center;
                    padding: 8px;
                    border-radius: 8px;
                    font-size: 0.75rem;
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.2s;
                }

                .btn-edit {
                    background: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    border: 1px solid var(--glass-border);
                }

                .btn-edit:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                .btn-del {
                    background: rgba(239, 68, 68, 0.1);
                    color: #ef4444;
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .btn-del:hover {
                    background: rgba(239, 68, 68, 0.2);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <header class="header">
                    <div class="container">
                        <h1>Premium Collections</h1>
                        <p>Experience the finest selection of curated products</p>
                    </div>
                </header>

                <main class="container">
                    <div class="products-grid">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <div class="image-container">
                                    <img src="${product.imagePath}" alt="${product.name}">
                                    <span class="category-badge">${product.category.name}</span>
                                </div>

                                <div class="content">
                                    <h2 class="product-name">${product.name}</h2>
                                    <p class="product-desc">${product.description}</p>

                                    <div class="footer-action">
                                        <span class="price">$${product.price}</span>
                                        <a href="cart?action=add&id=${product.id}" class="btn-buy">Add to Cart</a>
                                    </div>
                                </div>

                                <div class="admin-controls">
                                    <a href="products?action=edit&id=${product.id}" class="btn-admin btn-edit">Edit</a>
                                    <a href="products?action=delete&id=${product.id}" class="btn-admin btn-del"
                                        onclick="return confirm('Are you sure?');">Delete</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </main>

        </body>

        </html>