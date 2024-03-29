#!/bin/bash

brew install wget
brew install unzip

printf "Installing Xcode Tools \n"
xcode-select --install

printf "Installing Rust toolchain \n"
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# ask the user wether to use android studio or the command line tools
printf "Do you want to use Android Studio or the command line tools? (yes/no) \n"
read -r answer
# quit the script if the answer is y or yes
if [ "$answer" == "yes" ] || [ "$answer" == "y" ]; then
    printf "Please install Android Studio and follow the android studio guides for setting up the SDK and NDK \n"
    printf "https://next--tauri.netlify.app/next/guides/getting-started/prerequisites/linux#android-studio \n"
    printf "Please make sure to run the post installation script as well - after closing this terminal \n"
    exit 1
fi

printf "Progressing with a standalone installation \n"

printf "Installing OpenJDk \n"
brew install openjdk

printf "Link to system Java wrapper and set the JAVA_HOME environment variable \n"
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"

printf "Download the SDK Manager directly through the Command line tools bundle \n"

wget https://dl.google.com/android/repository/commandlinetools-mac-8512546_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip
mkdir ~/.android/cmdline-tools/
mv cmdline-tools/* ~/.android/cmdline-tools
rm -rf cmdline-tools

printf "Set the ANDROID_HOME and NDK_HOME environment variables \n"
export ANDROID_HOME="$HOME/.android/cmdline-tools/bin"
export NDK_HOME="$ANDROID_HOME/ndk/25.0.8775105"

printf "Install required SDK and NDK components \n"
~/.android/cmdline-tools/bin/sdkmanager "platforms;android-33" "platform-tools" "ndk;25.0.8775105" "build-tools;33.0.0"

printf "Please restart the terminal and then run the post_installation.sh script to finish the setup \n"
