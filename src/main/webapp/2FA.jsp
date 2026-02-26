<form method="post" action="login">
    <label>Enter 2FA Code:</label>
    <input type="text" name="totp" required>
    <button type="submit">Verify</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>