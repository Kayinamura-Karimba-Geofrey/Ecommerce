<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    margin-bottom: 30px;
                }

                .admin-header h1 {
                    font-size: 2.5rem;
                    background: linear-gradient(to right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .btn-add {
                    background: var(--primary);
                    color: white;
                    padding: 12px 24px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.3s;
                }

                .btn-add:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
                }

                /* Dashboard specific styles */
                .dashboard-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                    gap: 24px;
                    margin-bottom: 24px;
                }

                .stat-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    padding: 24px;
                    display: flex;
                    flex-direction: column;
                    gap: 8px;
                    transition: transform 0.2s;
                }

                .stat-card:hover {
                    transform: translateY(-5px);
                    border-color: rgba(99, 102, 241, 0.3);
                }

                .stat-title {
                    color: var(--text-muted);
                    font-size: 0.95rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                }

                .stat-value {
                    font-size: 2.5rem;
                    font-weight: 700;
                    color: var(--text-main);
                }

                .content-grid {
                    display: grid;
                    grid-template-columns: 2fr 1fr;
                    gap: 24px;
                    margin-bottom: 24px;
                }

                @media (max-width: 900px) {
                    .content-grid {
                        grid-template-columns: 1fr;
                    }
                }

                .section-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    padding: 24px;
                }

                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .section-title {
                    font-size: 1.25rem;
                    font-weight: 600;
                    color: var(--text-main);
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .status-badge {
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
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

                .product-thumb {
                    width: 50px;
                    height: 50px;
                    border-radius: 8px;
                    object-fit: cover;
                    border: 1px solid var(--glass-border);
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

                .btn-edit {
                    background: rgba(255, 255, 255, 0.05);
                    color: var(--text-main);
                    border: 1px solid var(--glass-border);
                }

                .btn-del {
                    background: rgba(239, 68, 68, 0.1);
                    color: var(--danger);
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .btn-edit:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                .btn-del:hover {
                    background: rgba(239, 68, 68, 0.2);
                }

                /* Modal simple style */
                .modal {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.8);
                    backdrop-filter: blur(8px);
                    z-index: 2000;
                    align-items: center;
                    justify-content: center;
                }

                .modal-content {
                    background: var(--bg-dark);
                    border: 1px solid var(--glass-border);
                    padding: 40px;
                    border-radius: 24px;
                    width: 500px;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    color: var(--text-muted);
                    font-size: 0.9rem;
                }

                .form-group input,
                .form-group textarea {
                    width: 100%;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    padding: 12px;
                    border-radius: 10px;
                    color: var(--text-main);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="admin-container">
                    <header class="admin-header">
                        <div>
                            <h1>Overview</h1>
                            <p style="color: var(--text-muted); margin-top: 5px;">Track your store's performance &
                                inventory</p>
                        </div>
                        <a href="#" class="btn-add" onclick="showModal('add')">+ Add Product</a>
                    </header>

                    <!-- Top Metrics Cards -->
                    <div class="dashboard-grid">
                        <div class="stat-card">
                            <span class="stat-title">Total Revenue</span>
                            <span class="stat-value" style="color: #6366f1;">$<span>
                                    <c:out value="${totalRevenue}" default="0.00" />
                                </span></span>
                        </div>
                        <div class="stat-card">
                            <span class="stat-title">Total Orders</span>
                            <span class="stat-value">
                                <c:out value="${totalOrdersCount}" default="0" />
                            </span>
                        </div>
                        <div class="stat-card" style="border-left: 4px solid var(--danger);">
                            <span class="stat-title" style="color: var(--danger);">Low Stock Alerts</span>
                            <span class="stat-value">
                                <c:out value="${lowStockProducts.size()}" default="0" />
                            </span>
                        </div>
                    </div>

                    <!-- Main Content Grid -->
                    <div class="content-grid">

                        <!-- Monthly Sales Chart -->
                        <div class="section-card">
                            <div class="section-header">
                                <h2 class="section-title">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2">
                                        <path d="M12 20V10M18 20V4M6 20v-4" />
                                    </svg>
                                    Revenue Overview
                                </h2>
                            </div>
                            <div style="height: 300px; width: 100%;">
                                <canvas id="salesChart"></canvas>
                            </div>
                        </div>

                        <!-- Low Stock Alerts -->
                        <div class="section-card">
                            <div class="section-header">
                                <h2 class="section-title">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2" style="color: var(--danger);">
                                        <path
                                            d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" />
                                        <line x1="12" y1="9" x2="12" y2="13" />
                                        <line x1="12" y1="17" x2="12.01" y2="17" />
                                    </svg>
                                    Low Stock Items
                                </h2>
                            </div>
                            <div style="max-height: 300px; overflow-y: auto; padding-right: 10px;" id="lowStockList">
                                <c:forEach var="lsp" items="${lowStockProducts}">
                                    <div
                                        style="display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--glass-border);">
                                        <div style="display: flex; align-items: center; gap: 12px;">
                                            <c:choose>
                                                <c:when
                                                    test="${not empty lsp.imagePath and lsp.imagePath.startsWith('http')}">
                                                    <img src="${lsp.imagePath}"
                                                        style="width: 40px; height: 40px; border-radius: 8px; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div
                                                        style="width: 40px; height: 40px; border-radius: 8px; background: rgba(255,255,255,0.05); display: flex; align-items: center; justify-content: center; font-weight: bold; color: var(--text-muted);">
                                                        ${lsp.name.substring(0,1)}</div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div>
                                                <div style="font-weight: 600; font-size: 0.95rem;">${lsp.name}</div>
                                                <div style="font-size: 0.8rem; color: var(--text-muted);">
                                                    ${lsp.category.name}</div>
                                            </div>
                                        </div>
                                        <span
                                            style="color: var(--danger); font-weight: 700; background: rgba(239, 68, 68, 0.1); padding: 4px 10px; border-radius: 12px; font-size: 0.8rem;">
                                            ${lsp.stock} in stock
                                        </span>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty lowStockProducts}">
                                    <div style="text-align: center; color: var(--text-muted); padding: 40px 0;">
                                        <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="1.5"
                                            style="margin-bottom: 15px; opacity: 0.5;">
                                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                                            <polyline points="22 4 12 14.01 9 11.01" />
                                        </svg>
                                        <p>All stock levels are healthy.</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Orders -->
                    <div class="section-card" style="margin-bottom: 40px;">
                        <div class="section-header">
                            <h2 class="section-title">Recent Orders</h2>
                            <a href="${pageContext.request.contextPath}/admin/manage-orders"
                                style="color: var(--primary); text-decoration: none; font-size: 0.9rem; font-weight: 600; background: rgba(99, 102, 241, 0.1); padding: 6px 16px; border-radius: 12px;">View
                                All Orders &rarr;</a>
                        </div>

                        <div style="overflow-x: auto;">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th style="text-align: right;">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ro" items="${recentOrders}">
                                        <tr>
                                            <td style="font-weight: 600; color: #94a3b8;">#${ro.id}</td>
                                            <td>
                                                <div style="font-weight: 600;">${ro.user.username}</div>
                                            </td>
                                            <td>
                                                <div style="color: var(--text-muted);">${ro.orderDate.toLocalDate()}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-badge status-${ro.status}">${ro.status}</span>
                                            </td>
                                            <td style="font-weight: 700; text-align: right; color: var(--text-main);">
                                                $${ro.totalAmount}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty recentOrders}">
                                        <tr>
                                            <td colspan="5"
                                                style="text-align: center; color: var(--text-muted); padding: 40px;">No
                                                recent orders found.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- PRODUCT INVENTORY MANAGEMENT -->
                    <div class="section-header" style="margin-top: 20px;">
                        <h2 class="section-title" id="inventory">Product Inventory Management</h2>
                    </div>
                    <div class="table-card">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${products}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when
                                                    test="${not empty p.imagePath and p.imagePath.startsWith('http')}">
                                                    <img src="${p.imagePath}" class="product-thumb">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200&auto=format&fit=crop&q=80"
                                                        class="product-thumb">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="font-weight: 600">${p.name}</td>
                                        <td><span style="opacity: 0.7">${p.category.name}</span></td>
                                        <td style="color: var(--accent); font-weight: 700">$${p.price}</td>
                                        <td>${p.stock}</td>
                                        <td>
                                            <div class="action-btns">
                                                <a href="#" class="btn-action btn-edit" data-id="${p.id}"
                                                    data-name="${p.name}" data-category="${p.category.name}"
                                                    data-price="${p.price}" data-stock="${p.stock}"
                                                    data-image="${p.imagePath}" data-description="${p.description}"
                                                    onclick="handleEdit(this)">Edit</a>
                                                <a href="${pageContext.request.contextPath}/admin?action=delete&id=${p.id}"
                                                    class="btn-action btn-del"
                                                    onclick="return confirm('Delete this product?')">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Product Modal (Same as before) -->
                <div id="productModal" class="modal">
                    <div class="modal-content">
                        <h2 id="modalTitle" style="margin-bottom: 25px;">Add Product</h2>
                        <form action="${pageContext.request.contextPath}/admin" method="POST"
                            enctype="multipart/form-data">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="id" id="productId">

                            <div class="form-group">
                                <label>Product Name</label>
                                <input type="text" name="name" id="pName" required>
                            </div>
                            <div class="form-group" style="display: flex; gap: 15px;">
                                <div style="flex: 1">
                                    <label>Category</label>
                                    <input type="text" name="category" id="pCategory" required>
                                </div>
                                <div style="flex: 1">
                                    <label>Price</label>
                                    <input type="number" step="0.01" name="price" id="pPrice" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Stock Quantity</label>
                                <input type="number" name="stock" id="pStock" required>
                            </div>
                            <div class="form-group">
                                <label>Product Image</label>
                                <input type="file" name="image" id="pImage">
                                <small id="pImageHint"
                                    style="color: var(--text-muted); display: block; margin-top: 5px;"></small>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea name="description" id="pDesc" rows="3" required></textarea>
                            </div>

                            <div style="display: flex; gap: 15px; margin-top: 30px;">
                                <button type="submit" class="btn-add"
                                    style="flex: 1; border: none; cursor: pointer;">Save Product</button>
                                <button type="button" class="btn-action btn-edit" style="flex: 1"
                                    onclick="hideModal()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    // Modal functions
                    function showModal(action) {
                        document.getElementById('productModal').style.display = 'flex';
                        document.getElementById('formAction').value = action;
                        document.getElementById('modalTitle').innerText = action === 'add' ? 'Add New Product' : 'Edit Product';
                        if (action === 'add') {
                            document.getElementById('productId').value = '';
                            document.getElementById('pName').value = '';
                            document.getElementById('pCategory').value = '';
                            document.getElementById('pPrice').value = '';
                            document.getElementById('pStock').value = '';
                            document.getElementById('pImageHint').innerText = '';
                            document.getElementById('pImage').required = true;
                        } else {
                            document.getElementById('pImage').required = false;
                        }
                    }

                    function hideModal() {
                        document.getElementById('productModal').style.display = 'none';
                    }

                    function handleEdit(btn) {
                        const id = btn.getAttribute('data-id');
                        const name = btn.getAttribute('data-name');
                        const cat = btn.getAttribute('data-category');
                        const price = btn.getAttribute('data-price');
                        const stock = btn.getAttribute('data-stock');
                        const img = btn.getAttribute('data-image');
                        const desc = btn.getAttribute('data-description');
                        editProduct(id, name, cat, price, stock, img, desc);
                    }

                    function editProduct(id, name, cat, price, stock, img, desc) {
                        showModal('edit');
                        document.getElementById('productId').value = id;
                        document.getElementById('pName').value = name;
                        document.getElementById('pCategory').value = cat;
                        document.getElementById('pPrice').value = price;
                        document.getElementById('pStock').value = stock;
                        document.getElementById('pImageHint').innerText = 'Current: ' + img;
                        document.getElementById('pDesc').value = desc;
                    }

                    // Initialize Chart.js
                    document.addEventListener("DOMContentLoaded", function () {
                        const ctx = document.getElementById('salesChart').getContext('2d');

                        // Extract data from JSP attributes mapped softly to JS arrays
                        const labels = ${ not empty salesLabels ?salesLabels: '[]'};
                        const dataPts = ${ not empty salesData ?salesData: '[]'};

                        // Gradient for chart fill
                        let gradient = ctx.createLinearGradient(0, 0, 0, 400);
                        gradient.addColorStop(0, 'rgba(99, 102, 241, 0.5)');
                        gradient.addColorStop(1, 'rgba(99, 102, 241, 0.0)');

                        if (labels.length === 0) {
                            // mock data if empty context 
                            labels.push('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun');
                            dataPts.push(0, 0, 0, 0, 0, 0);
                        }

                        new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Revenue ($)',
                                    data: dataPts,
                                    fill: true,
                                    backgroundColor: gradient,
                                    borderColor: '#6366f1',
                                    borderWidth: 3,
                                    pointBackgroundColor: '#10b981',
                                    pointBorderColor: '#fff',
                                    pointHoverBackgroundColor: '#fff',
                                    pointHoverBorderColor: '#10b981',
                                    pointRadius: 4,
                                    pointHoverRadius: 6,
                                    tension: 0.4 // curve
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: { display: false },
                                    tooltip: {
                                        backgroundColor: 'rgba(15, 23, 42, 0.9)',
                                        titleFont: { family: 'Outfit', size: 13 },
                                        bodyFont: { family: 'Outfit', size: 14, weight: 'bold' },
                                        padding: 12,
                                        borderColor: 'rgba(255,255,255,0.1)',
                                        borderWidth: 1,
                                        displayColors: false,
                                        callbacks: {
                                            label: function (context) {
                                                return '$' + context.parsed.y;
                                            }
                                        }
                                    }
                                },
                                scales: {
                                    x: {
                                        grid: { color: 'rgba(255, 255, 255, 0.05)', drawBorder: false },
                                        ticks: { color: '#94a3b8', font: { family: 'Outfit', size: 12 } }
                                    },
                                    y: {
                                        grid: { color: 'rgba(255, 255, 255, 0.05)', drawBorder: false, borderDash: [5, 5] },
                                        ticks: {
                                            color: '#94a3b8',
                                            font: { family: 'Outfit', size: 12 },
                                            callback: function (value) { return '$' + value; }
                                        },
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    });
                </script>
        </body>

        </html>