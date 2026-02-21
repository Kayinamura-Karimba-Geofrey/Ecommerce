<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4>User Login</h4>
        </div>
        <div class="card-body">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="login" method="post">

                <input type="email" name="email"
                       placeholder="Email"
                       class="form-control mb-3" required>

                <input type="password" name="password"
                       placeholder="Password"
                       class="form-control mb-3" required>

                <button class="btn btn-success w-100">
                    Login
                </button>

            </form>

            <div class="mt-3 text-center">
                Don't have account?
                <a href="register.jsp">Register</a>
            </div>

        </div>
    </div>
</div>

</body>
</html>