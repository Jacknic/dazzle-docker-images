ARG base

FROM eclipse-temurin:17-jdk-alpine AS builder
USER root
ENV HOME="/root"
ENV TRIGGER_REBUILD=1

# Install Android SDK Tools
ENV ANDROID_HOME "${HOME}/.android-sdk"
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV CMDLINE_TOOLS_ROOT "${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH "${ANDROID_HOME}/emulator:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/platform-tools/bin:${PATH}"
# You can find the latest command line tools here: https://developer.android.com/studio#command-line-tools-only
RUN SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip" && \
    mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    mkdir ${ANDROID_HOME}/platforms && \
    mkdir ${ANDROID_HOME}/ndk && \
    wget -O /tmp/cmdline-tools.zip -t 5 "${SDK_TOOLS_URL}" && \
    unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    rm /tmp/cmdline-tools.zip && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest

COPY sdk_packages_list.txt sdk_packages.txt
RUN echo y | sdkmanager --package_file=sdk_packages.txt && \
    echo y | sdkmanager "extras;android;m2repository" \
    "extras;google;m2repository"



FROM ${base} AS android
USER root
# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1
ENV ANDROID_HOME "${HOME}/.android-sdk"
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV PATH "${ANDROID_HOME}/emulator:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/platform-tools/bin:${PATH}"
COPY --from=builder ${ANDROID_HOME} ${ANDROID_HOME}