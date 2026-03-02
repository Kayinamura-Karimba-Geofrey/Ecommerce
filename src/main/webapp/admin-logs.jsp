<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.functions" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Security Audit Logs | Premium Admin</title>
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
                        background-image: radial-gradient(at 100% 0%, rgba(99, 102, 241, 0.1) 0, transparent 50%);
                        color: var(--text-main);
                        min-height: 100vh;
                    }

                    .container {
                        max-width: 1200px;
                        margin: 0 auto;
                        padding: 40px 20px;
                    }

                    .header {
                        margin-bottom: 40px;
                    }

                    .header h1 {
                        font-size: 2.5rem;
                        background: linear-gradient(to right, #6366f1, #10b981);
                        -webkit-background-clip: text;
                        background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    .log-table-container {
                        background: var(--card-bg);
                        backdrop-filter: blur(12px);
                        border: 1px solid var(--glass-border);
                        border-radius: 24px;
                        overflow: hidden;
                    }

                    .log-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .log-table th {
                        text-align: left;
                        padding: 20px;
                        background: rgba(255, 255, 255, 0.03);
                        color: var(--text-muted);
                        text-transform: uppercase;
                        font-size: 0.8rem;
                        letter-spacing: 0.05em;
                    }

                    .log-table td {
                        padding: 15px 20px;
                        border-bottom: 1px solid var(--glass-border);
                        font-size: 0.9rem;
                    }

                    .action-badge {
                        padding: 4px 10px;
                        border-radius: 8px;
                        font-size: 0.75rem;
                        font-weight: 700;
                        text-transform: uppercase;
                    }

                    .action-BLOCK_USER,
                    .action-DELETE_USER,
                    .action-DELETE_PRODUCT {
                        background: rgba(239, 68, 68, 0.2);
                        color: #fca5a5;
                    }

                    .action-PROMOTE_USER,
                    .action-UNBLOCK_USER {
                        background: rgba(16, 185, 129, 0.2);
                        color: #6ee7b7;
                    }

                    .timestamp {
                        color: var(--text-muted);
                        font-size: 0.8rem;
                    }
                </style>
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="container">
                        <header class="header">
                            <h1>Security Audit Logs</h1>
                            <p style="color: var(--text-muted); margin-top: 5px;">Tracking administrative actions and
                                platform history</p>
                        </header>

                        <div class="log-table-container">
                            <table class="log-table">
                                <thead>
                                    <tr>
                                        <th>Timestamp</th>
                                        <th>Admin</th>
                                        <th>Action</th>
                                        <th>Target</th>
                                        <th>Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="log" items="${logs}">
                                        <tr>
                                            <td class="timestamp">${log.timestamp}</td>
                                            <td>
                                                <div style="font-weight: 600;">${log.admin.fullname}</div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted);">
                                                    ${log.admin.email}</div>
                                            </td>
                                            <td><span class="action-badge action-${log.action}">${log.action}</span>
                                            </td>
                                            <td><code
                                                    style="background: rgba(0,0,0,0.3); padding: 2px 6px; border-radius: 4px;">#${log.targetId}</code>
                                            </td>
                                            <td>${log.details}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty logs}">
                                        <tr>
                                            <td colspan="5"
                                                style="text-align: center; padding: 40px; color: var(--text-muted);">No
                                                logs recorded yet.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
            </body>

            </html>