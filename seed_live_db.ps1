# Temporary PowerShell script to seed the database
$env:DB_URL="jdbc:postgresql://ep-silent-bird-a25h200o.eu-central-1.aws.neon.tech/neondb?sslmode=require"
$env:DB_USERNAME="neondb_owner"
$env:DB_PASSWORD="your_neon_password"

mvn exec:java -Dexec.mainClass="ecommerce.Util.DatabaseSeeder"
