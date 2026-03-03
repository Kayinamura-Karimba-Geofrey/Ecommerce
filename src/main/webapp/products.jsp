<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <c:set var="seoTitle" value="Premium Products | Shop Quality Gadgets & Fashion" scope="request" />
            <c:set var="seoDescription"
                value="Browse our curated collection of premium gadgets, high-end fashion, and luxury lifestyle products."
                scope="request" />
            <%@ include file="seo-meta.jsp" %>

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

                    .container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 0 40px;
                    }

                    .main-layout {
                        display: grid;
                        grid-template-columns: 280px 1fr;
                        gap: 40px;
                        margin-top: 40px;
                    }

                    /* Sidebar Styles */
                    .sidebar {
                        position: sticky;
                        top: 100px;
                        height: fit-content;
                    }

                    /* Grid Styles */
                    .products-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 20px;
                    }

                    /* Responsiveness */
                    @media (max-width: 768px) {
                        .main-layout {
                            grid-template-columns: 1fr;
                        }

                        .sidebar {
                            position: relative;
                            top: 0;
                            margin-bottom: 40px;
                        }

                        .products-grid {
                            grid-template-columns: repeat(3, 1fr);
                            gap: 10px;
                        }

                        .product-card .image-container {
                            height: 120px;
                        }

                        .product-card .content {
                            padding: 10px;
                        }

                        .product-card .product-name {
                            font-size: 0.95rem;
                            margin-bottom: 4px;
                        }

                        .product-card .product-desc {
                            font-size: 0.75rem;
                            margin-bottom: 10px;
                        }

                        .product-card .price {
                            font-size: 1.0rem;
                        }

                        .product-card .btn-buy {
                            padding: 6px 12px;
                            font-size: 0.75rem;
                        }

                        .featured-section>div {
                            grid-template-columns: repeat(3, 1fr) !important;
                            gap: 10px !important;
                        }

                        .featured-card>a>div:first-child {
                            height: 120px !important;
                        }

                        .featured-card>a>div:last-child {
                            padding: 10px !important;
                        }

                        h1 {
                            font-size: 2.2rem !important;
                        }
                    }

                    @media (max-width: 480px) {
                        .products-grid {
                            grid-template-columns: 1fr;
                        }

                        .newsletter-section {
                            padding: 40px 20px;
                        }

                        .newsletter-form {
                            flex-direction: column;
                        }
                    }

                    .filter-card {
                        background: var(--card-bg);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        padding: 30px;
                    }

                    .filter-group {
                        margin-bottom: 30px;
                    }

                    .filter-group h4 {
                        font-size: 0.9rem;
                        color: var(--text-muted);
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-bottom: 15px;
                        font-weight: 700;
                    }

                    .filter-option {
                        display: block;
                        padding: 8px 12px;
                        color: var(--text-main);
                        text-decoration: none;
                        border-radius: 8px;
                        font-size: 0.95rem;
                        transition: 0.3s;
                        margin-bottom: 4px;
                    }

                    .filter-option:hover,
                    .filter-option.active {
                        background: rgba(99, 102, 241, 0.1);
                        color: var(--primary);
                    }

                    .price-inputs {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 10px;
                    }

                    .price-inputs input {
                        width: 100%;
                        padding: 10px;
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid var(--glass-border);
                        border-radius: 8px;
                        color: white;
                        font-size: 0.85rem;
                    }

                    .btn-filter {
                        width: 100%;
                        margin-top: 15px;
                        padding: 12px;
                        background: var(--primary);
                        color: white;
                        border: none;
                        border-radius: 10px;
                        font-weight: 600;
                        cursor: pointer;
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
                    }

                    .image-container {
                        position: relative;
                        height: 180px;
                        overflow: hidden;
                    }

                    .image-container img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: 0.6s ease;
                    }

                    .product-card:hover .image-container img {
                        transform: scale(1.1);
                    }

                    .category-badge {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background: rgba(15, 23, 42, 0.6);
                        backdrop-filter: blur(5px);
                        padding: 4px 10px;
                        border-radius: 20px;
                        font-size: 0.7rem;
                        font-weight: 600;
                        border: 1px solid var(--glass-border);
                        color: var(--text-main);
                    }

                    .content {
                        padding: 16px;
                        flex-grow: 1;
                        display: flex;
                        flex-direction: column;
                    }

                    .product-name {
                        font-size: 1.1rem;
                        font-weight: 600;
                        margin-bottom: 8px;
                        color: var(--text-main);
                    }

                    .product-desc {
                        color: var(--text-muted);
                        font-size: 0.85rem;
                        line-height: 1.4;
                        margin-bottom: 15px;
                    }

                    .footer-action {
                        margin-top: auto;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                    }

                    .price {
                        font-size: 1.2rem;
                        font-weight: 700;
                        color: var(--accent);
                    }

                    .btn-buy {
                        background: var(--primary);
                        color: white;
                        border: none;
                        padding: 8px 16px;
                        border-radius: 12px;
                        font-weight: 600;
                        cursor: pointer;
                        text-decoration: none;
                        font-size: 0.85rem;
                    }

                    .pagination {
                        display: flex;
                        justify-content: center;
                        gap: 10px;
                        margin-top: 50px;
                    }

                    .page-link {
                        padding: 10px 18px;
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid var(--glass-border);
                        color: var(--text-main);
                        border-radius: 12px;
                        text-decoration: none;
                        font-weight: 600;
                    }

                    .page-link.active {
                        background: var(--primary);
                        color: white;
                    }

                    /* Newsletter Footer */
                    .newsletter-section {
                        margin-top: 100px;
                        background: var(--card-bg);
                        border-radius: 30px;
                        padding: 60px;
                        text-align: center;
                        border: 1px solid var(--glass-border);
                    }

                    .newsletter-form {
                        max-width: 500px;
                        margin: 30px auto 0;
                        display: flex;
                        gap: 15px;
                    }

                    .newsletter-form input {
                        flex: 1;
                        padding: 15px 25px;
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        color: white;
                        outline: none;
                    }
                </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="container" style="padding-top: 60px;">
                    <div style="margin-bottom: 40px;">
                        <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 10px;">Store</h1>
                        <p style="color: var(--text-muted);">Explore our premium collections</p>
                    </div>
                    <div class="container" style="margin-top: 20px;">
                        <c:if test="${not empty featuredProducts}">
                            <section class="featured-section" style="margin-bottom: 60px;">
                                <h2
                                    style="font-size: 2rem; margin-bottom: 30px; font-weight: 800; display: flex; align-items: center; gap: 15px;">
                                    <span
                                        style="background: var(--primary); color: white; padding: 10px; border-radius: 12px; font-size: 1.2rem;">✨</span>
                                    Special Offers & Featured
                                </h2>
                                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">
                                    <c:forEach var="fp" items="${featuredProducts}">
                                        <div class="featured-card"
                                            style="position: relative; background: var(--card-bg); backdrop-filter: blur(12px); border: 1px solid rgba(99, 102, 241, 0.3); border-radius: 20px; overflow: hidden; transition: 0.4s; height: 100%;">
                                            <div
                                                style="position: absolute; top: 10px; left: 10px; background: var(--primary); color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; font-weight: 700; z-index: 10;">
                                                FEATURED</div>
                                            <a href="product-details?id=${fp.id}"
                                                style="text-decoration: none; color: inherit;">
                                                <div style="height: 180px; overflow: hidden;">
                                                    <c:set var="fpImg"
                                                        value="${not empty fp.imagePath and fp.imagePath.startsWith('http') ? fp.imagePath : pageContext.request.contextPath.concat('/').concat(fp.imagePath)}" />
                                                    <img src="${fpImg}" alt="${fp.name}"
                                                        style="width: 100%; height: 100%; object-fit: cover; transition: 0.6s;"
                                                        onmouseover="this.style.transform='scale(1.1)'"
                                                        onmouseout="this.style.transform='scale(1)'"
                                                        onerror="this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800';">
                                                </div>
                                                <div style="padding: 16px;">
                                                    <span
                                                        style="color: var(--primary); font-size: 0.75rem; font-weight: 700; text-transform: uppercase;">${fp.category.name}</span>
                                                    <h3 style="font-size: 1.15rem; margin: 8px 0;">${fp.name}</h3>
                                                    <div
                                                        style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                                                        <span
                                                            style="font-size: 1.3rem; font-weight: 800; color: var(--accent);">$${fp.price}</span>
                                                        <div
                                                            style="background: rgba(255,255,255,0.05); padding: 6px 8px; border-radius: 10px; border: 1px solid var(--glass-border); font-size: 0.9rem;">
                                                            🛒</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>
                    </div>

                    <div class="main-layout">
                        <!-- Sidebar Filters -->
                        <aside class="sidebar">
                            <div class="filter-card">
                                <form action="products" method="get">
                                    <c:if test="${not empty search}"><input type="hidden" name="search"
                                            value="${search}"></c:if>

                                    <div class="filter-group">
                                        <h4>Categories</h4>
                                        <a href="products?search=${search}"
                                            class="filter-option ${empty selectedCategory or selectedCategory == 'All' ? 'active' : ''}">All
                                            Categories</a>
                                        <c:forEach var="cat" items="${categories}">
                                            <a href="products?category=${cat.name}&search=${search}"
                                                class="filter-option ${selectedCategory == cat.name ? 'active' : ''}">${cat.name}</a>
                                        </c:forEach>
                                        <input type="hidden" name="category" value="${selectedCategory}">
                                    </div>

                                    <div class="filter-group">
                                        <h4>Price Range</h4>
                                        <div class="price-inputs">
                                            <input type="number" name="minPrice" placeholder="Min" value="${minPrice}">
                                            <input type="number" name="maxPrice" placeholder="Max" value="${maxPrice}">
                                        </div>
                                        <button type="submit" class="btn-filter">Apply Filters</button>
                                    </div>

                                    <div class="filter-group">
                                        <h4>Sort By</h4>
                                        <select name="sort" onchange="this.form.submit()"
                                            style="width: 100%; padding: 12px; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border); border-radius: 8px; color: white;">
                                            <option value="">Default</option>
                                            <option value="price_low" ${selectedSort=='price_low' ? 'selected' : '' }>
                                                Price: Low to High</option>
                                            <option value="price_high" ${selectedSort=='price_high' ? 'selected' : '' }>
                                                Price: High to Low</option>
                                            <option value="newest" ${selectedSort=='newest' ? 'selected' : '' }>Newest
                                            </option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </aside>

                        <!-- Product Grid -->
                        <section>
                            <c:if test="${not empty search}">
                                <div style="margin-bottom: 20px; color: var(--text-muted);">
                                    Showing results for "<strong>${search}</strong>"
                                </div>
                            </c:if>

                            <div class="products-grid">
                                <c:forEach var="product" items="${products}">
                                    <div class="product-card">
                                        <div class="image-container">
                                            <a href="product-details?id=${product.id}">
                                                <c:set var="pImg"
                                                    value="${not empty product.imagePath and product.imagePath.startsWith('http') ? product.imagePath : pageContext.request.contextPath.concat('/').concat(product.imagePath)}" />
                                                <img src="${pImg}" alt="${product.name}"
                                                    onerror="this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800';">
                                                <span class="category-badge">${product.category.name}</span>
                                            </a>
                                        </div>
                                        <div class="content">
                                            <h2 class="product-name">${product.name}</h2>
                                            <p class="product-desc">${product.description}</p>
                                            <div class="footer-action">
                                                <span class="price">$${product.price}</span>
                                                <form action="cart" method="post">
                                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <button type="submit" class="btn-buy">Add to Cart</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="pagination">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="products?page=${i}&category=${selectedCategory}&sort=${selectedSort}&search=${search}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                                            class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </section>
                    </div>

                    <!-- Newsletter -->
                    <div class="newsletter-section">
                        <h2>Join the Premium Club</h2>
                        <p>Subscribe to our newsletter for exclusive offers and new arrivals.</p>
                        <form action="subscribe" method="post" class="newsletter-form">
                            <input type="email" name="email" placeholder="Enter your email address" required>
                            <button type="submit" class="btn-buy" style="padding: 0 40px;">Subscribe</button>
                        </form>
                    </div>
                </div>
        </body>

        </html>