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

# Install Maven
RUN apt-get update && apt-get install -y maven \
    && rm -rf /var/lib/apt/lists/*

ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
ENV ANDROID_API_LEVEL android-29
ENV ANDROID_BUILD_TOOLS_VERSION 29.0.2
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_NDK_VERSION 20.0.5594570
ENV ANDROID_VERSION 29
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}/

# Update PATH for Android SDK and NDK
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_NDK_HOME}:${ANDROID_NDK_HOME}/prebuilt/linux-x86_64/bin/

# Install Android SDK
RUN mkdir -p "$ANDROID_HOME" .android && \
    cd "$ANDROID_HOME" && \
    curl -o sdk.zip $ANDROID_SDK_URL && \
    unzip sdk.zip && \
    rm sdk.zip && \
    yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses && \
    $ANDROID_HOME/tools/bin/sdkmanager --update && \
    $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools" \
    "ndk;$ANDROID_NDK_VERSION"

# Set the working directory in the container
WORKDIR /app

# Copy the local project files to the container's workspace
COPY --chown=myuser:myuser . /app

# Copy the JAR file into the container at /app
COPY --chown=myuser:myuser build/libs/F2T-1.0.0.jar /app/F2T.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/F2T.jar"]

# Default command to run on container start
CMD /bin/bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && gradle run"