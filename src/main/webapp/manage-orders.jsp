<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Orders | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
                    --card-bg: rgba(30, 41, 59, 0.7);
                    --text-main: #f8fafc;
                    --text-muted: #94a3b8;
                    --accent: #10b981;
                    --glass-border: rgba(255, 255, 255, 0.1);
                    --danger: #ef4444;
                    --warning: #f59e0b;
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
                    margin-bottom: 40px;
                }

                .admin-header h1 {
                    font-size: 2.5rem;
                    background: linear-gradient(to right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .btn-add {
                    background: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    padding: 12px 24px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.3s;
                    border: 1px solid var(--glass-border);
                }

                .btn-add:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                .table-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    overflow: hidden;
                }

                .admin-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .admin-table th {
                    text-align: left;
                    padding: 20px;
                    background: rgba(255, 255, 255, 0.03);
                    color: var(--text-muted);
                    text-transform: uppercase;
                    font-size: 0.8rem;
                    letter-spacing: 0.05em;
                }

                .admin-table td {
                    padding: 20px;
                    border-bottom: 1px solid var(--glass-border);
                    vertical-align: middle;
                }

                .select-status {
                    background-color: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    border: 1px solid var(--glass-border);
                    padding: 8px 12px;
                    border-radius: 8px;
                    font-family: 'Outfit', sans-serif;
                    font-size: 0.85rem;
                    font-weight: 600;
                    outline: none;
                    cursor: pointer;
                }

                .select-status option {
                    background: var(--bg-dark);
                    color: var(--text-main);
                }

                .action-btns {
                    display: flex;
                    gap: 10px;
                }

                .btn-action {
                    padding: 6px 12px;
                    border-radius: 8px;
                    font-size: 0.8rem;
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.2s;
                }

                .btn-view {
                    background: rgba(99, 102, 241, 0.1);
                    color: var(--primary);
                    border: 1px solid rgba(99, 102, 241, 0.2);
                }

                .btn-view:hover {
                    background: rgba(99, 102, 241, 0.2);
                }

                .status-badge {
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    display: inline-block;
                    margin-bottom: 5px;
                }

                .status-Pending {
                    background: rgba(245, 158, 11, 0.2);
                    color: var(--warning);
                }

                .status-Processing {
                    background: rgba(99, 102, 241, 0.2);
                    color: var(--primary);
                }

                .status-Shipped {
                    background: rgba(16, 185, 129, 0.2);
                    color: var(--accent);
                }

                .status-Cancelled {
                    background: rgba(239, 68, 68, 0.2);
                    color: var(--danger);
                }

                .status-Delivered {
                    background: rgba(16, 185, 129, 0.2);
                    color: var(--accent);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="admin-container">
                    <header class="admin-header">
                        <div>
                            <h1>All Orders</h1>
                            <p style="color: var(--text-muted); margin-top: 5px;">View and manage customer orders</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin" class="btn-add">&larr; Back to Dashboard</a>
                    </header>

                    <div class="table-card">
                        <div style="overflow-x: auto;">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th style="text-align: right;">Total Amount</th>
                                        <th>Status & Update</th>
                                        <th style="text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td style="font-weight: 600; color: #94a3b8; font-size: 1.1rem;">
                                                #${order.id}</td>
                                            <td>
                                                <div style="font-weight: 600;">${order.user.fullname}</div>
                                                <div style="font-size: 0.8rem; color: var(--text-muted);">
                                                    ${order.user.email}</div>
                                            </td>
                                            <td>
                                                <div style="color: var(--text-main); font-weight: 500;">
                                                    ${order.orderDate.toLocalDate()}</div>
                                                <div style="font-size: 0.8rem; color: var(--text-muted);">
                                                    ${order.orderDate.toLocalTime()}</div>
                                            </td>
                                            <td
                                                style="font-weight: 700; text-align: right; color: var(--accent); font-size: 1.1rem;">
                                                $${order.totalAmount}
                                            </td>
                                            <td>
                                                <div>
                                                    <!-- Visual Badge -->
                                                    <span class="status-badge status-${order.status}"
                                                        style="display: block; width: fit-content; margin-bottom: 8px;">
                                                        ${order.status}
                                                    </span>
                                                    <!-- Form to update -->
                                                    <form
                                                        action="${pageContext.request.contextPath}/admin/manage-orders"
                                                        method="post" style="display: flex; gap: 5px;">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <select name="status" class="select-status"
                                                            onchange="this.form.submit()">
                                                            <option value="Pending" ${order.status=='Pending'
                                                                ? 'selected' : '' }>Pending</option>
                                                            <option value="Processing" ${order.status=='Processing'
                                                                ? 'selected' : '' }>Processing</option>
                                                            <option value="Shipped" ${order.status=='Shipped'
                                                                ? 'selected' : '' }>Shipped</option>
                                                            <option value="Delivered" ${order.status=='Delivered'
                                                                ? 'selected' : '' }>Delivered</option>
                                                            <option value="Cancelled" ${order.status=='Cancelled'
                                                                ? 'selected' : '' }>Cancelled</option>
                                                        </select>
                                                    </form>
                                                </div>
                                            </td>
                                            <td style="text-align: center;">
                                                <a href="${pageContext.request.contextPath}/admin/order-details?id=${order.id}"
                                                    class="btn-action btn-view">View Details</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="6"
                                                style="text-align: center; color: var(--text-muted); padding: 40px;">
                                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="1.5"
                                                    style="margin-bottom: 15px; opacity: 0.5; display: block; margin-left: auto; margin-right: auto;">
                                                    <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                                    <line x1="8" y1="21" x2="16" y2="21"></line>
                                                    <line x1="12" y1="17" x2="12" y2="21"></line>
                                                </svg>
                                                No orders found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
        </body>

        </html>