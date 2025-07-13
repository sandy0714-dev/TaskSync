# Use Tomcat base image
FROM tomcat:9.0

# Clean default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your webapp files to ROOT
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Expose default port
EXPOSE 8080
