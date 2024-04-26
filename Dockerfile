# Use OpenJDK 17 Debian-based as the base image
FROM openjdk:17-bullseye

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y curl unzip zip maven apt-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ${ANDROID_HOME}/cmdline-tools/latest/bin/

# Create Android SDK directory
RUN  mkdir -p "$ANDROID_HOME/.android" && \
     cd "$ANDROID_HOME" && \
     curl -o sdk.zip $ANDROID_SDK_URL && \
     unzip sdk.zip && \
     rm sdk.zip && \

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y curl unzip zip maven apt-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variable for Android SDK home and related variables
ENV ANDROID_HOME=/usr/local/android-sdk-linux \
    COMMANDLINE_TOOLS_VERSION=7302050 \
    ANDROID_BUILD_TOOLS_VERSION=29.0.2 \
    ANDROID_VERSION=29 \
    ANDROID_NDK_VERSION=20.0.5594570 \
    PATH=${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}/:${PATH}

# Download and install Android command-line tools
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools/latest && \
    curl -o cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-${COMMANDLINE_TOOLS_VERSION}_latest.zip" && \
    unzip cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    rm cmdline-tools.zip && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest && \
    if [ ! -f ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager ]; then echo "sdkmanager not found."; exit 1; fi && \
    yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --update && \
    ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_VERSION}" "platform-tools" "ndk;${ANDROID_NDK_VERSION}"

# Install SDKMAN, Kotlin, and Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin && sdk install gradle"

# Add a non-root user and switch to it
RUN adduser --disabled-password --gecos '' myuser
USER myuser

# Set the working directory
WORKDIR /app

# Copy your project files into the Docker container
COPY --chown=myuser:myuser . /app

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/Dapp-1.0.0.jar"]
