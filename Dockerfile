FROM ubuntu:12.04

MAINTAINER filiplindvist "buggfille@gmail.com"

ENV BUILD_TOOLS_VERSION 23.0.3
ENV ANDROID_SDK 24
ENV ANDROID_SDK_REV 24.4.1

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends openjdk-8-jdk libgd2-xpm ia32-libs ia32-libs-multiarch wget git && \
    apt-get clean

# Download Android SDK
RUN cd /opt && \
    wget -q https://dl.google.com/android/android-sdk_r$ANDROID_SDK_REV-linux.tgz && \
    tar xzf android-sdk_r$ANDROID_SDK_REV-linux.tgz && \
    rm -f android-sdk_r$ANDROID_SDK_REV-linux.tgz

# Install into path Android SDK and download
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo "y" | android update sdk --no-ui --force --all --filter tools,platform-tools,build-tools-$BUILD_TOOLS_VERSION > step1.log
cat step1.log
RUN echo "y" | android update sdk --no-ui --force --all --filter extra-android-m2repository,extra-android-support,extra-google-analytics_sdk_v2,extra-google-google_play_services_froyo,extra-google-google_play_services,extra-google-m2repository > step2.log
cat step2.log
RUN echo "y" | android update sdk --no-ui --force --all --filter android-$ANDROID_SDK,sysimg-$ANDROID_SDK,addon-google_apis-google-$ANDROID_SDK > step3.log
cat step3.log

# Install android sdk
# Setup gradle
# touch local.properties
# echo "sdk.dir=$ANDROID_HOME" >> local.properties
# chmod u+x ./gradlew
