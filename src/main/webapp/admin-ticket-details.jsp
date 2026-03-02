<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Ticket #${ticket.id} | Admin</title>
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

                .container {
                    max-width: 900px;
                    margin: 0 auto;
                }

                .ticket-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 30px;
                }

                .msg-bubble {
                    padding: 20px;
                    border-radius: 20px;
                    margin-bottom: 20px;
                    max-width: 85%;
                }

                .msg-user {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                }

                .msg-admin {
                    background: rgba(99, 102, 241, 0.1);
                    border: 1px solid var(--glass-border);
                    align-self: flex-end;
                    margin-left: auto;
                }

                .chat-container {
                    display: flex;
                    flex-direction: column;
                    margin-bottom: 40px;
                }

                .actions {
                    background: var(--card-bg);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 30px;
                }

                textarea {
                    width: 100%;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    border-radius: 12px;
                    padding: 15px;
                    color: white;
                    resize: none;
                    margin-bottom: 15px;
                    font-family: inherit;
                }

                .btn {
                    padding: 12px 24px;
                    border-radius: 12px;
                    font-weight: 700;
                    border: none;
                    cursor: pointer;
                    transition: 0.3s;
                    color: white;
                }

                .btn-primary {
                    background: var(--primary);
                }

                .btn-success {
                    background: var(--accent);
                }

                .btn-danger {
                    background: #ef4444;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="ticket-header">
                    <div>
                        <a href="tickets" style="color: var(--primary); text-decoration: none;">← Back to Tickets</a>
                        <h1 style="margin-top: 10px; font-size: 2rem;">Ticket #${ticket.id}: ${ticket.subject}</h1>
                        <p style="color: var(--text-muted);">From: <strong>${ticket.user.fullname}</strong>
                            (${ticket.user.email})</p>
                    </div>
                    <div style="text-align: right;">
                        <span
                            style="display: block; margin-bottom: 10px; font-weight: 700; color: ${ticket.status == 'OPEN' ? 'var(--accent)' : '#ef4444'}">${ticket.status}</span>
                        <c:choose>
                            <c:when test="${ticket.status == 'OPEN'}">
                                <form action="tickets" method="post">
                                    <input type="hidden" name="action" value="close">
                                    <input type="hidden" name="ticketId" value="${ticket.id}">
                                    <button type="submit" class="btn btn-danger">Close Ticket</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="tickets" method="post">
                                    <input type="hidden" name="action" value="reopen">
                                    <input type="hidden" name="ticketId" value="${ticket.id}">
                                    <button type="submit" class="btn btn-success">Reopen Ticket</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="chat-container">
                    <div class="msg-bubble msg-user">
                        <p style="font-size: 1.1rem; line-height: 1.6;">${ticket.description}</p>
                        <small
                            style="color: var(--text-muted); display: block; margin-top: 10px;">${ticket.user.fullname}
                            • Initial Report</small>
                    </div>

                    <c:forEach var="msg" items="${messages}">
                        <div class="msg-bubble ${msg.sender.role == 'ADMIN' ? 'msg-admin' : 'msg-user'}">
                            <p style="line-height: 1.6;">${msg.message}</p>
                            <small
                                style="color: var(--text-muted); display: block; margin-top: 10px;">${msg.sender.fullname}
                                • ${msg.createdAt}</small>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${ticket.status == 'OPEN'}">
                    <div class="actions">
                        <form action="tickets" method="post">
                            <input type="hidden" name="action" value="reply">
                            <input type="hidden" name="ticketId" value="${ticket.id}">
                            <textarea name="message" rows="5" placeholder="Type your official reply..."
                                required></textarea>
                            <button type="submit" class="btn btn-primary">Send Reply & Update Ticket</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </body>

        </html>