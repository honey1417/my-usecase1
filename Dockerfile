# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Nexus repo details
ARG NEXUS_USER=nexus
ARG NEXUS_PASS=nexus123
ENV NEXUS_REPO_URL=http://34.72.222.210:8081/repository/version-2.0-usecase/
ENV GROUP_ID=com/example/my-usecase-1-uipage
ENV VERSION=2.0.0-SNAPSHOT
ENV JAR_NAME=my-usecase-1-uipage-2.0.0-20250307.091330-1.jar

# Install curl and download the JAR
RUN apt-get update && apt-get install -y curl && \
    curl -u $NEXUS_USER:$NEXUS_PASS -o /app/app.jar $NEXUS_REPO_URL$GROUP_ID/$VERSION/$JAR_NAME && \
    ls -lh /app/app.jar && \
    file /app/app.jar && \
    apt-get remove -y curl && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Expose the port your app runs on
EXPOSE 8084

# Run the JAR
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

