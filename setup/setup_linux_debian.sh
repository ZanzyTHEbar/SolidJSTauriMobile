printf "Setting up Linux Debian\n" 

sudo apt update

printf "Installing dependancies \n" 
sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev

printf "Installing Rust \n"
# https://sh.rustup.rs/
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

printf "Android \n"

#ask the user

# ask the user wether to use android studio or the command line tools
printf "Do you want to use Android Studio or the command line tools? (a/c) \n"
read -r answer
# quit the script if the answer is a
if [ "$answer" = "a" ]; then
    printf "Please install Android Studio and follow the android studio guides for setting up the SDK and NDK \n"
    printf "https://next--tauri.netlify.app/next/guides/getting-started/prerequisites/linux#android-studio \n"
    printf "Please make sure to run the post installation script as well - after closing this terminal \n"
    exit 1
fi

printf "Progressing with a standalone installation \n"

printf "Installing OpenJDK"

sudo apt update
sudo apt install default-jdk

printf "Setting JAVA_HOME environment variable \n"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

printf "Installing Android SDK & NDK \n"

sudo apt install wget unzip

wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip
mkdir ~/.android/cmdline-tools/latest
mv cmdline-tools/* ~/.android/cmdline-tools/latest
rm cmdline-tools

printf "Setting ANDROID_HOME and NDK_HOME environment variables \n"

export ANDROID_HOME="$HOME/.android/cmdline-tools/latest/bin"
export NDK_HOME="$ANDROID_HOME/ndk/25.0.8775105"

printf "Installing required SDK and NDK components \n"

~/.android/cmdline-tools/latest/bin/sdkmanager "platforms;android-33" "platform-tools" "ndk;25.0.8775105" "build-tools;33.0.0"

printf "Checking the Rust toolchain \n"

rustup update
rustc --version

printf "Please restart the terminal and then run the post_installation.sh script to finish the setup \n"

# Path: setup\setup_linux_debian.sh