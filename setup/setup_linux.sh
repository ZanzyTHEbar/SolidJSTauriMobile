#!/bin/bash

printf "This Script will setup the tauri dev environment\n"

# check if the user is running as root
if [ "$EUID" -ne 0 ]; then
  printf "Please run as root\n"
  exit 1
fi

# get user input and store in variable

printf "Do you want to install the Linux Development Dependencies? (y/n)\n"
read -r input

# check if the user input is y or n

if [ "$input" == "y" ]; then
  printf "Installing Linux Development Dependencies\n"
else
  printf "Not installing Linux Development Dependencies\n"
fi

# Get their distro

printf "Which distro are you running? (ubuntu/arch/fedora/gentoo/opensuse/void)\n"

read -r distro

# convert distro to lowercase

distro=${distro,,}

# check if the distro is Ubuntu or arch or fedora or gentoo or openSUSE or NixOS or GNU GUIX or void

if [ "$distro" == "ubuntu" ] || [ "$distro" == "arch" ] || [ "$distro" == "fedora" ] || [ "$distro" == "gentoo" ] || [ "$distro" == "opensuse" ] || [ "$distro" == "void" ]; then
  printf "Distro is $distro\n"
else
  printf "Distro is not supported\n"
  printf "NixOS and GNU GUIX are not supported by this script, but are supported by tauri - please see the tauri docs for more information.\n"
  exit 1
fi

# Install Linux Development Dependencies
# run specific commands based on the distro
case $distro in
"ubuntu")
  printf "Installing Ubuntu Development Dependencies\n"
  sudo apt update
  sudo apt install libwebkit2gtk-4.0-dev build-essential curl wget libssl-dev libgtk-3-dev libayatana-appindicator3-dev librsvg2-dev
  ;;
"arch")
  printf "Installing Arch Development Dependencies\n"
  sudo pacman -Syu
  sudo pacman -S --needed webkit2gtk base-devel curl wget openssl appmenu-gtk-module gtk3 libappindicator-gtk3 librsvg libvips
  ;;
"fedora")
  printf "Installing Fedora Development Dependencies\n"
  sudo dnf check-update
  sudo dnf install webkit2gtk4.0-devel openssl-devel curl wget libappindicator-gtk3 librsvg2-devel
  sudo dnf group install "C Development Tools and Libraries"
  ;;
"gentoo")
  printf "Installing Gentoo Development Dependencies\n"
  sudo emerge --ask net-libs/webkit-gtk:4 dev-libs/libappindicator net-misc/curl net-misc/wget
  ;;
"opensuse")
  printf "Installing openSUSE Development Dependencies\n"
  sudo zypper up
  sudo zypper in webkit2gtk3-soup2-devel libopenssl-devel curl wget libappindicator3-1 librsvg-devel
  sudo zypper in -t pattern devel_basis
  ;;
"void")
  printf "Installing Void Development Dependencies\n"
  sudo xbps-install -Syu
  sudo xbps-install -S webkit2gtk curl wget openssl gtk+3 libappindicator librsvg gcc pkg-config
  ;;
esac
# Install Rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
# All done!
printf "All done!\n"

printf "Android \n"

#ask the user

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
