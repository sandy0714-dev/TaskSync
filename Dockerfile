# Use Tomcat base image
FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR build (we’ll generate this in the next step) into Tomcat
COPY target/EmployeeTaskManagement.war /usr/local/tomcat/webapps/ROOT.war

# Expose port (Render uses 8080 by default)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
