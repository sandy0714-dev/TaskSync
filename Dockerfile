# 1️⃣ Build stage: use Maven to generate WAR file
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy all project files
COPY . .

# Run Maven to build WAR file
RUN mvn clean package -DskipTests

# 2️⃣ Deploy stage: use Tomcat to serve WAR
FROM tomcat:9.0
WORKDIR /usr/local/tomcat

# Remove default webapps
RUN rm -rf webapps/*

# Copy built WAR from build stage
COPY --from=build /app/target/EmployeeManagementSystem.war webapps/ROOT.war

# Expose HTTP port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
