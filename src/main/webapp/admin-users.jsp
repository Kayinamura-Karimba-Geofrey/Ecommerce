<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>User Management | Premium Store</title>
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
                    border: none;
                }

                .btn-promote {
                    background: rgba(99, 102, 241, 0.1);
                    color: var(--primary);
                    border: 1px solid rgba(99, 102, 241, 0.2);
                }

                .btn-promote:hover {
                    background: rgba(99, 102, 241, 0.2);
                }

                .btn-block {
                    background: rgba(245, 158, 11, 0.1);
                    color: var(--warning);
                    border: 1px solid rgba(245, 158, 11, 0.2);
                }

                .btn-block:hover {
                    background: rgba(245, 158, 11, 0.2);
                }

                .btn-unblock {
                    background: rgba(16, 185, 129, 0.1);
                    color: var(--accent);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                }

                .btn-unblock:hover {
                    background: rgba(16, 185, 129, 0.2);
                }

                .btn-del {
                    background: rgba(239, 68, 68, 0.1);
                    color: var(--danger);
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .btn-del:hover {
                    background: rgba(239, 68, 68, 0.2);
                }

                .role-badge {
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    display: inline-block;
                }

                .role-ADMIN {
                    background: rgba(99, 102, 241, 0.2);
                    color: var(--primary);
                }

                .role-USER {
                    background: rgba(255, 255, 255, 0.1);
                    color: var(--text-muted);
                }

                .status-badge {
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    display: inline-block;
                }

                .status-Active {
                    background: rgba(16, 185, 129, 0.2);
                    color: var(--accent);
                }

                .status-Blocked {
                    background: rgba(239, 68, 68, 0.2);
                    color: var(--danger);
                }

                .alert-error {
                    background: rgba(239, 68, 68, 0.1);
                    color: var(--danger);
                    border: 1px solid rgba(239, 68, 68, 0.2);
                    padding: 15px;
                    border-radius: 12px;
                    margin-bottom: 20px;
                    font-weight: 600;
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>

                <div class="admin-container">
                    <header class="admin-header">
                        <div>
                            <h1>Customers & Users</h1>
                            <p style="color: var(--text-muted); margin-top: 5px;">Manage platform users</p>
                        </div>
                    </header>

                    <c:if test="${param.error == 'self_modify'}">
                        <div class="alert-error">
                            Security Policy: You cannot modify or delete your own admin account from this panel.
                        </div>
                    </c:if>

                    <div class="table-card">
                        <div style="overflow-x: auto;">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>User Details</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${users}">
                                        <tr>
                                            <td style="font-weight: 600; color: #94a3b8; font-size: 1.1rem;">#${u.id}
                                            </td>
                                            <td>
                                                <div style="font-weight: 600; font-size: 1.1rem;">${u.fullname}</div>
                                                <div style="font-size: 0.85rem; color: var(--text-muted);">${u.email}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="role-badge role-${u.role}">${u.role}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.blocked}">
                                                        <span class="status-badge status-Blocked">Blocked</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-Active">Active</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-btns">
                                                    <!-- Promote Action -->
                                                    <c:if test="${u.role != 'ADMIN'}">
                                                        <form action="${pageContext.request.contextPath}/admin/users"
                                                            method="POST">
                                                            <input type="hidden" name="action" value="promote">
                                                            <input type="hidden" name="id" value="${u.id}">
                                                            <button type="submit" class="btn-action btn-promote"
                                                                onclick="return confirm('Promote ${u.fullname} to Administrator?')">Promote
                                                                to Admin</button>
                                                        </form>
                                                    </c:if>

                                                    <!-- Block/Unblock Action -->
                                                    <c:if test="${loggedUser.id != u.id}">
                                                        <form action="${pageContext.request.contextPath}/admin/users"
                                                            method="POST">
                                                            <input type="hidden" name="id" value="${u.id}">
                                                            <c:choose>
                                                                <c:when test="${u.blocked}">
                                                                    <input type="hidden" name="action" value="unblock">
                                                                    <button type="submit"
                                                                        class="btn-action btn-unblock">Unblock</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input type="hidden" name="action" value="block">
                                                                    <button type="submit" class="btn-action btn-block"
                                                                        onclick="return confirm('Block ${u.fullname} from accessing the store?')">Block</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </form>

                                                        <!-- Delete Action -->
                                                        <form action="${pageContext.request.contextPath}/admin/users"
                                                            method="POST">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${u.id}">
                                                            <button type="submit" class="btn-action btn-del"
                                                                onclick="return confirm('WARNING: Are you sure you want to permanently delete user: ${u.fullname}? This cannot be undone.')">Delete</button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
        </body>

        </html>