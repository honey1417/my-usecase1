# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Download the JAR from Nexus repo
#this version the docker cont exited so wrote another docker file
ADD http://34.72.222.210:8081/repository/my-usecase1-snapshot/com/example/my-usecase-1-uipage/1.0.0-SNAPSHOT/my-usecase-1-uipage-1.0.0-20250306.100714-1.jar /app/app.jar

# Expose the port your app runs on (if applicable)
EXPOSE 8084

# Run the JAR
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
