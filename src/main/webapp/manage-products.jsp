<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Products | Premium Store</title>
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    :root {
                        --primary: #6366f1;
                        --primary-hover: #4f46e5;
                        --bg-dark: #0b1120;
                        --bg-card: rgba(30, 41, 59, 0.65);
                        --text-main: #f1f5f9;
                        --text-muted: #94a3b8;
                        --accent: #10b981;
                        --danger: #ef4444;
                        --danger-hover: #dc2626;
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
                        transition: 0.2s;
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

                    .btn-add {
                        background: var(--primary);
                        color: white;
                        border: none;
                        padding: 10px 24px;
                        border-radius: 12px;
                        font-weight: 600;
                        font-size: 0.95rem;
                        cursor: pointer;
                        transition: 0.3s;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .btn-add:hover {
                        background: var(--primary-hover);
                        transform: translateY(-2px);
                        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
                    }

                    /* ── Filters & Search ─────────────────────────────────────────────── */
                    .filters-card {
                        background: var(--bg-card);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--border);
                        border-radius: 16px;
                        padding: 20px;
                        margin-bottom: 25px;
                        display: flex;
                        gap: 15px;
                        align-items: center;
                    }

                    .search-input {
                        flex: 1;
                        background: rgba(15, 23, 42, 0.6);
                        border: 1px solid var(--border);
                        color: white;
                        padding: 10px 16px;
                        border-radius: 10px;
                        font-size: 0.9rem;
                        outline: none;
                    }

                    .search-input:focus {
                        border-color: var(--primary);
                    }

                    .btn-search {
                        background: rgba(255, 255, 255, 0.05);
                        color: white;
                        border: 1px solid var(--border);
                        padding: 10px 20px;
                        border-radius: 10px;
                        cursor: pointer;
                        transition: 0.2s;
                    }

                    .btn-search:hover {
                        background: rgba(255, 255, 255, 0.1);
                    }

                    /* ── Products Table ───────────────────────────────────────────────── */
                    .content-card {
                        background: var(--bg-card);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--border);
                        border-radius: 20px;
                        overflow: hidden;
                    }

                    .products-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .products-table th {
                        text-align: left;
                        padding: 18px 25px;
                        color: var(--text-muted);
                        font-size: 0.78rem;
                        text-transform: uppercase;
                        letter-spacing: 0.06em;
                        border-bottom: 1px solid var(--border);
                        background: rgba(15, 23, 42, 0.4);
                    }

                    .products-table td {
                        padding: 16px 25px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.04);
                        font-size: 0.9rem;
                        vertical-align: middle;
                    }

                    .products-table tr:last-child td {
                        border-bottom: none;
                    }

                    .products-table tr:hover {
                        background: rgba(255, 255, 255, 0.02);
                    }

                    .prod-img-wrap {
                        width: 50px;
                        height: 50px;
                        border-radius: 10px;
                        overflow: hidden;
                        background: #1e293b;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .prod-img-wrap img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .stock-badge {
                        padding: 4px 10px;
                        border-radius: 20px;
                        font-size: 0.75rem;
                        font-weight: 700;
                    }

                    .stock-badge.ok {
                        background: rgba(16, 185, 129, 0.15);
                        color: #10b981;
                    }

                    .stock-badge.low {
                        background: rgba(239, 68, 68, 0.15);
                        color: #ef4444;
                    }

                    /* ── Actions ──────────────────────────────────────────────────────── */
                    .actions-cell {
                        display: flex;
                        gap: 8px;
                    }

                    .btn-icon {
                        width: 34px;
                        height: 34px;
                        border-radius: 8px;
                        border: none;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: 0.2s;
                    }

                    .btn-edit {
                        background: rgba(99, 102, 241, 0.15);
                        color: var(--primary);
                    }

                    .btn-edit:hover {
                        background: var(--primary);
                        color: white;
                    }

                    .btn-delete {
                        background: rgba(239, 68, 68, 0.15);
                        color: var(--danger);
                    }

                    .btn-delete:hover {
                        background: var(--danger);
                        color: white;
                    }

                    /* ── Modal (Add/Edit) ─────────────────────────────────────────────── */
                    .modal-overlay {
                        position: fixed;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: rgba(0, 0, 0, 0.7);
                        backdrop-filter: blur(5px);
                        display: none;
                        justify-content: center;
                        align-items: center;
                        z-index: 1000;
                        opacity: 0;
                        transition: opacity 0.3s;
                    }

                    .modal-overlay.active {
                        display: flex;
                        opacity: 1;
                    }

                    .modal-card {
                        background: #0f172a;
                        border: 1px solid var(--border);
                        border-radius: 20px;
                        width: 100%;
                        max-width: 550px;
                        padding: 30px;
                        transform: translateY(20px);
                        transition: transform 0.3s;
                        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
                        max-height: 90vh;
                        overflow-y: auto;
                    }

                    .modal-overlay.active .modal-card {
                        transform: translateY(0);
                    }

                    .modal-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 25px;
                    }

                    .modal-title {
                        font-size: 1.4rem;
                        font-weight: 700;
                    }

                    .btn-close {
                        background: none;
                        border: none;
                        color: var(--text-muted);
                        font-size: 1.5rem;
                        cursor: pointer;
                    }

                    .btn-close:hover {
                        color: white;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-label {
                        display: block;
                        margin-bottom: 8px;
                        font-size: 0.85rem;
                        color: var(--text-muted);
                        font-weight: 500;
                    }

                    .form-control {
                        width: 100%;
                        background: rgba(30, 41, 59, 0.5);
                        border: 1px solid var(--border);
                        color: white;
                        padding: 12px 16px;
                        border-radius: 12px;
                        outline: none;
                        transition: 0.2s;
                        font-family: inherit;
                    }

                    .form-control:focus {
                        border-color: var(--primary);
                        box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2);
                    }

                    textarea.form-control {
                        resize: vertical;
                        min-height: 100px;
                    }

                    .form-row {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 15px;
                    }

                    .modal-footer {
                        display: flex;
                        justify-content: flex-end;
                        gap: 12px;
                        margin-top: 10px;
                    }

                    .btn-cancel {
                        background: transparent;
                        color: white;
                        border: 1px solid var(--border);
                        padding: 10px 20px;
                        border-radius: 10px;
                        cursor: pointer;
                        transition: 0.2s;
                    }

                    .btn-cancel:hover {
                        background: rgba(255, 255, 255, 0.05);
                    }

                    .btn-save {
                        background: var(--primary);
                        color: white;
                        border: none;
                        padding: 10px 24px;
                        border-radius: 10px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: 0.2s;
                    }

                    .btn-save:hover {
                        background: var(--primary-hover);
                    }

                    /* Pagination */
                    .pagination {
                        display: flex;
                        justify-content: center;
                        gap: 8px;
                        padding: 25px;
                    }

                    .page-link {
                        width: 36px;
                        height: 36px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 10px;
                        background: rgba(255, 255, 255, 0.05);
                        color: var(--text-muted);
                        text-decoration: none;
                        font-weight: 600;
                        transition: 0.2s;
                        border: 1px solid transparent;
                    }

                    .page-link:hover,
                    .page-link.active {
                        background: var(--primary);
                        color: white;
                        border-color: var(--primary);
                    }
                </style>
            </head>

            <body>

                <!-- SIDEBAR -->
                <aside class="sidebar">
                    <div class="sidebar-logo">⚡ PREMIUM ADMIN</div>
                    <nav class="sidebar-nav">
                        <a href="/demo1/admin/dashboard" class="nav-item"><span>📊</span> Dashboard</a>
                        <a href="/demo1/orders" class="nav-item"><span>📦</span> Orders</a>
                        <a href="/demo1/admin/products" class="nav-item active"><span>🛍️</span> Products</a>
                        <a href="/demo1/admin/users" class="nav-item"><span>👥</span> Users</a>
                        <a href="/demo1/products" class="nav-item"><span>🌐</span> View Store</a>
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
                            style="display:block; margin-top:18px; color: #ef4444; text-decoration:none; font-size:0.85rem; font-weight:600;">Sign
                            Out →</a>
                    </div>
                </aside>

                <!-- MAIN CONTENT -->
                <main class="main">
                    <div class="page-header">
                        <div>
                            <h1>Manage Products</h1>
                            <p>Add, edit, or remove products from your store.</p>
                        </div>
                        <button class="btn-add" onclick="openModal('add')"><span>➕</span> Add Product</button>
                    </div>

                    <form method="get" action="/demo1/admin/products" class="filters-card">
                        <input type="text" name="search" value="${search}" placeholder="Search products by name..."
                            class="search-input">
                        <button type="submit" class="btn-search">Search</button>
                    </form>

                    <div class="content-card">
                        <table class="products-table">
                            <thead>
                                <tr>
                                    <th width="80">Image</th>
                                    <th>Product Details</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th width="120">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${products}">
                                    <tr>
                                        <td>
                                            <div class="prod-img-wrap">
                                                <c:choose>
                                                    <c:when
                                                        test="${not empty p.imagePath && p.imagePath.startsWith('http')}">
                                                        <img src="${p.imagePath}" alt="${p.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200&auto=format&fit=crop&q=80"
                                                             alt="${p.name}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="font-weight:600; color:white; margin-bottom:4px;">${p.name}
                                            </div>
                                            <div style="font-size:0.8rem; color:var(--text-muted);">${p.category.name}
                                            </div>
                                        </td>
                                        <td style="font-weight:600; color:var(--accent);">$
                                            <fmt:formatNumber value="${p.price}" maxFractionDigits="2" />
                                        </td>
                                        <td>
                                            <span class="stock-badge ${p.stock < 5 ? 'low' : 'ok'}">${p.stock} in
                                                stock</span>
                                        </td>
                                        <td>
                                            <div class="actions-cell">
                                                <!-- Edit Logic -->
                                                <button class="btn-icon btn-edit"
                                                    onclick="openModal('edit', ${p.id}, '${p.name.replace('\'','\\\'')}', '${p.description.replace('\'','\\\'')}', ${p.price}, ${p.stock}, ${p.category.id})"
                                                    title="Edit">✏️</button>

                                                <!-- Delete Logic -->
                                                <form action="/demo1/admin/products" method="post" style="margin:0;"
                                                    onsubmit="return confirm('Are you sure you want to delete ${p.name.replace('\'','\\\'')}?');">
                                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${p.id}">
                                                    <button type="submit" class="btn-icon btn-delete"
                                                        title="Delete">🗑️</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty products}">
                                    <tr>
                                        <td colspan="5"
                                            style="text-align:center; padding: 40px; color:var(--text-muted);">No
                                            products found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>

                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="?page=${i}&search=${search}"
                                        class="page-link ${i == currentPage ? 'active' : ''}">${i}</a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </main>

                <!-- ADD/EDIT MODAL -->
                <div class="modal-overlay" id="productModal">
                    <div class="modal-card">
                        <div class="modal-header">
                            <h2 class="modal-title" id="modalTitle">Add Product</h2>
                            <button class="btn-close" onclick="closeModal()">×</button>
                        </div>

                        <form id="productForm" action="/demo1/admin/products" method="post"
                            enctype="multipart/form-data">
                            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="id" id="productId" value="">

                            <div class="form-group">
                                <label class="form-label">Product Name</label>
                                <input type="text" name="name" id="productName" class="form-control" required>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Price ($)</label>
                                    <input type="number" step="0.01" name="price" id="productPrice" class="form-control"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Stock Quantity</label>
                                    <input type="number" name="stock" id="productStock" class="form-control" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Category</label>
                                <select name="categoryId" id="productCategory" class="form-control" required>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Description</label>
                                <textarea name="description" id="productDesc" class="form-control" required></textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Product Image <span
                                        style="font-weight:normal; font-size:0.8em; color:var(--accent);"
                                        id="imgHint">(Required for new products)</span></label>
                                <input type="file" name="image" id="productImage" class="form-control" accept="image/*">
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                                <button type="submit" class="btn-save" id="saveBtn">Save Product</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    const modal = document.getElementById('productModal');

                    function openModal(mode, id, name, desc, price, stock, catId) {
                        modal.classList.add('active');

                        const actionEl = document.getElementById('formAction');
                        const titleEl = document.getElementById('modalTitle');
                        const saveBtn = document.getElementById('saveBtn');
                        const imgHint = document.getElementById('imgHint');
                        const imgInput = document.getElementById('productImage');

                        if (mode === 'add') {
                            actionEl.value = 'add';
                            titleEl.textContent = 'Add New Product';
                            saveBtn.textContent = 'Create Product';
                            document.getElementById('productForm').reset();
                            document.getElementById('productId').value = '';
                            imgHint.textContent = '(Required)';
                            imgInput.required = true;
                        } else {
                            actionEl.value = 'edit';
                            titleEl.textContent = 'Edit Product';
                            saveBtn.textContent = 'Save Changes';

                            document.getElementById('productId').value = id;
                            document.getElementById('productName').value = name;
                            document.getElementById('productDesc').value = desc;
                            document.getElementById('productPrice').value = price;
                            document.getElementById('productStock').value = stock;
                            document.getElementById('productCategory').value = catId;

                            imgHint.textContent = '(Leave empty to keep current)';
                            imgInput.required = false;
                        }
                    }

                    function closeModal() {
                        modal.classList.remove('active');
                    }

                    // Close when clicking outside modal-card
                    modal.addEventListener('click', function (e) {
                        if (e.target === modal) closeModal();
                    });
                </script>
            </body>

            </html>