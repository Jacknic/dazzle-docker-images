ARG base
FROM ${base} AS builder

ARG JAVA_VERSION=17.0.12.fx-zulu

USER root

RUN bash -c ". ${HOME}/.sdkman/bin/sdkman-init.sh \
    && sed -i 's/sdkman_selfupdate_enable=true/sdkman_selfupdate_enable=false/g' ${HOME}/.sdkman/etc/config \
    && sed -i 's/sdkman_selfupdate_feature=true/sdkman_selfupdate_feature=false/g' ${HOME}/.sdkman/etc/config \
    && sdk install java ${JAVA_VERSION} \
    && sdk default java ${JAVA_VERSION} \
    && sdk flush archives \
    && sdk flush temp \
    && echo 'export SDKMAN_DIR=\"${HOME}/.sdkman\"' >> ${HOME}/.bashrc.d/99-java \
    && echo '[[ -s \"${HOME}/.sdkman/bin/sdkman-init.sh\" ]] && source \"${HOME}/.sdkman/bin/sdkman-init.sh\"' >> ${HOME}/.bashrc.d/99-java"

ENV JAVA_HOME="${HOME}/.sdkman/candidates/java/${JAVA_VERSION}"

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

ARG PACKAGES_FILENAME="android-sdks.txt"
COPY sdk_packages_list.txt $PACKAGES_FILENAME
RUN echo y | sdkmanager --package_file=$PACKAGES_FILENAME

FROM ${base} AS android
USER root
# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1
ENV ANDROID_HOME "${HOME}/.android-sdk"
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV PATH "${ANDROID_HOME}/emulator:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/platform-tools/bin:${PATH}"
COPY --from=builder ${ANDROID_HOME} ${ANDROID_HOME}