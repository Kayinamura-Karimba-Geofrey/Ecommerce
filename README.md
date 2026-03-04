# Premium E-Commerce Platform

A robust, full-stack Java web application built for modern e-commerce. This project features a responsive, glassmorphism-inspired UI, comprehensive admin dashboards, secure user authentication, and seamless product management.

## 🌟 Key Features

### User Experience
- **Modern UI/UX:** Responsive design with glassmorphism effects, dynamic CSS grids, and smooth animations.
- **Product Catalog:** Browse products with advanced filtering (category, price range) and sorting.
- **Shopping Cart & Checkout:** Seamless cart management and order placement.
- **User Accounts:** Secure registration, login (with TOTP 2FA), password recovery, and profile management.
- **Dynamic Content:** Featured products, newsletter subscriptions, and real-time stock indicators.

### Admin Capabilities
- **Comprehensive Dashboard:** View platform analytics, revenue, and recent orders.
- **Product Management:** Full CRUD operations for products, including Cloudinary image uploads.
- **Category & User Management:** Organize store categories and manage user roles/access.
- **Order Tracking:** Monitor and update customer order statuses.

### Security
- **Authentication:** Secure session management with BCrypt password hashing.
- **Two-Factor Authentication:** Optional TOTP-based 2FA for enhanced account security.
- **Protection:** CSRF tokens, secure filters, and ReCaptcha integration.

## 🛠️ Tech Stack

- **Backend:** Java 21, Jakarta EE (Servlets, JSP, JSTL)
- **Database:** PostgreSQL with Hibernate ORM (JPA)
- **Frontend:** HTML5, modern CSS3 (Variables, CSS Grid/Flexbox), JavaScript
- **Deployment:** Docker (Tomcat 10.1 Multi-stage build), designed for Render/Railway

## 🚀 Getting Started (Local Development)

### Prerequisites
- Java 21+
- Maven 3.9+
- PostgreSQL 15+

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Kayinamura-Karimba-Geofrey/Ecommerce.git
   cd Ecommerce
   ```

2. **Configure the Database:**
   - Create a local PostgreSQL database.
   - Update `hibernate.cfg.xml` (or your environment variables) with your local database credentials (`DB_URL`, `DB_USERNAME`, `DB_PASSWORD`).

3. **Configure Third-Party Services:**
   - Set up your Cloudinary credentials via the `CLOUDINARY_URL` environment variable for image uploads to work properly.

4. **Build and Run:**
   ```bash
   mvn clean install
   mvn exec:java -Dexec.mainClass="ecommerce.Util.DatabaseSeeder" # Optional: seed default data
   ```
   *Note: To run locally, deploy the generated `.war` file in `target/` to a local Tomcat 10+ server.*

## 🐳 Docker Production Deployment

This project includes a production-ready `Dockerfile` optimized for free cloud hosts like Render or Koyeb.

1. Connect your repository to your cloud provider.
2. The `Dockerfile` handles a multi-stage build: compiling the app via Maven and deploying it into a lightweight `tomcat:10.1-jdk21` container.
3. Ensure the following Environment Variables are injected into your host:
   - `DB_URL` (e.g., `jdbc:postgresql://<host>:5432/<dbname>`)
   - `DB_USERNAME`
   - `DB_PASSWORD`
   - `CLOUDINARY_URL`

---
*Built by Geofrey Kayinamura*
