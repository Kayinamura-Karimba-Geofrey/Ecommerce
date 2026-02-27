<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | Premium Store</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #6366f1;
                --primary-hover: #4f46e5;
                --bg-dark: #0f172a;
                --card-bg: rgba(30, 41, 59, 0.8);
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
                background-image:
                    radial-gradient(at 20% 20%, rgba(99, 102, 241, 0.2) 0, transparent 50%),
                    radial-gradient(at 80% 80%, rgba(16, 185, 129, 0.15) 0, transparent 50%);
                color: var(--text-main);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .auth-card {
                background: var(--card-bg);
                backdrop-filter: blur(16px);
                border: 1px solid var(--glass-border);
                border-radius: 28px;
                padding: 50px 45px;
                width: 100%;
                max-width: 440px;
                box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.7);
                animation: fadeIn 0.5s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .logo {
                text-align: center;
                margin-bottom: 35px;
            }

            .logo-icon {
                font-size: 2.5rem;
                margin-bottom: 10px;
            }

            .logo h1 {
                font-size: 1.8rem;
                font-weight: 700;
                background: linear-gradient(to right, #6366f1, #10b981);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .logo p {
                color: var(--text-muted);
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .error-box {
                background: rgba(239, 68, 68, 0.1);
                border: 1px solid rgba(239, 68, 68, 0.3);
                border-radius: 12px;
                padding: 12px 16px;
                color: var(--danger);
                font-size: 0.9rem;
                margin-bottom: 20px;
            }

            .input-group {
                margin-bottom: 20px;
            }

            .input-group label {
                display: block;
                font-size: 0.9rem;
                color: var(--text-muted);
                margin-bottom: 8px;
                font-weight: 500;
            }

            .input-group input {
                width: 100%;
                padding: 14px 18px;
                background: rgba(15, 23, 42, 0.6);
                border: 1px solid var(--glass-border);
                border-radius: 12px;
                color: var(--text-main);
                font-size: 1rem;
                transition: all 0.3s;
            }

            .input-group input:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
            }

            .input-group input::placeholder {
                color: var(--text-muted);
            }

            .btn-submit {
                width: 100%;
                background: var(--primary);
                color: white;
                padding: 15px;
                border: none;
                border-radius: 14px;
                font-size: 1.05rem;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 5px;
            }

            .btn-submit:hover {
                background: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
            }

            .footer-link {
                text-align: center;
                margin-top: 25px;
                font-size: 0.9rem;
                color: var(--text-muted);
            }

            .footer-link a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }

            .footer-link a:hover {
                text-decoration: underline;
            }

            .divider {
                display: flex;
                align-items: center;
                gap: 15px;
                margin: 25px 0;
                color: var(--text-muted);
                font-size: 0.85rem;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--glass-border);
            }
        </style>
    </head>

    <body>
        <div class="auth-card">
            <div class="logo">
                <div class="logo-icon">🔐</div>
                <h1>Welcome Back</h1>
                <p>Sign in to your Premium Store account</p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-box">⚠️ ${error}</div>
            </c:if>

            <form action="login" method="post">
                <div class="input-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn-submit">Sign In →</button>
            </form>

            <div class="footer-link">
                Don't have an account? <a href="register.jsp">Create one</a>
            </div>
        </div>
    </body>

    </html>