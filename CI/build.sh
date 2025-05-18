#!/usr/bin/bash
sudo rm -rf build;
mkdir build;
cd build;
cmake .. -DCMAKE_CXX_STANDARD="17";
make &&
sudo make install; 
cd ..