<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">

  <style>
    body {
      overflow-x: hidden;
    }

    .sidebar {
      height: 100vh;
      background-color: #212529;
    }

    .sidebar a {
      color: #adb5bd;
      text-decoration: none;
      display: block;
      padding: 12px 20px;
    }

    .sidebar a:hover {
      background-color: #343a40;
      color: white;
    }

    .card-hover:hover {
      transform: translateY(-5px);
      transition: 0.3s;
    }
  </style>
</head>

<body class="bg-light">

<div class="container-fluid">
  <div class="row">

    <!-- Sidebar -->
    <div class="col-md-2 sidebar p-0">
      <h4 class="text-white text-center py-4 border-bottom">
        Admin Panel
      </h4>

      <a href="dashboard">📊 Dashboard</a>
      <a href="add-product.jsp">➕ Add Product</a>
      <a href="products">📦 Manage Products</a>
      <a href="manage-orders">🛒 Orders</a>
      <a href="users">👥 Users</a>
      <a href="logout">🚪 Logout</a>
    </div>

    <!-- Main Content -->
    <div class="col-md-10 p-4">

      <!-- Top Navbar -->
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Dashboard Overview</h3>
        <span class="badge bg-dark">
                    Welcome, Admin
                </span>
      </div>

      <!-- Stats Cards -->
      <div class="row g-4">

        <!-- Users -->
        <div class="col-md-3">
          <div class="card shadow border-primary text-center card-hover">
            <div class="card-body">
              <h6>Total Users</h6>
              <h2 class="text-primary">${totalUsers}</h2>
            </div>
          </div>
        </div>
        <!-- Sales Chart -->
        <div class="row mt-5">
          <div class="col-md-12">
            <div class="card shadow">
              <div class="card-body">
                <h5 class="mb-4">Monthly Sales Overview</h5>
                <canvas id="salesChart" height="100"></canvas>
              </div>
            </div>
          </div>
        </div>

        <!-- Products -->
        <div class="col-md-3">
          <div class="card shadow border-success text-center card-hover">
            <div class="card-body">
              <h6>Total Products</h6>
              <h2 class="text-success">${totalProducts}</h2>
            </div>
          </div>
        </div>

        <!-- Orders -->
        <div class="col-md-3">
          <div class="card shadow border-warning text-center card-hover">
            <div class="card-body">
              <h6>Total Orders</h6>
              <h2 class="text-warning">${totalOrders}</h2>
            </div>
          </div>
        </div>

        <!-- Revenue -->
        <div class="col-md-3">
          <div class="card shadow border-danger text-center card-hover">
            <div class="card-body">
              <h6>Total Revenue</h6>
              <h2 class="text-danger">$${totalRevenue}</h2>
            </div>
          </div>
        </div>

      </div>

      <!-- Quick Actions -->
      <div class="mt-5">
        <h5 class="mb-3">Quick Actions</h5>

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

    </div>

  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
  const ctx = document.getElementById('salesChart').getContext('2d');

  const salesChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: [${salesLabels}],
      datasets: [{
        label: 'Revenue ($)',
        data: [${salesData}],
        backgroundColor: 'rgba(54, 162, 235, 0.6)',
        borderRadius: 5
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          display: true
        }
      },
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>

</body>
</html>