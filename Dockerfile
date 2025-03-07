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

# Install necessary packages and fetch the latest JAR
RUN apt-get update && apt-get install -y curl xmlstarlet && \
    METADATA_URL=${NEXUS_REPO_URL}${GROUP_ID}/${ARTIFACT_ID}/${VERSION}/maven-metadata.xml && \
    LATEST_VERSION=$(curl -u $NEXUS_USER:$NEXUS_PASS -s $METADATA_URL | \
    xmlstarlet sel -t -v "//latest" | tail -1) && \
    JAR_NAME=${ARTIFACT_ID}-${LATEST_VERSION}.jar && \
    curl -u $NEXUS_USER:$NEXUS_PASS -o /app/app.jar ${NEXUS_REPO_URL}${GROUP_ID}/${ARTIFACT_ID}/${VERSION}/${JAR_NAME} && \
    apt-get remove -y curl xmlstarlet && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Expose the port your app runs on
EXPOSE 8084

# Run the JAR
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
