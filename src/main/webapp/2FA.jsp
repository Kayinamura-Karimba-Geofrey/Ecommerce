<div
    style="max-width: 400px; margin: 100px auto; padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; font-family: sans-serif;">
    <h2 style="margin-bottom: 20px;">Two-Factor Authentication</h2>
    <p style="color: #666; margin-bottom: 30px;">Verify your login for <strong>${not empty email ? email : 'your
            account'}</strong></p>

    <form method="post" action="login">
        <div style="margin-bottom: 20px;">
            <input type="text" name="totp" placeholder="Enter 6-digit code" required
                style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1.1rem; text-align: center; letter-spacing: 4px;">
        </div>
        <button type="submit"
            style="width: 100%; padding: 12px; background: #6366f1; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;">
            Verify & Login
        </button>
    </form>

    <c:if test="${not empty error}">
        <p style="color:#ef4444; margin-top: 20px; font-size: 0.9rem;">${error}</p>
    </c:if>
</div>