<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Orders | Premium Store</title>
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
                    padding: 80px 20px 50px;
                }

                .container {
                    max-width: 1000px;
                    margin: 0 auto;
                }

                .page-title {
                    font-size: 2.5rem;
                    font-weight: 700;
                    margin-bottom: 40px;
                    background: linear-gradient(to right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .order-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    margin-bottom: 25px;
                    overflow: hidden;
                    transition: border-color 0.3s;
                }

                .order-card:hover {
                    border-color: var(--primary);
                }

                .order-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 20px 25px;
                    border-bottom: 1px solid var(--glass-border);
                    flex-wrap: wrap;
                    gap: 15px;
                }

                .order-id {
                    font-size: 1.1rem;
                    font-weight: 700;
                }

                .order-meta {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                    margin-top: 4px;
                }

                .status-badge {
                    padding: 6px 16px;
                    border-radius: 20px;
                    font-weight: 700;
                    font-size: 0.8rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .status-PAID {
                    background: rgba(16, 185, 129, 0.15);
                    color: #10b981;
                    border: 1px solid #10b981;
                }

                .status-PENDING {
                    background: rgba(245, 158, 11, 0.15);
                    color: #f59e0b;
                    border: 1px solid #f59e0b;
                }

                .status-SHIPPED {
                    background: rgba(99, 102, 241, 0.15);
                    color: #6366f1;
                    border: 1px solid #6366f1;
                }

                .status-DELIVERED {
                    background: rgba(20, 184, 166, 0.15);
                    color: #14b8a6;
                    border: 1px solid #14b8a6;
                }

                .status-CANCELLED {
                    background: rgba(239, 68, 68, 0.15);
                    color: #ef4444;
                    border: 1px solid #ef4444;
                }

                .order-items {
                    padding: 20px 25px;
                }

                .order-item-row {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    padding: 12px 0;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                }

                .order-item-row:last-child {
                    border-bottom: none;
                }

                .item-name {
                    flex: 1;
                    font-weight: 500;
                }

                .item-qty {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                }

                .item-price {
                    font-weight: 700;
                    color: var(--accent);
                }

                .order-footer {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 15px 25px;
                    border-top: 1px solid var(--glass-border);
                    background: rgba(0, 0, 0, 0.2);
                    flex-wrap: wrap;
                    gap: 10px;
                }

                .total-label {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                }

                .total-amount {
                    font-size: 1.4rem;
                    font-weight: 700;
                    color: var(--accent);
                }

                /* Admin status update */
                .admin-select {
                    background: var(--card-bg);
                    color: var(--text-main);
                    border: 1px solid var(--glass-border);
                    border-radius: 10px;
                    padding: 8px 14px;
                    font-size: 0.9rem;
                    cursor: pointer;
                }

                .btn-update {
                    background: var(--primary);
                    color: white;
                    border: none;
                    border-radius: 10px;
                    padding: 8px 20px;
                    font-weight: 700;
                    cursor: pointer;
                    transition: 0.3s;
                }

                .btn-update:hover {
                    background: var(--primary-hover);
                }

                .empty-state {
                    text-align: center;
                    padding: 80px 20px;
                    color: var(--text-muted);
                }

                .empty-state h2 {
                    font-size: 1.5rem;
                    margin-bottom: 15px;
                }

                .btn-shop {
                    display: inline-block;
                    background: var(--primary);
                    color: white;
                    padding: 12px 30px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 700;
                    margin-top: 20px;
                    transition: 0.3s;
                }

                .btn-shop:hover {
                    background: var(--primary-hover);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="container">
                    <h1 class="page-title">
                        <c:choose>
                            <c:when test="${sessionScope.loggedUser.role == 'ADMIN'}">All Orders</c:when>
                            <c:otherwise>My Orders</c:otherwise>
                        </c:choose>
                    </h1>

                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div>
                                            <div class="order-id">Order #${order.id}</div>
                                            <div class="order-meta">
                                                ${order.orderDate}
                                                <c:if test="${sessionScope.loggedUser.role == 'ADMIN'}">
                                                    &nbsp;|&nbsp; ${order.user.email}
                                                </c:if>
                                            </div>
                                        </div>
                                        <span class="status-badge status-${order.status}">${order.status}</span>
                                    </div>

                                    <div class="order-items">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="order-item-row">
                                                <div class="item-name">${item.product.name}</div>
                                                <div class="item-qty">x${item.quantity}</div>
                                                <div class="item-price">$${item.price}</div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <div class="order-footer">
                                        <div>
                                            <div class="total-label">Grand Total</div>
                                            <div class="total-amount">$${order.totalAmount}</div>
                                        </div>

                                        <%-- Admin status update form --%>
                                            <c:if test="${sessionScope.loggedUser.role == 'ADMIN'}">
                                                <form action="orders" method="post"
                                                    style="display: flex; gap: 10px; align-items: center;">
                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                    <select name="status" class="admin-select">
                                                        <option value="PENDING" ${order.status=='PENDING' ? 'selected'
                                                            : '' }>Pending</option>
                                                        <option value="PAID" ${order.status=='PAID' ? 'selected' : '' }>
                                                            Paid</option>
                                                        <option value="SHIPPED" ${order.status=='SHIPPED' ? 'selected'
                                                            : '' }>Shipped</option>
                                                        <option value="DELIVERED" ${order.status=='DELIVERED'
                                                            ? 'selected' : '' }>Delivered</option>
                                                        <option value="CANCELLED" ${order.status=='CANCELLED'
                                                            ? 'selected' : '' }>Cancelled</option>
                                                    </select>
                                                    <button type="submit" class="btn-update">Update</button>
                                                </form>
                                            </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h2>No orders yet</h2>
                                <p>Looks like you haven't placed any orders.</p>
                                <a href="products" class="btn-shop">Start Shopping</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
        </body>

        </html>