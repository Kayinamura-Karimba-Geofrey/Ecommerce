<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Category Management | Premium Store</title>
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
                    max-width: 1000px;
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
                    cursor: pointer;
                    border: none;
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
                    vertical-align: middle;
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
                    cursor: pointer;
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
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
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

                .form-group input {
                    width: 100%;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    padding: 12px;
                    border-radius: 10px;
                    color: var(--text-main);
                    outline: none;
                }

                .form-group input:focus {
                    border-color: var(--primary);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="admin-container">
                    <header class="admin-header">
                        <div>
                            <h1>Categories</h1>
                            <p style="color: var(--text-muted); margin-top: 5px;">Manage product categories</p>
                        </div>
                        <button class="btn-add" onclick="showModal('add')">+ Add Category</button>
                    </header>

                    <div class="table-card">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th width="10%">ID</th>
                                    <th width="70%">Name</th>
                                    <th width="20%">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--text-muted);">#${cat.id}</td>
                                        <td style="font-weight: 600; font-size: 1.1rem;">${cat.name}</td>
                                        <td>
                                            <div class="action-btns">
                                                <button class="btn-action btn-edit" data-id="${cat.id}"
                                                    data-name="${cat.name}" onclick="handleEdit(this)">Edit</button>
                                                <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${cat.id}"
                                                    class="btn-action btn-del"
                                                    onclick="return confirm('WARNING: Deleting a category will cause issues with existing products assigned to this category. Are you sure you want to proceed?')">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty categories}">
                                    <tr>
                                        <td colspan="3"
                                            style="text-align: center; padding: 40px; color: var(--text-muted);">No
                                            categories found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Category Modal -->
                <div id="categoryModal" class="modal">
                    <div class="modal-content">
                        <h2 id="modalTitle" style="margin-bottom: 25px;">Add Category</h2>
                        <form action="${pageContext.request.contextPath}/admin/categories" method="POST">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="id" id="categoryId">

                            <div class="form-group">
                                <label>Category Name</label>
                                <input type="text" name="name" id="cName" required>
                            </div>

                            <div style="display: flex; gap: 15px; margin-top: 30px;">
                                <button type="submit" class="btn-add"
                                    style="flex: 1; border: none; cursor: pointer;">Save</button>
                                <button type="button" class="btn-action btn-edit" style="flex: 1;"
                                    onclick="hideModal()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function showModal(action) {
                        document.getElementById('categoryModal').style.display = 'flex';
                        document.getElementById('formAction').value = action;
                        document.getElementById('modalTitle').innerText = action === 'add' ? 'Add Category' : 'Edit Category';

                        if (action === 'add') {
                            document.getElementById('categoryId').value = '';
                            document.getElementById('cName').value = '';
                        }

                        // autofocus name input
                        setTimeout(() => document.getElementById('cName').focus(), 100);
                    }

                    function hideModal() {
                        document.getElementById('categoryModal').style.display = 'none';
                    }

                    function handleEdit(btn) {
                        const id = btn.getAttribute('data-id');
                        const name = btn.getAttribute('data-name');

                        showModal('edit');
                        document.getElementById('categoryId').value = id;
                        document.getElementById('cName').value = name;
                    }

                    // Close modal on outside click
                    window.onclick = function (event) {
                        var modal = document.getElementById('categoryModal');
                        if (event.target == modal) {
                            hideModal();
                        }
                    }
                </script>
        </body>

        </html>