<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Two-Factor Authentication</title>
</head>
<body style="background:#0f172a; margin:0; padding:0;">
    <div style="max-width: 420px; margin: 100px auto; padding: 40px; background: rgba(255,255,255,0.95); border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.35); text-align: center; font-family: sans-serif;">
        <h2 style="margin: 0 0 16px;">Two-Factor Authentication</h2>
        <p style="color: #475569; margin: 0 0 26px;">
            Verify your login for <strong><c:out value="${not empty email ? email : 'your account'}"/></strong>
        </p>

        <form method="post" action="login">
            <div style="margin-bottom: 16px;">
                <input type="text" name="totp" inputmode="numeric" autocomplete="one-time-code"
                       placeholder="Enter 6-digit code" required
                       style="width: 100%; padding: 12px; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 1.1rem; text-align: center; letter-spacing: 4px;">
            </div>
            <button type="submit"
                    style="width: 100%; padding: 12px; background: #6366f1; color: white; border: none; border-radius: 8px; font-weight: 700; cursor: pointer;">
                Verify & Login
            </button>
        </form>

        <c:if test="${not empty error}">
            <p style="color:#ef4444; margin-top: 18px; font-size: 0.95rem;">
                <c:out value="${error}"/>
            </p>
        </c:if>
    </div>
</body>
</html>