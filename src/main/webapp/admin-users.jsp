<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Users | Admin Panel</title>
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

                .role-badge {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                }

                .role-admin {
                    background: rgba(16, 185, 129, 0.1);
                    color: var(--accent);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                }

                .role-user {
                    background: rgba(99, 102, 241, 0.1);
                    color: var(--primary);
                    border: 1px solid rgba(99, 102, 241, 0.2);
                }

                .action-select {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    color: var(--text-main);
                    padding: 4px 8px;
                    border-radius: 8px;
                    font-size: 0.85rem;
                    cursor: pointer;
                }

                .btn-save {
                    background: var(--primary);
                    color: white;
                    border: none;
                    padding: 6px 14px;
                    border-radius: 8px;
                    font-size: 0.85rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: 0.2s;
                }

                .btn-save:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 10px rgba(99, 102, 241, 0.3);
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="admin-container">
                    <header class="admin-header">
                        <div>
                            <h1>User Management</h1>
                            <p style="color: var(--text-muted)">View and manage account privileges</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/dashboard"
                            style="color: var(--text-muted); text-decoration: none;">&larr; Back to Dashboard</a>
                    </header>

                    <div class="table-card">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Full Name</th>
                                    <th>Email</th>
                                    <th>Current Role</th>
                                    <th>Manage Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td style="color: var(--text-muted)">#${u.id}</td>
                                        <td style="font-weight: 600">${u.fullname}</td>
                                        <td>${u.email}</td>
                                        <td>
                                            <span class="role-badge ${u.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
                                                ${u.role}
                                            </span>
                                        </td>
                                        <td>
                                            <form action="users" method="POST"
                                                style="display: flex; gap: 10px; align-items: center;">
                                                <input type="hidden" name="action" value="updateRole">
                                                <input type="hidden" name="userId" value="${u.id}">
                                                <select name="role" class="action-select">
                                                    <option value="USER" ${u.role=='USER' ? 'selected' : '' }>USER
                                                    </option>
                                                    <option value="ADMIN" ${u.role=='ADMIN' ? 'selected' : '' }>ADMIN
                                                    </option>
                                                </select>
                                                <button type="submit" class="btn-save">Update</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
        </body>

        </html>