<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Ticket #${ticket.id} | Support</title>
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
                    padding-top: 100px;
                }

                .container {
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 0 20px;
                }

                .ticket-header {
                    margin-bottom: 30px;
                }

                .badge {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 0.8rem;
                    font-weight: 700;
                }

                .msg-bubble {
                    padding: 20px;
                    border-radius: 20px;
                    margin-bottom: 20px;
                    max-width: 85%;
                }

                .msg-user {
                    background: rgba(99, 102, 241, 0.1);
                    border: 1px solid var(--glass-border);
                    align-self: flex-end;
                    margin-left: auto;
                }

                .msg-admin {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                }

                .chat-container {
                    display: flex;
                    flex-direction: column;
                    margin-bottom: 40px;
                }

                .reply-box {
                    background: var(--card-bg);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 25px;
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
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                }
            </style>
        </head>

        <body>
            <%@ include file="navbar.jsp" %>
                <div class="container">
                    <div class="ticket-header">
                        <a href="support"
                            style="color: var(--primary); text-decoration: none; display: block; margin-bottom: 10px;">←
                            Back to Tickets</a>
                        <h1 style="font-size: 2.2rem; margin-bottom: 10px;">${ticket.subject}</h1>
                        <span class="badge"
                            style="background: ${ticket.status == 'OPEN' ? 'rgba(16, 185, 129, 0.15)' : 'rgba(239, 68, 68, 0.15)'}; color: ${ticket.status == 'OPEN' ? 'var(--accent)' : '#f87171'}">${ticket.status}</span>
                        <span style="color: var(--text-muted); margin-left: 15px;">Created on ${ticket.createdAt}</span>
                    </div>

                    <div class="chat-container">
                        <!-- Original Description -->
                        <div class="msg-bubble msg-user">
                            <p style="font-size: 1.1rem; line-height: 1.6;">${ticket.description}</p>
                            <small
                                style="color: var(--text-muted); display: block; margin-top: 10px;">${ticket.user.fullname}</small>
                        </div>

                        <!-- Messages -->
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
                        <div class="reply-box">
                            <form action="support" method="post">
                                <input type="hidden" name="action" value="reply">
                                <input type="hidden" name="ticketId" value="${ticket.id}">
                                <textarea name="message" rows="4" placeholder="Type your reply here..."
                                    required></textarea>
                                <button type="submit" class="btn btn-primary">Send Message</button>
                            </form>
                        </div>
                    </c:if>
                </div>
        </body>

        </html>