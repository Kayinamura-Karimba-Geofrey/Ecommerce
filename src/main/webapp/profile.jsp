<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <c:if test="${empty sessionScope.loggedUser}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Profile | Premium Store</title>
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
                    --danger: #ef4444;
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
                }

                .container {
                    max-width: 800px;
                    margin: 100px auto;
                    padding: 0 20px;
                }

                .profile-card {
                    background: var(--bg-card);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--border);
                    border-radius: 24px;
                    padding: 40px;
                    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                }

                .profile-header {
                    display: flex;
                    align-items: center;
                    gap: 24px;
                    margin-bottom: 40px;
                    padding-bottom: 30px;
                    border-bottom: 1px solid var(--border);
                }

                .avatar {
                    width: 80px;
                    height: 80px;
                    background: linear-gradient(135deg, var(--primary), #10b981);
                    border-radius: 20px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2rem;
                    font-weight: 800;
                }

                .user-info h1 {
                    margin: 0;
                    font-size: 1.8rem;
                    font-weight: 700;
                }

                .user-info p {
                    margin: 4px 0 0;
                    color: var(--text-muted);
                }

                .section-title {
                    font-size: 1.1rem;
                    font-weight: 700;
                    margin-bottom: 20px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .status-box {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid var(--border);
                    border-radius: 16px;
                    padding: 24px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .status-info h4 {
                    margin: 0;
                    font-size: 1rem;
                }

                .status-info p {
                    margin: 6px 0 0;
                    font-size: 0.9rem;
                    color: var(--text-muted);
                    max-width: 400px;
                }

                .badge {
                    padding: 6px 14px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .badge-enabled {
                    background: rgba(16, 185, 129, 0.15);
                    color: var(--accent);
                }

                .badge-disabled {
                    background: rgba(239, 68, 68, 0.15);
                    color: var(--danger);
                }

                .btn {
                    display: inline-block;
                    padding: 12px 24px;
                    border-radius: 12px;
                    font-weight: 600;
                    font-size: 0.95rem;
                    text-decoration: none;
                    transition: all 0.3s;
                    cursor: pointer;
                    border: none;
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                }

                .btn-primary:hover {
                    background: #4f46e5;
                    transform: translateY(-2px);
                }

                .btn-outline-danger {
                    background: transparent;
                    color: var(--danger);
                    border: 1px solid rgba(239, 68, 68, 0.3);
                }

                .btn-outline-danger:hover {
                    background: rgba(239, 68, 68, 0.1);
                }

                .alert {
                    padding: 16px 20px;
                    border-radius: 12px;
                    margin-bottom: 24px;
                    font-size: 0.95rem;
                    font-weight: 500;
                }

                .alert-success {
                    background: rgba(16, 185, 129, 0.15);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                    color: #34d399;
                }

                .back-link {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    color: var(--text-muted);
                    text-decoration: none;
                    font-size: 0.9rem;
                    margin-bottom: 20px;
                    transition: color 0.3s;
                }

                .back-link:hover {
                    color: var(--primary);
                }
            </style>
        </head>

        <body>

            <jsp:include page="navbar.jsp" />

            <div class="container">
                <a href="products" class="back-link">← Back to Store</a>

                <c:if test="${param.msg == '2fa_enabled'}">
                    <div class="alert alert-success">✓ Two-Factor Authentication has been successfully enabled!</div>
                </c:if>
                <c:if test="${param.msg == '2fa_disabled'}">
                    <div class="alert alert-success">Two-Factor Authentication has been disabled.</div>
                </c:if>

                <div class="profile-card">
                    <div class="profile-header">
                        <div class="avatar">${loggedUser.fullname.substring(0,1)}</div>
                        <div class="user-info">
                            <h1>${loggedUser.fullname}</h1>
                            <p>${loggedUser.email}</p>
                        </div>
                    </div>

                    <div class="section-title">🛡️ Security Settings</div>

                    <div class="status-box">
                        <div class="status-info">
                            <h4>Two-Factor Authentication (2FA)
                                <span
                                    class="badge ${loggedUser.isTwoFactorEnabled() ? 'badge-enabled' : 'badge-disabled'}">
                                    ${loggedUser.isTwoFactorEnabled() ? 'Enabled' : 'Disabled'}
                                </span>
                            </h4>
                            <p>Add an extra layer of security to your account by requiring a code from an authenticator
                                app when you sign in.</p>
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${loggedUser.isTwoFactorEnabled()}">
                                    <a href="2fa-setup?action=disable" class="btn btn-outline-danger"
                                        onclick="return confirm('WARNING: Are you sure you want to disable 2FA? Your account will be less secure.')">
                                        Disable 2FA
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="2fa-setup?action=setup" class="btn btn-primary">Enable 2FA</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>