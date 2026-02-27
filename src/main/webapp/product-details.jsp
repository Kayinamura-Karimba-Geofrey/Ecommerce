<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${product.name} | Premium Store</title>
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
                        radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.1) 0, transparent 50%);
                    color: var(--text-main);
                    min-height: 100vh;
                    padding-top: 100px;
                    padding-bottom: 50px;
                }

                .container {
                    max-width: 1100px;
                    margin: 0 auto;
                    padding: 0 20px;
                }

                .product-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 50px;
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 30px;
                    padding: 40px;
                    margin-bottom: 60px;
                }

                .image-gallery {
                    position: relative;
                    border-radius: 20px;
                    overflow: hidden;
                    border: 1px solid var(--glass-border);
                    height: 500px;
                }

                .image-gallery img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.6s ease;
                }

                .image-gallery:hover img {
                    transform: scale(1.05);
                }

                .product-info {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .cat-tag {
                    display: inline-block;
                    color: var(--primary);
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 1.5px;
                    font-size: 0.8rem;
                    margin-bottom: 10px;
                }

                .product-title {
                    font-size: 2.5rem;
                    font-weight: 700;
                    margin-bottom: 15px;
                    line-height: 1.2;
                }

                .price-tag {
                    font-size: 2rem;
                    font-weight: 700;
                    color: var(--accent);
                    margin-bottom: 25px;
                }

                .description {
                    color: var(--text-muted);
                    line-height: 1.8;
                    margin-bottom: 30px;
                    font-size: 1.05rem;
                }

                .stock-status {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    margin-bottom: 30px;
                    font-weight: 600;
                }

                .dot {
                    width: 10px;
                    height: 10px;
                    border-radius: 50%;
                }

                .dot-in {
                    background: var(--accent);
                    box-shadow: 0 0 10px var(--accent);
                }

                .dot-out {
                    background: #ef4444;
                    box-shadow: 0 0 10px #ef4444;
                }

                .actions {
                    display: flex;
                    gap: 20px;
                }

                .btn {
                    padding: 15px 30px;
                    border-radius: 12px;
                    font-weight: 700;
                    text-decoration: none;
                    transition: all 0.3s;
                    text-align: center;
                    flex: 1;
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                    border: none;
                }

                .btn-primary:hover {
                    background: var(--primary-hover);
                    transform: translateY(-3px);
                    box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
                }

                .btn-secondary {
                    background: rgba(255, 255, 255, 0.05);
                    color: white;
                    border: 1px solid var(--glass-border);
                }

                .btn-secondary:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                /* Related Products Section */
                .related-section {
                    margin-top: 40px;
                }

                .section-title {
                    font-size: 1.8rem;
                    font-weight: 700;
                    margin-bottom: 30px;
                    text-align: center;
                }

                .related-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                    gap: 25px;
                }

                .related-card {
                    background: var(--card-bg);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    overflow: hidden;
                    transition: 0.3s;
                    text-decoration: none;
                    color: inherit;
                }

                .related-card:hover {
                    transform: translateY(-10px);
                    border-color: var(--primary);
                }

                .related-img {
                    height: 180px;
                    overflow: hidden;
                }

                .related-img img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .related-info {
                    padding: 15px;
                }

                .related-name {
                    font-weight: 600;
                    margin-bottom: 5px;
                }

                .related-price {
                    color: var(--accent);
                    font-weight: 700;
                }

                @media (max-width: 850px) {
                    .product-grid {
                        grid-template-columns: 1fr;
                    }

                    .image-gallery {
                        height: 350px;
                    }
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <div class="product-grid">
                        <div class="image-gallery">
                            <c:choose>
                                <c:when test="${not empty product.imagePath and product.imagePath.startsWith('http')}">
                                    <img src="${product.imagePath}" alt="${product.name}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${product.category.name == 'Electronics'}">
                                            <img src="https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Home Appliances'}">
                                            <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Fashion'}">
                                            <img src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Books'}">
                                            <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Hobbies'}">
                                            <img src="https://images.unsplash.com/photo-1611996575749-79a3a250f948?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Beauty'}">
                                            <img src="https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Home Decor'}">
                                            <img src="https://images.unsplash.com/photo-1616046229478-9901c5536a45?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:when test="${product.category.name == 'Furniture'}">
                                            <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop&q=80" alt="${product.name}">
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="product-info">
                            <span class="cat-tag">${product.category.name}</span>
                            <h1 class="product-title">${product.name}</h1>
                            <div class="price-tag">$${product.price}</div>

                            <p class="description">${product.description}</p>

                            <div class="stock-status">
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <div class="dot dot-in"></div>
                                        <span style="color: var(--accent)">In Stock (${product.stock} available)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="dot dot-out"></div>
                                        <span style="color: #ef4444">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="actions">
                                <c:if test="${product.stock > 0}">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="flex:1; margin:0;">
                                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <button type="submit" class="btn btn-primary" style="width:100%;">Add to Cart</button>
                                    </form>
                                </c:if>
                                <a href="products" class="btn btn-secondary">Back to Store</a>
                            </div>
                        </div>
                    </div>

                    <!-- Related Products -->
                    <c:if test="${not empty relatedProducts}">
                        <div class="related-section">
                            <h2 class="section-title">You Might Also Like</h2>
                            <div class="related-grid">
                                <c:forEach var="rp" items="${relatedProducts}">
                                    <a href="product-details?id=${rp.id}" class="related-card">
                                        <div class="related-img">
                                            <c:choose>
                                                <c:when test="${not empty rp.imagePath and rp.imagePath.startsWith('http')}">
                                                    <img src="${rp.imagePath}" alt="${rp.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${rp.category.name == 'Electronics'}">
                                                            <img src="https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Home Appliances'}">
                                                            <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Fashion'}">
                                                            <img src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Books'}">
                                                            <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Hobbies'}">
                                                            <img src="https://images.unsplash.com/photo-1611996575749-79a3a250f948?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Beauty'}">
                                                            <img src="https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Home Decor'}">
                                                            <img src="https://images.unsplash.com/photo-1616046229478-9901c5536a45?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:when test="${rp.category.name == 'Furniture'}">
                                                            <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop&q=80" alt="${rp.name}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="related-info">
                                            <div class="related-name">${rp.name}</div>
                                            <div class="related-price">$${rp.price}</div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
        </body>

        </html>