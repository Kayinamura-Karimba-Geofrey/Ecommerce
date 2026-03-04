# Temporary PowerShell script to seed the database
$env:DB_URL="jdbc:postgresql://ep-polished-truth-aixpryt1-pooler.c-4.us-east-1.aws.neon.tech/neondb?user=neondb_owner&password=npg_pSvgJZ6AqRm4&sslmode=require&channelBinding=require
             $env:DB_USERNAME="neondb_owner""
$env:DB_USERNAME="neondb_owner"
$env:DB_PASSWORD="npg_pSvgJZ6AqRm4"

mvn exec:java -Dexec.mainClass="ecommerce.Util.DatabaseSeeder"
