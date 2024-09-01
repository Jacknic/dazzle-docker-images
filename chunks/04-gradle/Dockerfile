ARG base
FROM ${base}

ARG GRADLE_VERSION

USER root

# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1

RUN bash -c ". ${HOME}/.sdkman/bin/sdkman-init.sh \
             && sed -i 's/sdkman_selfupdate_enable=true/sdkman_selfupdate_enable=false/g' ${HOME}/.sdkman/etc/config \
             && sed -i 's/sdkman_selfupdate_feature=true/sdkman_selfupdate_feature=false/g' ${HOME}/.sdkman/etc/config \
             && sdk install gradle ${GRADLE_VERSION} \
             && sdk default gradle ${GRADLE_VERSION} \
             && sdk flush archives \
             && sdk flush temp"