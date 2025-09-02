# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Add a volume to store logs
VOLUME /tmp

# Copy the packaged jar file into the container
COPY target/*.jar app.war

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","/app.jar"]

