<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Admin Dashboard</h2>

    <a href="${pageContext.request.contextPath}/logout"
       class="btn btn-outline-danger">
      Logout
    </a>
  </div>

  <!-- STATISTICS CARDS -->
  <div class="row g-4">

    <div class="col-md-3">
      <div class="card shadow-sm text-center border-primary">
        <div class="card-body">
          <h6 class="text-muted">Total Users</h6>
          <h3 class="text-primary fw-bold">
            ${totalUsers}
          </h3>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card shadow-sm text-center border-success">
        <div class="card-body">
          <h6 class="text-muted">Total Products</h6>
          <h3 class="text-success fw-bold">
            ${totalProducts}
          </h3>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card shadow-sm text-center border-warning">
        <div class="card-body">
          <h6 class="text-muted">Total Orders</h6>
          <h3 class="text-warning fw-bold">
            ${totalOrders}
          </h3>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card shadow-sm text-center border-danger">
        <div class="card-body">
          <h6 class="text-muted">Total Revenue</h6>
          <h3 class="text-danger fw-bold">
            $${totalRevenue}
          </h3>
        </div>
      </div>
    </div>

  </div>

  <!-- RECENT ORDERS SECTION -->
  <hr class="my-5">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4>Recent Orders</h4>
    <a href="${pageContext.request.contextPath}/admin/manage-orders"
       class="btn btn-sm btn-outline-primary">
      View All Orders
    </a>
  </div>

  <div class="card shadow-sm">
    <div class="card-body p-0">

      <table class="table table-striped table-hover mb-0">
        <thead class="table-dark">
        <tr>
          <th>Order ID</th>
          <th>Customer</th>
          <th>Date</th>
          <th>Total</th>
        </tr>
        </thead>

        <tbody>

        <c:forEach var="order" items="${recentOrders}">
          <tr>
            <td>#${order.id}</td>
            <td>${order.user.name}</td>
            <td>${order.orderDate}</td>
            <td class="fw-bold text-success">
              $${order.totalAmount}
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty recentOrders}">
          <tr>
            <td colspan="4" class="text-center py-4 text-muted">
              No recent orders found.
            </td>
          </tr>
        </c:if>

        </tbody>
      </table>

    </div>
  </div>

  <!-- QUICK ACTIONS -->
  <hr class="my-5">

  <div class="d-flex gap-3">

    <a href="${pageContext.request.contextPath}/admin/add-product.jsp"
       class="btn btn-primary">
      Add Product
    </a>

    <a href="${pageContext.request.contextPath}/admin/manage-orders"
       class="btn btn-warning">
      Manage Orders
    </a>

    <a href="${pageContext.request.contextPath}/products"
       class="btn btn-secondary">
      View Store
    </a>

  </div>

</div>

</body>
</html>