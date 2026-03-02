<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <c:set var="seoTitle" value="${product.name} | Premium Store" scope="request" />
            <c:set var="seoDescription" value="Get the best deals on ${product.name}. ${product.description}"
                scope="request" />
            <c:set var="seoImage" value="${product.imagePath}" scope="request" />
            <%@ include file="seo-meta.jsp" %>

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
                        grid-template-columns: 1.2fr 1fr;
                        gap: 50px;
                        background: var(--card-bg);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--glass-border);
                        border-radius: 30px;
                        padding: 40px;
                        margin-bottom: 40px;
                    }

                    @media (max-width: 1024px) {
                        .product-grid {
                            grid-template-columns: 1fr;
                            gap: 30px;
                            padding: 25px;
                        }

                        .image-gallery {
                            height: 400px;
                        }

                        .product-title {
                            font-size: 2rem;
                        }
                    }

                    @media (max-width: 480px) {
                        .image-gallery {
                            height: 300px;
                        }

                        .actions {
                            flex-direction: column;
                        }

                        .btn {
                            width: 100%;
                        }
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

                    .product-info {
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                    }

                    .cat-tag {
                        color: var(--primary);
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 1.5px;
                        font-size: 1rem;
                        margin-bottom: 10px;
                    }

                    .product-title {
                        font-size: 2.5rem;
                        font-weight: 700;
                        margin-bottom: 15px;
                    }

                    .price-tag {
                        font-size: 2.5rem;
                        font-weight: 800;
                        color: var(--accent);
                        margin-bottom: 25px;
                    }

                    .rating-avg {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        margin-bottom: 20px;
                        color: #fbbf24;
                        font-weight: 600;
                    }

                    .description {
                        color: var(--text-muted);
                        line-height: 1.8;
                        margin-bottom: 30px;
                        font-size: 1.05rem;
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
                        transition: 0.3s;
                        text-align: center;
                        flex: 1;
                        border: none;
                        cursor: pointer;
                    }

                    .btn-primary {
                        background: var(--primary);
                        color: white;
                    }

                    .btn-secondary {
                        background: rgba(255, 255, 255, 0.05);
                        color: white;
                        border: 1px solid var(--glass-border);
                    }

                    .btn-wishlist {
                        background: rgba(255, 255, 255, 0.05);
                        color: white;
                        border: 1px solid var(--glass-border);
                        flex: 0 0 60px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.4rem;
                    }

                    .btn-wishlist.active {
                        color: #ef4444;
                        border-color: #ef4444;
                        background: rgba(239, 68, 68, 0.1);
                    }

                    /* Reviews Section */
                    .reviews-section {
                        background: var(--card-bg);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--glass-border);
                        border-radius: 30px;
                        padding: 40px;
                        margin-top: 40px;
                    }

                    .review-item {
                        border-bottom: 1px solid var(--glass-border);
                        padding: 25px 0;
                    }

                    .review-header {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 10px;
                    }

                    .review-user {
                        font-weight: 700;
                        font-size: 1.1rem;
                    }

                    .review-rating {
                        color: #fbbf24;
                    }

                    .review-comment {
                        color: var(--text-muted);
                        line-height: 1.6;
                    }

                    .add-review-form {
                        margin-top: 40px;
                        padding-top: 40px;
                        border-top: 1px solid var(--glass-border);
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-group label {
                        display: block;
                        margin-bottom: 10px;
                        color: var(--text-muted);
                        font-weight: 600;
                    }

                    .form-group input,
                    .form-group textarea,
                    .form-group select {
                        width: 100%;
                        padding: 12px 15px;
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid var(--glass-border);
                        border-radius: 10px;
                        color: white;
                        font-family: inherit;
                    }
                </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <div class="product-grid">
                        <div class="image-gallery">
                            <c:set var="pdImg"
                                value="${product.imagePath.startsWith('http') ? product.imagePath : pageContext.request.contextPath.concat('/').concat(product.imagePath)}" />
                            <img src="${pdImg}" alt="${product.name}"
                                onerror="this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800';">
                        </div>

                        <div class="product-info">
                            <span class="cat-tag">${product.category.name}</span>
                            <h1 class="product-title">${product.name}</h1>

                            <div class="rating-avg">
                                <span>⭐ ${avgRating} / 5.0</span>
                                <span style="color: var(--text-muted); font-weight: 400;">(${reviews.size()}
                                    reviews)</span>
                            </div>

                            <div class="price-tag">$${product.price}</div>
                            <p class="description">${product.description}</p>

                            <div class="actions">
                                <form action="cart" method="post" style="flex:1;">
                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn btn-primary" style="width:100%;">Add to
                                        Cart</button>
                                </form>

                                <a href="wishlist?action=${isInWishlist ? 'remove' : 'add'}&id=${product.id}"
                                    class="btn btn-wishlist ${isInWishlist ? 'active' : ''}"
                                    title="${isInWishlist ? 'Remove from Wishlist' : 'Add to Wishlist'}">
                                    ${isInWishlist ? '❤️' : '🤍'}
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Reviews -->
                    <div class="reviews-section">
                        <h2 style="margin-bottom: 30px; font-weight: 800; font-size: 1.8rem;">Customer Reviews</h2>

                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <c:forEach var="review" items="${reviews}">
                                    <div class="review-item">
                                        <div class="review-header">
                                            <span class="review-user">${review.user.fullname}</span>
                                            <span class="review-rating">${review.rating} ⭐</span>
                                        </div>
                                        <p class="review-comment">${review.comment}</p>
                                        <small style="color: var(--text-muted);">${review.createdAt}</small>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="color: var(--text-muted); text-align: center; padding: 40px 0;">No reviews
                                    yet. Be the first to share your experience!</p>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty loggedUser}">
                            <div class="add-review-form">
                                <h3 style="margin-bottom: 20px;">Write a Review</h3>
                                <form action="add-review" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <div class="form-group">
                                        <label>Rating</label>
                                        <select name="rating" required>
                                            <option value="5">5 Stars - Excellent</option>
                                            <option value="4">4 Stars - Very Good</option>
                                            <option value="3">3 Stars - Good</option>
                                            <option value="2">2 Stars - Fair</option>
                                            <option value="1">1 Star - Poor</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Your Comment</label>
                                        <textarea name="comment" rows="4" placeholder="Tell us what you think..."
                                            required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary" style="max-width: 200px;">Post
                                        Review</button>
                                </form>
                            </div>
                        </c:if>
                    </div>

                    <!-- Related Products -->
                    <c:if test="${not empty relatedProducts}">
                        <div style="margin-top: 60px;">
                            <h2 style="text-align: center; margin-bottom: 40px; font-weight: 800;">You Might Also Like
                            </h2>
                            <div
                                style="display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 30px;">
                                <c:forEach var="rp" items="${relatedProducts}">
                                    <a href="product-details?id=${rp.id}"
                                        style="text-decoration: none; color: inherit;">
                                        <div style="background: var(--card-bg); border: 1px solid var(--glass-border); border-radius: 20px; overflow: hidden; transition: 0.3s;"
                                            onmouseover="this.style.transform='translateY(-10px)'"
                                            onmouseout="this.style.transform='translateY(0)'">
                                            <img src="${rp.imagePath}"
                                                style="width: 100%; height: 200px; object-fit: cover;"
                                                onerror="this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800';">
                                            <div style="padding: 20px;">
                                                <div style="font-weight: 700; margin-bottom: 10px;">${rp.name}</div>
                                                <div style="color: var(--accent); font-weight: 800;">$${rp.price}</div>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
        </body>

        </html>

        </html>