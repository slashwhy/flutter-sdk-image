FROM mobiledevops/android-sdk-image:34.0.0-jdk17

ENV FLUTTER_VERSION="3.32.1"
ENV FLUTTER_HOME "/home/mobiledevops/.flutter-sdk"
ENV PUB_CACHE "/home/mobiledevops/.pub-cache"

ENV PATH $PATH:$FLUTTER_HOME/bin
ENV PATH $PATH:$PUB_CACHE/bin

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

RUN flutter precache
