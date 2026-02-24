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
                            <h1>Admin Dashboard</h1>
                            <p style="color: var(--text-muted)">Manage your store's inventory</p>
                        </div>
                        <a href="#" class="btn-add" onclick="showModal('add')">Add New Product</a>
                    </header>

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
                                        <td><img src="${p.imageUrl}" class="product-thumb"></td>
                                        <td style="font-weight: 600">${p.name}</td>
                                        <td><span style="opacity: 0.7">${p.category}</span></td>
                                        <td style="color: var(--accent); font-weight: 700">$${p.price}</td>
                                        <td>${p.stock}</td>
                                        <td>
                                            <div class="action-btns">
                                                <a href="#" class="btn-action btn-edit"
                                                    onclick="editProduct(${p.id}, '${p.name}', '${p.category}', ${p.price}, ${p.stock}, '${p.imageUrl}', '${p.description}')">Edit</a>
                                                <a href="admin?action=delete&id=${p.id}" class="btn-action btn-del"
                                                    onclick="return confirm('Delete this product?')">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Product Modal -->
                <div id="productModal" class="modal">
                    <div class="modal-content">
                        <h2 id="modalTitle" style="margin-bottom: 25px;">Add Product</h2>
                        <form action="admin" method="POST">
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
                                <label>Image URL</label>
                                <input type="text" name="imageUrl" id="pImg" required>
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
                            document.getElementById('pImg').value = '';
                            document.getElementById('pDesc').value = '';
                        }
                    }

                    function hideModal() {
                        document.getElementById('productModal').style.display = 'none';
                    }

                    function editProduct(id, name, cat, price, stock, img, desc) {
                        showModal('edit');
                        document.getElementById('productId').value = id;
                        document.getElementById('pName').value = name;
                        document.getElementById('pCategory').value = cat;
                        document.getElementById('pPrice').value = price;
                        document.getElementById('pStock').value = stock;
                        document.getElementById('pImg').value = img;
                        document.getElementById('pDesc').value = desc;
                    }
                </script>
        </body>

        </html>