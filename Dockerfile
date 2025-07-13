# ---- 1️⃣ Build Stage: Compile WAR from source ----
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy everything from your repo into the build container
COPY . .

# Build the WAR file (skip tests if needed)
RUN mvn clean package -DskipTests

# ---- 2️⃣ Run Stage: Deploy WAR on Tomcat ----
FROM tomcat:9.0
WORKDIR /usr/local/tomcat

# Clear default webapps
RUN rm -rf webapps/*

# Copy your WAR file from build stage and rename to ROOT.war
COPY --from=build /app/target/EmployeeManagementSystem.war webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
