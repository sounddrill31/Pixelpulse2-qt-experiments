#!/usr/bin

sudo rm -rf libsmu
git clone https://github.com/sounddrill31/libsmu.git
cd libsmu
mkdir build && cd build
cmake -DCMAKE_CXX_STANDARD=14 -DBUILD_PYTHON=OFF -DCMAKE_INSTALL_PREFIX=/usr/ ..
make
sudo make install
cd ../..
