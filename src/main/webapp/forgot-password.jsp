<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Forgot Password | Premium Store</title>
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
                    background-image:
                        radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 50%),
                        radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.1) 0, transparent 50%);
                    color: var(--text-main);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .login-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 40px;
                    width: 100%;
                    max-width: 450px;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                }

                .header {
                    text-align: center;
                    margin-bottom: 30px;
                }

                .header h1 {
                    font-size: 2rem;
                    font-weight: 700;
                    margin-bottom: 10px;
                }

                .header p {
                    color: var(--text-muted);
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 600;
                    font-size: 0.9rem;
                    color: var(--text-muted);
                }

                .form-group input {
                    width: 100%;
                    padding: 12px 16px;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid var(--glass-border);
                    border-radius: 12px;
                    color: white;
                    font-size: 1rem;
                    transition: 0.3s;
                }

                .form-group input:focus {
                    outline: none;
                    border-color: var(--primary);
                    background: rgba(255, 255, 255, 0.1);
                }

                .btn {
                    width: 100%;
                    padding: 14px;
                    background: var(--primary);
                    color: white;
                    border: none;
                    border-radius: 12px;
                    font-size: 1rem;
                    font-weight: 700;
                    cursor: pointer;
                    transition: 0.3s;
                }

                .btn:hover {
                    background: var(--primary-hover);
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
                }

                .alert {
                    padding: 12px 16px;
                    border-radius: 12px;
                    margin-bottom: 20px;
                    font-size: 0.9rem;
                }

                .alert-error {
                    background: rgba(239, 68, 68, 0.1);
                    border: 1px solid rgba(239, 68, 68, 0.2);
                    color: #f87171;
                }

                .alert-success {
                    background: rgba(16, 185, 129, 0.1);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                    color: #34d399;
                }

                .footer-links {
                    text-align: center;
                    margin-top: 25px;
                    color: var(--text-muted);
                    font-size: 0.9rem;
                }

                .footer-links a {
                    color: var(--primary);
                    text-decoration: none;
                    font-weight: 600;
                }
            </style>
        </head>

        <body>
            <div class="login-card">
                <div class="header">
                    <h1>Account Recovery</h1>
                    <p>Enter your email to receive a reset link</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <form action="forgot-password" method="post">
                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="you@example.com" required>
                    </div>
                    <button type="submit" class="btn">Send Link</button>
                </form>

                <div class="footer-links">
                    <p>Remembered your password? <a href="login">Back to Login</a></p>
                </div>
            </div>
        </body>

        </html>