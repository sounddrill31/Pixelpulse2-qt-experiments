#!/usr/bin/bash
# Assume ubuntu
sudo apt update

# Pre Migration
sudo apt install -y qt5-default || true
sudo apt install -y qt5ct dos2unix || true
sudo apt install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools || true # Suppress errors
sudo apt install -y libgl1-mesa-dri xvfb libudev-dev libusb-1.0-0-dev libboost-all-dev libfuse2 fuse3 #qtwayland5 
sudo apt install -y qttools5-dev qtdeclarative5-dev libqt5svg5-dev libqt5opengl5-dev cmake
sudo apt install -y qml-module-qtquick2 qml-module-qtquick-extras qml-module-qtquick-window2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtgraphicaleffects  qml-module-qtquick-dialogs
sudo apt install -y qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel qml-module-qtqml-models2

# Post Migration
sudo apt install -y qt6-base-dev qml6-module-qtquick qt6-declarative-dev mesa-common-dev libfontconfig1  libglu1-mesa-dev libgl1-mesa-dev libglx-dev libqt6shadertools6-dev || true
sudo apt install -y qml6-module-qtquick-controls qml6-module-qtquick-layouts qml6-module-qtquick-window qml6-module-qtquick-templates || true
sudo apt install -y qml-module-qtquick-controls-styles qml6-module-qtquick-controls-styles || true