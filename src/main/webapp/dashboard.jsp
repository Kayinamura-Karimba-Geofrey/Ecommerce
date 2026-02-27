<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard | Premium Store</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
          rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <style>
          :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg-dark: #0b1120;
            --bg-card: rgba(30, 41, 59, 0.65);
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --accent: #10b981;
            --warn: #f59e0b;
            --danger: #ef4444;
            --border: rgba(255, 255, 255, 0.08);
            --sidebar-w: 240px;
          }

          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
          }

          body {
            background: var(--bg-dark);
            background-image:
              radial-gradient(at 0% 0%, rgba(99, 102, 241, .12) 0, transparent 55%),
              radial-gradient(at 100% 100%, rgba(16, 185, 129, .08) 0, transparent 55%);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
          }

          /* ── Sidebar ──────────────────────────────────────────────────────── */
          .sidebar {
            width: var(--sidebar-w);
            min-height: 100vh;
            background: rgba(15, 23, 42, 0.9);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            padding: 30px 0;
            z-index: 100;
          }

          .sidebar-logo {
            padding: 0 25px 30px;
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(to right, #6366f1, #10b981);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            border-bottom: 1px solid var(--border);
            margin-bottom: 20px;
          }

          .sidebar-nav {
            padding: 0 15px;
            flex: 1;
          }

          .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            border-radius: 12px;
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            margin-bottom: 4px;
            transition: all 0.2s;
          }

          .nav-item:hover,
          .nav-item.active {
            background: rgba(99, 102, 241, 0.12);
            color: var(--primary);
          }

          .sidebar-footer {
            padding: 20px 25px 0;
            border-top: 1px solid var(--border);
          }

          .admin-avatar {
            display: flex;
            align-items: center;
            gap: 12px;
          }

          .avatar-circle {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, #6366f1, #10b981);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.9rem;
          }

          .admin-name {
            font-weight: 600;
            font-size: 0.9rem;
          }

          .admin-role {
            font-size: 0.75rem;
            color: var(--accent);
          }

          /* ── Main Content ─────────────────────────────────────────────────── */
          .main {
            margin-left: var(--sidebar-w);
            flex: 1;
            padding: 35px 40px;
          }

          .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
          }

          .page-header h1 {
            font-size: 1.8rem;
            font-weight: 700;
          }

          .page-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-top: 4px;
          }

          .header-date {
            background: var(--bg-card);
            border: 1px solid var(--border);
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 0.85rem;
            color: var(--text-muted);
          }

          /* ── KPI Cards ────────────────────────────────────────────────────── */
          .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
          }

          .kpi-card {
            background: var(--bg-card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 24px;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s, border-color 0.3s;
          }

          .kpi-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
          }

          .kpi-card::before {
            content: '';
            position: absolute;
            top: -20px;
            right: -20px;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            opacity: 0.15;
          }

          .kpi-card.revenue::before {
            background: var(--accent);
          }

          .kpi-card.orders::before {
            background: var(--primary);
          }

          .kpi-card.users::before {
            background: var(--warn);
          }

          .kpi-card.products::before {
            background: #ec4899;
          }

          .kpi-card.pending::before {
            background: var(--danger);
          }

          .kpi-icon {
            font-size: 1.8rem;
            margin-bottom: 12px;
          }

          .kpi-value {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 6px;
          }

          .kpi-label {
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 500;
          }

          .kpi-card.revenue .kpi-value {
            color: var(--accent);
          }

          .kpi-card.orders .kpi-value {
            color: var(--primary);
          }

          .kpi-card.pending .kpi-value {
            color: var(--danger);
          }

          /* ── Charts & Tables Row ──────────────────────────────────────────── */
          .content-grid {
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
          }

          .content-card {
            background: var(--bg-card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 28px;
          }

          .card-title {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
          }

          .badge {
            background: rgba(99, 102, 241, 0.12);
            color: var(--primary);
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
          }

          /* ── Orders Table ───────────────────────────────────────────────────── */
          .orders-table {
            width: 100%;
            border-collapse: collapse;
          }

          .orders-table th {
            text-align: left;
            padding-bottom: 14px;
            color: var(--text-muted);
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            border-bottom: 1px solid var(--border);
          }

          .orders-table td {
            padding: 14px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            font-size: 0.9rem;
          }

          .orders-table tr:last-child td {
            border-bottom: none;
          }

          .status-pill {
            display: inline-block;
            padding: 3px 12px;
            border-radius: 20px;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
          }

          .status-pill.PAID {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
          }

          .status-pill.PENDING {
            background: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
          }

          .status-pill.SHIPPED {
            background: rgba(99, 102, 241, 0.15);
            color: #6366f1;
          }

          .status-pill.DELIVERED {
            background: rgba(20, 184, 166, 0.15);
            color: #14b8a6;
          }

          .status-pill.CANCELLED {
            background: rgba(239, 68, 68, 0.15);
            color: #ef4444;
          }

          /* ── Low Stock Alert ─────────────────────────────────────────────── */
          .stock-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
          }

          .stock-item:last-child {
            border-bottom: none;
          }

          .stock-name {
            font-weight: 500;
            font-size: 0.9rem;
          }

          .stock-qty {
            font-weight: 800;
            font-size: 1rem;
            padding: 4px 14px;
            border-radius: 20px;
          }

          .stock-qty.critical {
            background: rgba(239, 68, 68, 0.15);
            color: #ef4444;
          }

          .stock-qty.low {
            background: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
          }

          .no-alerts {
            text-align: center;
            padding: 30px 0;
            color: var(--accent);
            font-weight: 600;
          }

          /* ── Quick Links ─────────────────────────────────────────────────── */
          .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
          }

          .quick-link {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            color: var(--text-main);
            transition: all 0.3s;
          }

          .quick-link:hover {
            border-color: var(--primary);
            transform: translateY(-3px);
          }

          .quick-link .ql-icon {
            font-size: 1.8rem;
            margin-bottom: 8px;
          }

          .quick-link .ql-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
          }

          @media (max-width: 1100px) {
            .content-grid {
              grid-template-columns: 1fr;
            }
          }

          @media (max-width: 768px) {
            .sidebar {
              transform: translateX(-100%);
            }

            .main {
              margin-left: 0;
              padding: 20px;
            }
          }
        </style>
      </head>

      <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
          <div class="sidebar-logo">⚡ PREMIUM ADMIN</div>

          <nav class="sidebar-nav">
            <a href="/demo1/admin/dashboard" class="nav-item active">
              <span>📊</span> Dashboard
            </a>
            <a href="/demo1/orders" class="nav-item">
              <span>📦</span> Orders
            </a>
            <a href="/demo1/admin/products" class="nav-item">
              <span>🛍️</span> Products
            </a>
            <a href="/demo1/admin/users" class="nav-item">
              <span>👥</span> Users
            </a>
            <a href="/demo1/products" class="nav-item">
              <span>🌐</span> View Store
            </a>
          </nav>

          <div class="sidebar-footer">
            <div class="admin-avatar">
              <div class="avatar-circle">A</div>
              <div>
                <div class="admin-name">${sessionScope.loggedUser.fullname}</div>
                <div class="admin-role">Administrator</div>
              </div>
            </div>
            <a href="/demo1/logout"
              style="display:block; margin-top:18px; color: #ef4444; text-decoration:none; font-size:0.85rem; font-weight:600;">
              Sign Out →
            </a>
          </div>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main">

          <!-- Header -->
          <div class="page-header">
            <div>
              <h1>Dashboard</h1>
              <p>Welcome back, ${sessionScope.loggedUser.fullname}. Here's what's happening today.</p>
            </div>
            <div class="header-date" id="live-date"></div>
          </div>

          <!-- KPI Cards -->
          <div class="kpi-grid">
            <div class="kpi-card revenue">
              <div class="kpi-icon">💰</div>
              <div class="kpi-value">$
                <fmt:formatNumber value="${totalRevenue}" maxFractionDigits="0" />
              </div>
              <div class="kpi-label">Total Revenue</div>
            </div>
            <div class="kpi-card orders">
              <div class="kpi-icon">📋</div>
              <div class="kpi-value">${totalOrders}</div>
              <div class="kpi-label">Total Orders</div>
            </div>
            <div class="kpi-card pending">
              <div class="kpi-icon">⏳</div>
              <div class="kpi-value">${pendingOrders}</div>
              <div class="kpi-label">Pending Orders</div>
            </div>
            <div class="kpi-card users">
              <div class="kpi-icon">👤</div>
              <div class="kpi-value">${totalUsers}</div>
              <div class="kpi-label">Registered Users</div>
            </div>
            <div class="kpi-card products">
              <div class="kpi-icon">🛒</div>
              <div class="kpi-value">${totalProducts}</div>
              <div class="kpi-label">Products</div>
            </div>
          </div>

          <!-- Chart + Low Stock -->
          <div class="content-grid">

            <!-- Monthly Revenue Chart -->
            <div class="content-card">
              <div class="card-title">📈 Monthly Revenue <span class="badge">2026</span></div>
              <canvas id="revenueChart" height="90"></canvas>
            </div>

            <!-- Low Stock Alerts -->
            <div class="content-card">
              <div class="card-title">⚠️ Low Stock Alerts <span class="badge">${lowStockProducts.size()} items</span>
              </div>
              <c:choose>
                <c:when test="${not empty lowStockProducts}">
                  <c:forEach var="p" items="${lowStockProducts}">
                    <div class="stock-item">
                      <div class="stock-name">${p.name}</div>
                      <div class="stock-qty ${p.stock == 0 ? 'critical' : 'low'}">${p.stock} left</div>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div class="no-alerts">✅ All products are well stocked!</div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <!-- Recent Orders Table -->
          <div class="content-card" style="margin-bottom: 25px;">
            <div class="card-title">🕒 Recent Orders <a href="/demo1/orders"
                style="font-size:0.8rem; color:var(--primary); text-decoration:none; margin-left: auto; font-weight:600;">View
                all →</a></div>
            <table class="orders-table">
              <thead>
                <tr>
                  <th>Order ID</th>
                  <th>Customer</th>
                  <th>Date</th>
                  <th>Amount</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="order" items="${recentOrders}">
                  <tr>
                    <td style="font-weight:700; color: var(--primary);">#${order.id}</td>
                    <td>${order.user.email}</td>
                    <td style="color: var(--text-muted);">${order.orderDate}</td>
                    <td style="font-weight:700; color: var(--accent);">$
                      <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2" />
                    </td>
                    <td><span class="status-pill ${order.status}">${order.status}</span></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <!-- Quick Actions -->
          <div class="content-card">
            <div class="card-title">⚡ Quick Actions</div>
            <div class="quick-links">
              <a href="/demo1/admin/products?action=new" class="quick-link">
                <div class="ql-icon">➕</div>
                <div class="ql-label">Add Product</div>
              </a>
              <a href="/demo1/orders" class="quick-link">
                <div class="ql-icon">📦</div>
                <div class="ql-label">Manage Orders</div>
              </a>
              <a href="/demo1/admin/users" class="quick-link">
                <div class="ql-icon">👥</div>
                <div class="ql-label">Manage Users</div>
              </a>
              <a href="/demo1/admin/categories" class="quick-link">
                <div class="ql-icon">🏷️</div>
                <div class="ql-label">Categories</div>
              </a>
              <a href="/demo1/products" class="quick-link">
                <div class="ql-icon">🌐</div>
                <div class="ql-label">View Store</div>
              </a>
            </div>
          </div>

        </main>

        <script>
          // Live date
          document.getElementById('live-date').textContent = new Date().toLocaleDateString('en-US', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
          });

          // Revenue Chart
          const ctx = document.getElementById('revenueChart').getContext('2d');
          const gradient = ctx.createLinearGradient(0, 0, 0, 300);
          gradient.addColorStop(0, 'rgba(99, 102, 241, 0.3)');
          gradient.addColorStop(1, 'rgba(99, 102, 241, 0.01)');

          new Chart(ctx, {
            type: 'line',
            data: {
              labels: [${ salesLabels }],
              datasets: [{
                label: 'Revenue ($)',
                data: [${ salesData }],
                borderColor: '#6366f1',
                backgroundColor: gradient,
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#6366f1',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 8
              }]
            },
            options: {
              responsive: true,
              plugins: {
                legend: { display: false },
                tooltip: {
                  backgroundColor: 'rgba(15,23,42,0.9)',
                  borderColor: 'rgba(99,102,241,0.5)',
                  borderWidth: 1,
                  titleColor: '#f1f5f9',
                  bodyColor: '#94a3b8',
                  callbacks: {
                    label: (ctx) => ` $${ctx.parsed.y.toFixed(2)}`
                  }
                }
              },
              scales: {
                x: {
                  grid: { color: 'rgba(255,255,255,0.05)' },
                  ticks: { color: '#94a3b8' }
                },
                y: {
                  beginAtZero: true,
                  grid: { color: 'rgba(255,255,255,0.05)' },
                  ticks: {
                    color: '#94a3b8',
                    callback: (v) => '$' + v
                  }
                }
              }
            }
          });
        </script>
      </body>

      </html>