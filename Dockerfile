FROM tomcat:9.0-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your war into Tomcat webapps as ROOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

