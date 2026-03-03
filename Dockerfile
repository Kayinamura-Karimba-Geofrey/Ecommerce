# Stage 1: Build the Application
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies
# This is done first to utilize Docker layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the rest of the source code and build the WAR file
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the Application with Tomcat
FROM tomcat:10.1-jdk21

# Remove default Tomcat webapps to avoid conflicts and keep container lightweight
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the generated WAR file from the build stage into Tomcat's webapps directory 
# as ROOT.war so it serves at the base URL "/" instead of "/demo1"
COPY --from=build /app/target/demo1-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Create a non-root user for better security in production
RUN useradd -m -U -d /usr/local/tomcat -s /bin/false tomcatuser && \
    chown -R tomcatuser:tomcatuser /usr/local/tomcat

USER tomcatuser

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
