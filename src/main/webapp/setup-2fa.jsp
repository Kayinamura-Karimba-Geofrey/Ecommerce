<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Set Up 2FA | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
                    --bg-card: rgba(30, 41, 59, 0.7);
                    --text-main: #f1f5f9;
                    --text-muted: #94a3b8;
                    --accent: #10b981;
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
                    max-width: 480px;
                    width: 100%;
                    background: var(--bg-card);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--border);
                    border-radius: 24px;
                    padding: 40px;
                    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                    text-align: center;
                }

                h1 {
                    font-size: 1.6rem;
                    margin-bottom: 12px;
                }

                p {
                    color: var(--text-muted);
                    font-size: 0.95rem;
                    line-height: 1.5;
                    margin-bottom: 30px;
                }

                .qr-container {
                    background: white;
                    padding: 15px;
                    border-radius: 16px;
                    display: inline-block;
                    margin-bottom: 24px;
                }

                .qr-container img {
                    display: block;
                    width: 200px;
                    height: 200px;
                }

                .secret-key {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px dashed var(--border);
                    border-radius: 8px;
                    padding: 10px;
                    font-family: monospace;
                    font-size: 0.9rem;
                    color: var(--accent);
                    margin-bottom: 30px;
                }

                .form-group {
                    text-align: left;
                    margin-bottom: 20px;
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
                    font-size: 1.1rem;
                    text-align: center;
                    letter-spacing: 4px;
                    transition: border-color 0.3s;
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
                    margin-top: 16px;
                }

                .cancel-link {
                    display: block;
                    margin-top: 20px;
                    color: var(--text-muted);
                    text-decoration: none;
                    font-size: 0.85rem;
                }

                .cancel-link:hover {
                    color: white;
                }
            </style>
        </head>

        <body>

            <div class="card">
                <h1>Connect Authenticator</h1>
                <p>Scan the QR code below with your authenticator app (like Google Authenticator or Authy) to link your
                    account.</p>

                <div class="qr-container">
                    <img src="${qrUri}" alt="2FA QR Code">
                </div>

                <div class="secret-key">
                    <small style="color: var(--text-muted); display: block; margin-bottom: 4px;">Manual Setup
                        Code:</small>
                    ${secret}
                </div>

                <form method="post" action="2fa-setup">
                    <div class="form-group">
                        <label>Verify Code</label>
                        <input type="text" name="code" placeholder="000000" maxlength="6" required autocomplete="off">
                    </div>

                    <button type="submit" class="btn">Confirm & Enable 2FA</button>
                </form>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <a href="profile.jsp" class="cancel-link">Cancel and go back</a>
            </div>

        </body>

        </html>