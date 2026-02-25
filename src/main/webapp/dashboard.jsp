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

  <h2 class="mb-4">Admin Dashboard</h2>

  <div class="row g-4">

    <!-- Users -->
    <div class="col-md-3">
      <div class="card shadow text-center border-primary">
        <div class="card-body">
          <h5>Total Users</h5>
          <h3 class="text-primary">
            ${totalUsers}
          </h3>
        </div>
      </div>
    </div>

    <!-- Products -->
    <div class="col-md-3">
      <div class="card shadow text-center border-success">
        <div class="card-body">
          <h5>Total Products</h5>
          <h3 class="text-success">
            ${totalProducts}
          </h3>
        </div>
      </div>
    </div>

    <!-- Orders -->
    <div class="col-md-3">
      <div class="card shadow text-center border-warning">
        <div class="card-body">
          <h5>Total Orders</h5>
          <h3 class="text-warning">
            ${totalOrders}
          </h3>
        </div>
      </div>
    </div>

    <!-- Revenue -->
    <div class="col-md-3">
      <div class="card shadow text-center border-danger">
        <div class="card-body">
          <h5>Total Revenue</h5>
          <h3 class="text-danger">
            $${totalRevenue}
          </h3>
        </div>
      </div>
    </div>

  </div>

  <hr class="my-5">

  <div class="d-flex gap-3">

    <a href="add-product.jsp"
       class="btn btn-primary">
      Add Product
    </a>

    <a href="manage-orders"
       class="btn btn-warning">
      Manage Orders
    </a>

    <a href="../products"
       class="btn btn-secondary">
      View Store
    </a>

  </div>

</div>

</body>
</html>