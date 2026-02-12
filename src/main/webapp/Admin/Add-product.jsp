<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px;
        }

        .form-container {
            max-width: 500px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 12px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        textarea {
            resize: vertical;
            height: 80px;
        }

        .btn {
            margin-top: 20px;
            padding: 10px;
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
        }

        .btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Product</h2>

    <form action="../products?action=add" method="post">

        <label>Product Name</label>
        <input type="text" name="name" required>

        <label>Description</label>
        <textarea name="description" required></textarea>

        <label>Price</label>
        <input type="number" name="price" step="0.01" required>

        <label>Stock</label>
        <input type="number" name="stock" required>

        <label>Image URL</label>
        <input type="text" name="imageUrl" required>

        <label>Category</label>
        <input type="text" name="category" required>

        <button type="submit" class="btn">Add Product</button>

    </form>
</div>

</body>
</html>
