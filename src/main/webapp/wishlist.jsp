<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Wishlist | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
                    --bg-card: rgba(30, 41, 59, 0.7);
                    --text-main: #f1f5f9;
                    --text-muted: #94a3b8;
                    --border: rgba(255, 255, 255, 0.08);
                }

                body {
                    background: var(--bg-dark);
                    color: var(--text-main);
                    font-family: 'Outfit', sans-serif;
                    margin: 0;
                    padding-top: 100px;
                }

                .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 0 40px;
                }

                .page-header {
                    margin-bottom: 40px;
                }

                .page-header h1 {
                    font-size: 2.5rem;
                    font-weight: 800;
                    margin: 0;
                }

                .wishlist-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 30px;
                }

                .wishlist-card {
                    background: var(--bg-card);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--border);
                    border-radius: 20px;
                    overflow: hidden;
                    transition: transform 0.3s;
                }

                .wishlist-card:hover {
                    transform: translateY(-5px);
                }

                .wishlist-image {
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                }

                .wishlist-content {
                    padding: 24px;
                }

                .wishlist-content h3 {
                    margin: 0 0 8px;
                    font-size: 1.2rem;
                }

                .wishlist-content p {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                    margin-bottom: 20px;
                    height: 40px;
                    overflow: hidden;
                }

                .wishlist-price {
                    font-size: 1.4rem;
                    font-weight: 700;
                    color: var(--primary);
                    margin-bottom: 20px;
                }

                .wishlist-actions {
                    display: flex;
                    gap: 12px;
                }

                .btn {
                    flex: 1;
                    padding: 10px;
                    border-radius: 10px;
                    text-align: center;
                    text-decoration: none;
                    font-weight: 600;
                    font-size: 0.9rem;
                    transition: all 0.3s;
                }

                .btn-view {
                    background: var(--primary);
                    color: white;
                }

                .btn-remove {
                    background: rgba(239, 68, 68, 0.1);
                    color: #ef4444;
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .btn-remove:hover {
                    background: rgba(239, 68, 68, 0.2);
                }

                .empty-state {
                    text-align: center;
                    padding: 100px 0;
                    color: var(--text-muted);
                }
            </style>
        </head>

        <body>

            <jsp:include page="navbar.jsp" />

            <div class="container">
                <div class="page-header">
                    <h1>My Wishlist</h1>
                    <p>Your favorite items, saved in one place.</p>
                </div>

                <c:choose>
                    <c:when test="${not empty wishlistItems}">
                        <div class="wishlist-grid">
                            <c:forEach var="item" items="${wishlistItems}">
                                <div class="wishlist-card">
                                    <img src="${item.product.imagePath}" alt="${item.product.name}"
                                        class="wishlist-image">
                                    <div class="wishlist-content">
                                        <h3>${item.product.name}</h3>
                                        <p>${item.product.description}</p>
                                        <div class="wishlist-price">$${item.product.price}</div>
                                        <div class="wishlist-actions">
                                            <a href="product-details?id=${item.product.id}" class="btn btn-view">View
                                                Details</a>
                                            <a href="wishlist?action=remove&id=${item.product.id}"
                                                class="btn btn-remove">Remove</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div style="font-size: 3rem; margin-bottom: 20px;">❤️</div>
                            <h2>Your wishlist is empty</h2>
                            <p>Browse our store and add items you love!</p>
                            <a href="products" class="btn btn-view"
                                style="display: inline-block; padding: 12px 30px; margin-top: 20px;">Explore
                                Products</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </body>

        </html>