# Use official Tomcat base image
FROM tomcat:9.0-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR content to Tomcat webapps directory
COPY target/EmployeeTaskManagement /usr/local/tomcat/webapps/ROOT

# Expose default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
