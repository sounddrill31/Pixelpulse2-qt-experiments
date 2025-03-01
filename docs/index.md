---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "PixelPulse2 Linux AppImage"
  tagline: Set up Pixelpulse2 in minutes! No need to fumble with dependencies before class
  actions:
    - theme: brand
      text: App Screenshots
      link: /screenshots
    - theme: Installation Guide
      text: Quick Fixes
      link: /debug

  #  - theme: Installation Guide
  #    text: Markdown Examples
  #    link: /markdown-examples
  #  - theme: alt
  #    text: API Examples
  #    link: /api-examples

features:
  - title: Download For x86_64
    icon: <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#6a5acd"><path d="M480-320 280-520l56-58 104 104v-326h80v326l104-104 56 58-200 200ZM240-160q-33 0-56.5-23.5T160-240v-120h80v120h480v-120h80v120q0 33-23.5 56.5T720-160H240Z"/></svg>
    link: https://github.com/sounddrill31/Pixelpulse2/releases/latest/download/Pixelpulse2-test-anylinux-x86_64.AppImage
  - title: Download For aarch64
    icon: <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#6a5acd"><path d="M480-320 280-520l56-58 104 104v-326h80v326l104-104 56 58-200 200ZM240-160q-33 0-56.5-23.5T160-240v-120h80v120h480v-120h80v120q0 33-23.5 56.5T720-160H240Z"/></svg>
    link: https://github.com/sounddrill31/Pixelpulse2/releases/latest/download/Pixelpulse2-test-anylinux-aarch64.AppImage
---

### Credits and Greetings
- [Analog Devices Inc](https://www.analog.com) for [Software](https://github.com/analogdevicesinc/pixelpulse2) and [Board](https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/adalm1000.html)
- [@Samueru-sama](https://github.com/samueru-sama) for porting my LinuxDeployQt AppImage to sharun, helping me with udev shenanigans and ensuring Qt worked
- [QaidVoid](https://github.com/QaidVoid) for SoarPkgs and Soar
- [@Azathothas](https://github.com/Azathothas) for onboarding me as a maintainer onto SoarPkgs and helping me where I got stuck
- [@VHSgunzo](https://vhsgunzo.github.io/) for [sharun](https://github.com/VHSgunzo/sharun) and more
- [Me](https://sounddrill31.github.io/) for initial x86_64 build using LinuxDeploy and eventual aarch64 port
- [AppImage](https://github.com/AppImage) and [contributors](https://github.com/AppImage/appimagetool/graphs/contributors) for [appimagetool](https://github.com/AppImage/appimagetool) and work on the AppImage format
- [@ivan-hc](https://github.com/ivan-hc) for [AM](https://github.com/ivan-hc/AM)
- [@TheAssassin](https://assassinate-you.net) for [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy)
- [@probonopd](https://github.com/probonopd) for [linuxdeployqt](https://github.com/probonopd/linuxdeployqt)

### Setup Instructions

> [!TIP]
> I maintain the SoarPkgs entry for Pixelpulse2!
> This means that running Pixelpulse2 will be a breeze for linux users. See [SBUILD configuration](https://github.com/pkgforge/soarpkgs/blob/main/packages/pixelpulse2/appimage.sounddrill31.stable.yaml) and [SoarPkgs page](https://pkgs.pkgforge.dev/repo/soarpkgs/sounddrill31-pixelpulse2/pixelpulse2/pixelpulse2/)

#### Automatic Method 😎
- [Install Soar](https://soar.qaidvoid.dev/installation)
  ```bash
  wget -qO- https://soar.qaidvoid.dev/install.sh | sh
  ```
  or
  ```bash
  curl -fsSL https://soar.qaidvoid.dev/install.sh | sh
  ```
  - Run the App without installing
    ```bash
    soar run pixelpulse2 -- --getudev
    ```
> [!WARNING]
> Remember to connect your Adalm1000 Board only after the app opens for the first time and udev rules are installed.
  - Install the App
    ```bash
    soar install pixelpulse2
    ```
  - Run the App <!-- Also need to explain adding the bin folder to path -->
    ```bash
    pixelpulse2 --getudev
    ```
> [!NOTE]
> The getudev flag tells it to generate and install udev rules into your OS, so that your Adalm1000 is detected without problems. It is recommended to run it with that the first time you open it.

#### Manual Method 💪
::::: details Show Manual Installation Method
- Remove Previous versions of the AppImage(Optional, replace with correct path as needed)
  ```bash
  rm Downloads/Pixelpulse2*.AppImage
  ```
- Download the version compatible with your system from above
- Go to the folder you saved it to(replace with correct path)
  ```bash
  cd Downloads
  ```
- Give it executable permissions
  ```bash
  chmod +x Pixelpulse2*.AppImage
  ```
- Run the AppImage
  ```bash
  ./Pixelpulse2*.AppImage --getudev
  ```
  - The getudev flag tells it to generate and install udev rules into your OS, so that your Adalm1000 is detected without problems. It is recommended to run it with that the first time you open it.

:::: details If you're debugging udev rules and crashes upon device plug, see this
Delete Existing rule
```bash
sudo rm -rf /etc/udev/rules.d/53-adi-m1k-usb.rules
```

> [!WARNING]
> Remember to unplug your device.

Run the AppImage with --getudev flag again
```bash
./Pixelpulse2*.AppImage --getudev
```

After it opens, you can reconnect your device.
::::
:::::
### Known Issues:
1. The app is known to crash if you plug in the device without configuring udev rules
   - Do that, and ensure the device is unplugged.
   - reload 
2. The app is known to crash after being open for some time
  - This can be replicated on some distros by connecting a device and letting it run for a while
    - This happens on:
      - OpenSUSE Tumbleweed(Jan 2025, x86_64 build)
      - Fedora(Testimony by @vishal-ahirwar [(issues/266)](https://github.com/analogdevicesinc/Pixelpulse2/issues/266#issuecomment-2563701732))
      
  - This is likely not an issue caused by my packaging
  - There is an issue opened upstream [(issues/266)](https://github.com/analogdevicesinc/Pixelpulse2/issues/266) that tracks this problem

### Notes:
Tested on:
- OpenSUSE tumbleweed on Jan 2025(x86_64 build)

Old Versions(not recommended):
- [Stable LinuxDeployQt x86_64 Build](https://github.com/sounddrill31/Pixelpulse2/releases/download/12639488881/Pixelpulse2-1.0-x86_64.AppImage)
