# Use OpenJDK 17 Debian-based as the base image
FROM openjdk:17-bullseye

# Install the required packages, including SDKMAN, Kotlin, Gradle, and Maven
RUN apt-get update && apt-get install -y curl unzip zip maven \
    && curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin && sdk install gradle" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the user for Docker to not run as root (optional, recommended)
# Ensure the user has appropriate permissions for the working directory
RUN adduser --disabled-password --gecos '' myuser
USER myuser

# Set the working directory in the container
WORKDIR /app

# Copy the local project files to the container's workspace
COPY --chown=myuser:myuser . /app

# Copy the JAR file into the container at /app
COPY --chown=myuser:myuser build/libs/FlexNet-1.0.0.jar /app/FlexNet.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/FlexNet.jar"]
