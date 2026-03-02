<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Verify Login | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
                    --bg-card: rgba(30, 41, 59, 0.7);
                    --text-main: #f1f5f9;
                    --text-muted: #94a3b8;
                    --border: rgba(255, 255, 255, 0.08);
                }

                body {
                    background: var(--bg-dark);
                    background-image: radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 55%);
                    color: var(--text-main);
                    font-family: 'Outfit', sans-serif;
                    margin: 0;
                    padding: 0;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .card {
                    max-width: 400px;
                    width: 100%;
                    background: var(--bg-card);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--border);
                    border-radius: 24px;
                    padding: 40px;
                    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                    text-align: center;
                }

                h2 {
                    font-size: 1.5rem;
                    margin-bottom: 12px;
                    font-weight: 700;
                }

                p {
                    color: var(--text-muted);
                    font-size: 0.95rem;
                    margin-bottom: 30px;
                }

                .input-group {
                    margin-bottom: 24px;
                    text-align: left;
                }

                label {
                    display: block;
                    margin-bottom: 8px;
                    font-size: 0.85rem;
                    color: var(--text-muted);
                    font-weight: 600;
                    text-transform: uppercase;
                }

                input {
                    width: 100%;
                    padding: 14px;
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid var(--border);
                    border-radius: 12px;
                    color: white;
                    font-size: 1.2rem;
                    text-align: center;
                    letter-spacing: 6px;
                    transition: all 0.3s;
                }

                input:focus {
                    outline: none;
                    border-color: var(--primary);
                    background: rgba(255, 255, 255, 0.06);
                }

                .btn {
                    width: 100%;
                    padding: 14px;
                    background: var(--primary);
                    color: white;
                    border: none;
                    border-radius: 12px;
                    font-weight: 700;
                    font-size: 1rem;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .btn:hover {
                    background: #4f46e5;
                    transform: translateY(-2px);
                }

                .error {
                    color: #ef4444;
                    font-size: 0.9rem;
                    margin-top: 20px;
                    font-weight: 500;
                }

                .back-link {
                    display: block;
                    margin-top: 24px;
                    color: var(--text-muted);
                    text-decoration: none;
                    font-size: 0.85rem;
                }

                .back-link:hover {
                    color: white;
                }
            </style>
        </head>

        <body>

            <div class="card">
                <h2>Two-Factor Auth</h2>
                <p>Verify your login for <strong>
                        <c:out value="${not empty email ? email : 'your account'}" />
                    </strong></p>

                <form method="post" action="login">
                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                    <div class="input-group">
                        <label>Authentication Code</label>
                        <input type="text" name="totp" inputmode="numeric" placeholder="000000" maxlength="6"
                            autocomplete="one-time-code" required autofocus>
                    </div>

                    <button type="submit" class="btn">Verify & Sign In</button>
                </form>

                <c:if test="${not empty error}">
                    <div class="error">⚠️
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <a href="login.jsp" class="back-link">Back to login</a>
            </div>

        </body>

        </html>