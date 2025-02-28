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
- [@Samueru-sama](https://github.com/samueru-sama) for porting my LinuxDeployQt AppImage to sharun and ensuring Qt worked
- [Me](https://sounddrill31.github.io/) for initial x86_64 build using LinuxDeploy and eventual aarch64 port 
- [@VHSgunzo](https://vhsgunzo.github.io/) for [sharun](https://github.com/VHSgunzo/sharun) and more
- [AppImage](https://github.com/AppImage) and [contributors](https://github.com/AppImage/appimagetool/graphs/contributors) for [appimagetool](https://github.com/AppImage/appimagetool) and work on the AppImage format
- [@ivan-hc](https://github.com/ivan-hc) for [AM](https://github.com/ivan-hc/AM)
- [@TheAssassin](https://assassinate-you.net) for [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy)
- [@probonopd](https://github.com/probonopd) for [linuxdeployqt](https://github.com/probonopd/linuxdeployqt)

### Setup Instructions
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

> [!TIP]
> To Install it systemwide, [install a tool called appman through AM](https://github.com/ivan-hc/AM) and run `appman install path/to/Pixelpulse2*.AppImage`

### Known Issues:
1. The app is known to crash after being open for some time
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
