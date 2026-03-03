<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Support Center | Premium Store</title>
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
                    background-color: var(--bg-dark);
                    background-image: radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 50%), radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.1) 0, transparent 50%);
                    color: var(--text-main);
                    min-height: 100vh;
                    padding-top: 100px;
                }

                .container {
                    max-width: 1000px;
                    margin: 0 auto;
                    padding: 0 20px;
                }

                .header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 40px;
                }

                .card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 30px;
                    margin-bottom: 30px;
                }

                .ticket-list {
                    width: 100%;
                    border-collapse: collapse;
                }

                .ticket-list th,
                .ticket-list td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid var(--glass-border);
                }

                .ticket-list th {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .status-badge {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 0.8rem;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .status-open {
                    background: rgba(16, 185, 129, 0.15);
                    color: var(--accent);
                }

                .status-closed {
                    background: rgba(148, 163, 184, 0.15);
                    color: var(--text-muted);
                }

                .btn {
                    padding: 12px 24px;
                    border-radius: 12px;
                    font-weight: 700;
                    text-decoration: none;
                    cursor: pointer;
                    transition: 0.3s;
                    border: none;
                    font-family: inherit;
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
                }

                .modal {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.8);
                    backdrop-filter: blur(4px);
                    z-index: 1000;
                    align-items: center;
                    justify-content: center;
                }

                .modal-content {
                    background: var(--bg-dark);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 40px;
                    width: 100%;
                    max-width: 500px;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    color: var(--text-muted);
                    font-weight: 600;
                }

                .form-group input,
                .form-group textarea {
                    width: 100%;
                    padding: 12px;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    border-radius: 12px;
                    color: white;
                    font-family: inherit;
                }

                /* ─── Responsive ─── */
                @media (max-width: 768px) {
                    body {
                        padding-top: 80px;
                    }

                    .container {
                        padding: 0 12px;
                    }

                    .header {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 15px;
                        margin-bottom: 25px;
                    }

                    .header h1 {
                        font-size: 1.8rem;
                    }

                    .header .btn {
                        width: 100%;
                        text-align: center;
                    }

                    .card {
                        padding: 15px;
                        overflow-x: auto;
                    }

                    .ticket-list th,
                    .ticket-list td {
                        padding: 10px;
                        font-size: 0.85rem;
                    }

                    .modal-content {
                        padding: 25px 20px;
                        margin: 0 12px;
                    }
                }

                @media (max-width: 480px) {

                    .ticket-list th:nth-child(1),
                    .ticket-list td:nth-child(1),
                    .ticket-list th:nth-child(4),
                    .ticket-list td:nth-child(4) {
                        display: none;
                    }
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>
                <div class="container">
                    <div class="header">
                        <h1>Support Tickets</h1>
                        <button class="btn btn-primary"
                            onclick="document.getElementById('ticketModal').style.display='flex'">New Ticket</button>
                    </div>

                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty tickets}">
                                <table class="ticket-list">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Subject</th>
                                            <th>Status</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="ticket" items="${tickets}">
                                            <tr>
                                                <td>#${ticket.id}</td>
                                                <td style="font-weight: 600;">${ticket.subject}</td>
                                                <td><span
                                                        class="status-badge status-${ticket.status.toLowerCase()}">${ticket.status}</span>
                                                </td>
                                                <td style="color: var(--text-muted);">${ticket.createdAt}</td>
                                                <td><a href="support?id=${ticket.id}" class="btn btn-primary"
                                                        style="padding: 6px 15px; font-size: 0.8rem;">View</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; color: var(--text-muted); padding: 40px;">
                                    <p>No support tickets yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Modal -->
                <div id="ticketModal" class="modal">
                    <div class="modal-content">
                        <h2 style="margin-bottom: 25px;">Create New Ticket</h2>
                        <form action="support" method="post">
                            <input type="hidden" name="action" value="create">
                            <div class="form-group">
                                <label>Subject</label>
                                <input type="text" name="subject" required placeholder="e.g. Order #123 Issues">
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea name="description" rows="5" required
                                    placeholder="Describe your issue in detail..."></textarea>
                            </div>
                            <div style="display: flex; gap: 15px;">
                                <button type="submit" class="btn btn-primary" style="flex: 1;">Submit</button>
                                <button type="button" class="btn"
                                    style="flex: 1; background: rgba(255,255,255,0.1); color: white;"
                                    onclick="document.getElementById('ticketModal').style.display='none'">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
        </body>

        </html>