# to pull the latest jar file from nexus repo
# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Nexus repo details
ARG NEXUS_USER
ARG NEXUS_PASS
ENV NEXUS_REPO_URL=http://34.72.222.210:8081/repository/my-usecase1-snapshot/
ENV GROUP_ID=com/example/my-usecase-1-uipage
ENV ARTIFACT_ID=my-usecase-1-uipage
ENV VERSION=1.0.0-SNAPSHOT

# Get the latest JAR filename from maven-metadata.xml
RUN apt-get update && apt-get install -y curl jq && \
    LATEST_JAR=$(curl -u $NEXUS_USER:$NEXUS_PASS -s $NEXUS_REPO_URL$GROUP_ID/$VERSION/maven-metadata.xml | \
    grep '<value>' | tail -1 | sed -E 's|.*<value>(.*)</value>.*|\\1|') && \
    curl -u $NEXUS_USER:$NEXUS_PASS -o /app/app.jar $NEXUS_REPO_URL$GROUP_ID/$VERSION/$LATEST_JAR

# Expose the port your app runs on
EXPOSE 8084

# CMD ["sh", "-c", "while true; do java -jar /app/app.jar; sleep 5; done"]


# Run the JAR
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
