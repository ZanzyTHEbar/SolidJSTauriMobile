#!/bin/bash

brew install wget
brew install unzip

printf "Installing Xcode Tools"
xcode-select --install

printf "Installing Rust toolchain"
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

printf "Installing OpenJDk"
brew install openjdk

printf "Link to system Java wrapper and set the JAVA_HOME environment variable"
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"

printf "Download the SDK Manager directly through the Command line tools bundle"

wget https://dl.google.com/android/repository/commandlinetools-mac-8512546_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip
mkdir ~/.android/cmdline-tools/
mv cmdline-tools/* ~/.android/cmdline-tools
rm -rf cmdline-tools

printf "Set the ANDROID_HOME and NDK_HOME environment variables"
export ANDROID_HOME="$HOME/.android/cmdline-tools/bin"
export NDK_HOME="$ANDROID_HOME/ndk/25.0.8775105"

printf "Install required SDK and NDK components"
~/.android/cmdline-tools/bin/sdkmanager "platforms;android-33" "platform-tools" "ndk;25.0.8775105" "build-tools;33.0.0"

printf "Manging the Rust toolchain"
rustup update
rustc --version

rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android