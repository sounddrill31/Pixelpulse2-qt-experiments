#!/usr/bin

sudo rm -rf libsmu
git clone https://github.com/sounddrill31/libsmu.git
cd libsmu
mkdir build && cd build
cmake -DCMAKE_POLICY_VERSION_MINIMUM=2.8 -DBUILD_PYTHON=OFF -DCMAKE_INSTALL_PREFIX=/usr/ ..
make
sudo make install
cd ../..
