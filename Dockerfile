# Use official Tomcat base image
FROM tomcat:9.0-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your compiled WAR or JSP folder into Tomcat webapps
COPY target/EmployeeTaskManagement.war /usr/local/tomcat/webapps/


# Expose port 8080
EXPOSE 8080
