<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order #${order.id} | Premium Store</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #6366f1;
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
                background-image: radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 50%);
                color: var(--text-main);
                min-height: 100vh;
            }

            .admin-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            .admin-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .header-left h1 {
                font-size: 2.5rem;
                color: var(--text-main);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .btn-action {
                background: rgba(255, 255, 255, 0.05);
                color: var(--text-main);
                padding: 10px 20px;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 600;
                transition: 0.3s;
                border: 1px solid var(--glass-border);
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-action:hover {
                background: rgba(255, 255, 255, 0.1);
            }

            .btn-primary {
                background: var(--primary);
                border-color: var(--primary);
            }

            .btn-primary:hover {
                background: #4f46e5;
                box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
            }

            .content-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 24px;
            }

            @media (max-width: 900px) {
                .content-grid {
                    grid-template-columns: 1fr;
                }
            }

            .card {
                background: var(--card-bg);
                backdrop-filter: blur(12px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 24px;
                margin-bottom: 24px;
            }

            .card-header {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 20px;
                color: var(--text-main);
                padding-bottom: 15px;
                border-bottom: 1px solid var(--glass-border);
            }

            .item-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .item-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 15px;
                border-bottom: 1px dashed rgba(255, 255, 255, 0.05);
            }

            .item-row:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }

            .item-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .item-thumb {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                object-fit: cover;
                border: 1px solid var(--glass-border);
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                color: var(--text-muted);
            }

            .summary-total {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid var(--glass-border);
                font-size: 1.25rem;
                font-weight: 700;
                color: var(--accent);
            }

            .customer-info-block {
                margin-bottom: 20px;
            }

            .customer-info-block h3 {
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                color: var(--text-muted);
                margin-bottom: 8px;
            }

            .customer-info-block p {
                color: var(--text-main);
                line-height: 1.5;
            }

            /* ----- PRINT STYLES ----- */
            @media print {
                body {
                    background: white;
                    color: black;
                }

                /* Hide elements not needed in print */
                .navbar,
                .btn-action,
                .admin-header .btn-action {
                    display: none !important;
                }

                .admin-container {
                    padding: 0;
                    max-width: 100%;
                }

                .card {
                    background: white;
                    backdrop-filter: none;
                    border: 1px solid #ddd;
                    box-shadow: none;
                    color: black;
                    page-break-inside: avoid;
                }

                .card-header {
                    color: black;
                    border-bottom: 2px solid #000;
                }

                .text-muted,
                .summary-row {
                    color: #555 !important;
                }

                .item-row {
                    border-bottom: 1px solid #ddd;
                }

                .summary-total {
                    color: #000 !important;
                    border-top: 2px solid #000;
                }

                .customer-info-block h3 {
                    color: #000;
                    font-weight: bold;
                }

                .customer-info-block p {
                    color: #333;
                }
            }
        </style>
    </head>

    <body>
        <!-- Hide navbar in print using class (or inline style for safety depending on navbar structure) -->
        <div class="navbar-wrapper">
            <%@ include file="navbar.jsp" %>
        </div>
        <style>
            @media print {
                .navbar-wrapper {
                    display: none;
                }
            }
        </style>

        <div class="admin-container">
            <header class="admin-header">
                <div class="header-left">
                    <a href="${pageContext.request.contextPath}/admin/manage-orders" class="btn-action"
                        style="padding: 8px; border-radius: 50%; width: 40px; height: 40px; justify-content: center;">&larr;</a>
                    <h1>Order #${order.id}</h1>
                </div>
                <div style="display: flex; gap: 10px;">
                    <button class="btn-action btn-primary" onclick="window.print()">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2">
                            <polyline points="6 9 6 2 18 2 18 9"></polyline>
                            <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                            <rect x="6" y="14" width="12" height="8"></rect>
                        </svg>
                        Print Invoice
                    </button>
                </div>
            </header>

            <div class="content-grid">
                <!-- Left Column: Items & Summary -->
                <div>
                    <div class="card">
                        <div class="card-header">Order Items</div>
                        <div class="item-list">
                            <c:forEach var="item" items="${order.items}">
                                <div class="item-row">
                                    <div class="item-info">
                                        <c:choose>
                                            <c:when
                                                test="${not empty item.product.imagePath and item.product.imagePath.startsWith('http')}">
                                                <img src="${item.product.imagePath}" class="item-thumb">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="item-thumb"
                                                    style="background: rgba(255,255,255,0.05); display: flex; align-items: center; justify-content: center; font-weight: bold; color: var(--text-muted);">
                                                    ${item.product.name.substring(0,1)}</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div style="font-weight: 600; font-size: 1.1rem; margin-bottom: 4px;">
                                                ${item.product.name}</div>
                                            <div style="color: var(--text-muted); font-size: 0.9rem;">$${item.price}
                                                &times; ${item.quantity}</div>
                                        </div>
                                    </div>
                                    <div style="font-weight: 600; font-size: 1.1rem;">
                                        $${item.price * item.quantity}
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">Financial Summary</div>
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>$${order.subtotal}</span>
                        </div>
                        <div class="summary-row">
                            <span>Tax</span>
                            <span>$${order.tax}</span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span>$${order.shippingCost}</span>
                        </div>
                        <div class="summary-total">
                            <span>Paid by Customer</span>
                            <span>$${order.totalAmount}</span>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Customer & Order Details -->
                <div>
                    <div class="card">
                        <div class="card-header">Customer Details</div>

                        <div class="customer-info-block">
                            <h3>Customer</h3>
                            <p style="font-weight: 600;">${order.user.fullname}</p>
                            <p style="color: var(--primary);">${order.user.email}</p>
                        </div>

                        <div class="customer-info-block">
                            <h3>Shipping Address</h3>
                            <p>${order.shippingAddress}</p>
                        </div>

                        <div class="customer-info-block">
                            <h3>Billing Address</h3>
                            <p>${order.billingAddress}</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">Order Info</div>

                        <div class="customer-info-block">
                            <h3>Date</h3>
                            <p>${order.orderDate}</p>
                        </div>

                        <div class="customer-info-block">
                            <h3>Current Status</h3>
                            <span
                                style="display: inline-block; padding: 4px 12px; background: rgba(99, 102, 241, 0.1); color: var(--primary); border-radius: 8px; font-weight: 600; margin-top: 5px;">
                                ${order.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>