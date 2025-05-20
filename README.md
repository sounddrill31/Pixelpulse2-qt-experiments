## Pixelpulse2

[![Linux CI](https://github.com/pkgforge-dev/Pixelpulse2-AppImage/actions/workflows/main.yml/badge.svg)](https://github.com/sounddrill31/Pixelpulse2/actions/workflows/main.yml)
[![License](https://img.shields.io/badge/license-MPL-blue.svg)](https://github.com/sounddrill31/Pixelpulse2/blob/master/LICENSE)

Pixelpulse is a powerful user interface for visualizing and manipulating signals while exploring systems attached to affordable analog interface devices, such as Analog Devices' ADALM1000.

Fully cross-platform using the Qt6 graphics toolkit and OpenGL accelerated density-gradiated rendering, it provides a powerful and accessible tool for initial interactive explorations.

Intuitive click-and-drag interfaces make exploring system behaviors across a wide range of signal amplitudes, frequencies, or phases a trivial exercise. Just click once to source a constant voltage or current and see what happens. Choose a function (sawtooth, triangle, sinusoidal, square) - adjust parameters, and make waves.

Zoom in and out  with your scroll wheel or multitouch gestures (on supported platforms). Hold "Shift" to for Y-axis zooming.

Click and drag the X axis to pan in time.

### Screenshot

![Screenshot of PP2 on Windows 7](https://analogdevicesinc.github.io/Pixelpulse2/pp2screenshot.png "Pixelpulse on Windows 7")

### Getting Pixelpulse2

#### Easy

* OSX - Navigate to the [releases](https://github.com/sounddrill31/Pixelpulse2/releases) and collect the latest `pixelpulse2-<OS-version>.dmg` package, specific for you OS version.
* Windows - For a testing build, download the dependency package and the latest binary build from [appveyor](https://ci.appveyor.com/project/sounddrill31/Pixelpulse2/build/artifacts). For an official release build, navigate to releases and collect the latest pixelpulse2-setup.exe.
* Linux - Follow the instructions at https://sounddrill31.github.io/Pixelpulse2 for easy, step by step instructions. 
#### Advanced

To build from source on any platform, you need to install a C++ compiler toolchain, collect the build dependencies, setup your build environment, and compile the project.

If you have not built packages from source before, this is ill-advised.
*  **Build and install libsmu (https://github.com/sounddrill31/libsmu)**. 
Libsmu is a library wich contains abstractions for streaming data to and from USB-connected analog interface devices, currently supporting the Analog Devices' ADALM1000. 
* Install Qt6. We recommend using a version greater than or equal to 5.14.
 * On most Linux Distributions, Qt6 is available in repositories. The complete list of packages required varies, but includes qt's support for declarative (qml) UI programming, qtquick, qtquick-window, qtquick-controls, and qtquick-layouts.

To build / run on a generic POSIX platform

    git clone https://github.com/sounddrill31/Pixelpulse2
    cd Pixelpulse2
    mkdir build
    cd build
    cmake ..
    make

Linux Build Scripts:

> [!WARNING]
> This may not be up to date and may break frequently. 

For a reasonably recent Ubuntu version, please use our scripts here:
1. Install Dependencies:
```bash
bash CI/install-deps.sh
```
2. Build and Install libsmu:
```bash
bash CI/prepare-build-libsmu.sh
``` 
3. Build and Install Pixelpulse2: 
```bash
bash CI/build.sh
```


On Windows the process is similar. Write the following commands in a cmd console

	git clone https://github.com/sounddrill31/Pixelpulse2
	cd Pixelpulse2
	mkdir build
	cd build
    cmake -DLIBSMU_LIBRARY="path_to_libsmu_dll" -DLIBSMU_INCLUDE_PATH="path_to_libsmu_include_folder" -DLIBUSB_INCLUDE_DIRS="path_to_libusb_include_folder" ..
	make

After it is finished building, you have to copy the libsmu shared library into the build folder and Pixelpulse2 should be ready to use with your M1K

To build / run on Ubuntu

 * Please note that you make encounter issues if you are running a version of Ubuntu lower than 15.04, because the version of QT in the repositories will likely be less than 5.4 (this also applies if you are running a Linux distribution that uses an older version of Ubuntu, for example Linux Mint 17.1, which uses Ubuntu 14.04.)
 * The build process is tested and supported on Ubuntu 16, 18 and 20.

* Get ready

    ```bash
    sudo apt-get update
    ```

* Build and install libsmu (https://github.com/sounddrill31/libsmu)

* Install Qt6 and some Qt modules

    ```bash
    sudo apt-get install -y qt5-default qtdeclarative5-dev qml-module-qtquick-dialogs qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel qml-module-qtqml-models2 qml-module-qtquick-controls
    ```

* Make a new folder, clone the pixelpulse library into it from git, and build it!

    ```bash
    mkdir development
    cd development
    git clone https://github.com/sounddrill31/Pixelpulse2
    cd pixelpulse2
    mkdir build
    cd build
    cmake ..
    make
    ```

 * Make sure your M1K is plugged into your computer.  The onboard LED should light up when it is connected.  You can double-check by typing ```lsusb```.  You should see something along the lines of ```ID 064b:784c Analog Devices, Inc. (White Mountain DSP)```
 * You should be ready to launch Pixelpulse2. First, go to the directory it was built in:
    
    ```bash
    cd ~/development/pixelpulse2/build
    ```

 * Run Pixelpulse2

    ```bash
    ./pixelpulse2
    ```
