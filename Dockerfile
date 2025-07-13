# Use official Tomcat image
FROM tomcat:9.0

# Remove default apps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your JSPs, HTML, CSS, JS
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Copy compiled servlet class files (You must pre-compile before deploying OR compile inside Docker)
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Copy web.xml if you use one
COPY WebContent/WEB-INF/web.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/

# Set proper permissions (optional)
RUN chmod -R 755 /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
