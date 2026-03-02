<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin - Manage Tickets | Premium Store</title>
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
                    background: var(--bg-dark);
                    color: var(--text-main);
                    min-height: 100vh;
                    padding: 40px;
                }

                .dashboard-container {
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .header {
                    margin-bottom: 40px;
                }

                .card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 30px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th,
                td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid var(--glass-border);
                }

                th {
                    color: var(--text-muted);
                    font-size: 0.85rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .status {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: 700;
                }

                .status-open {
                    background: rgba(16, 185, 129, 0.15);
                    color: var(--accent);
                }

                .status-closed {
                    background: rgba(239, 68, 68, 0.15);
                    color: #f87171;
                }

                .btn {
                    padding: 8px 16px;
                    border-radius: 8px;
                    font-weight: 700;
                    text-decoration: none;
                    background: var(--primary);
                    color: white;
                    border: none;
                    cursor: pointer;
                }
            </style>
        </head>

        <body>
            <div class="dashboard-container">
                <div class="header">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                        style="color: var(--primary); text-decoration: none;">← Back to Dashboard</a>
                    <h1 style="margin-top: 10px;">Support Ticket Management</h1>
                </div>

                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Subject</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ticket" items="${tickets}">
                                <tr>
                                    <td>#${ticket.id}</td>
                                    <td>
                                        <div style="font-weight: 600;">${ticket.user.fullname}</div>
                                        <div style="font-size: 0.8rem; color: var(--text-muted);">${ticket.user.email}
                                        </div>
                                    </td>
                                    <td>${ticket.subject}</td>
                                    <td><span
                                            class="status status-${ticket.status.toLowerCase()}">${ticket.status}</span>
                                    </td>
                                    <td style="color: var(--text-muted);">${ticket.createdAt}</td>
                                    <td><a href="tickets?id=${ticket.id}" class="btn">View & Reply</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </body>

        </html>