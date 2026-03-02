<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>System Message | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
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
                    background-image: radial-gradient(at 50% 50%, rgba(99, 102, 241, 0.15) 0, transparent 60%);
                    color: var(--text-main);
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    text-align: center;
                    padding: 20px;
                }

                .error-card {
                    background: rgba(30, 41, 59, 0.7);
                    backdrop-filter: blur(24px);
                    border: 1px solid var(--glass-border);
                    padding: 60px 40px;
                    border-radius: 40px;
                    max-width: 500px;
                    width: 100%;
                    box-shadow: 0 40px 80px -20px rgba(0, 0, 0, 0.5);
                }

                .code {
                    font-size: 6rem;
                    font-weight: 800;
                    margin-bottom: 10px;
                    background: linear-gradient(to bottom right, #6366f1, #10b981);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                h1 {
                    font-size: 1.8rem;
                    margin-bottom: 15px;
                }

                p {
                    color: var(--text-muted);
                    line-height: 1.6;
                    margin-bottom: 30px;
                }

                .btn-home {
                    display: inline-block;
                    background: var(--primary);
                    color: white;
                    padding: 14px 30px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 600;
                    transition: 0.3s;
                }

                .btn-home:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
                }
            </style>
        </head>

        <body>
            <div class="error-card">
                <div class="code">
                    <c:choose>
                        <c:when test="${not empty statusCode}">${statusCode}</c:when>
                        <c:otherwise>Ops!</c:otherwise>
                    </c:choose>
                </div>
                <h1>Something went wrong</h1>
                <p>The page you are looking for might have been removed, had its name changed, or is temporarily
                    unavailable.</p>

                <a href="${pageContext.request.contextPath}/products" class="btn-home">Back to Store</a>
            </div>
        </body>

        </html>