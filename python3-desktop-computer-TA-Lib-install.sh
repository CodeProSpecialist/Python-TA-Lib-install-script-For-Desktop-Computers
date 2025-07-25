#!/bin/bash

# Exit on any error
set -e

# Step 1: Update package lists and install essential build tools and dependencies
echo "Installing build tools and dependencies..."
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    wget \
    git \
    automake \
    autoconf \
    libtool \
    python3.12 \
    python3.12-dev \
    python3-pip \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev

# Step 2: Download TA-Lib 0.6.4 source
echo "Downloading TA-Lib 0.6.4..."
wget https://github.com/TA-Lib/ta-lib/releases/download/v0.6.4/ta-lib-0.6.4-src.tar.gz

# Step 3: Extract and build TA-Lib
echo "Extracting and building TA-Lib..."
tar -xzf ta-lib-0.6.4-src.tar.gz
cd ta-lib-0.6.4
chmod +x autogen.sh
./autogen.sh
./configure --prefix=/usr
make
sudo make install

# Step 4: Update linker cache
echo "Updating linker cache..."
sudo ldconfig

# Step 5: Verify TA-Lib installation
if [ -f /usr/lib/libta-lib.so ]; then
    echo "TA-Lib library installed successfully at /usr/lib/libta-lib.so"
else
    echo "Error: TA-Lib library not found at /usr/lib/libta-lib.so"
    exit 1
fi

# Step 6: Install Python TA-Lib wrapper
echo "Installing Python TA-Lib wrapper..."
pip3 install --no-cache-dir numpy
pip3 install --no-cache-dir TA-Lib==0.6.4

# Step 7: Verify Python TA-Lib installation
echo "Verifying Python TA-Lib installation..."
python3 -c "import talib; print('TA-Lib version:', talib.__version__)" || {
    echo "Error: Python TA-Lib installation failed"
    exit 1
}

# Step 8: Clean up
echo "Cleaning up..."
cd ..
rm -rf ta-lib-0.6.4 ta-lib-0.6.4-src.tar.gz

echo "TA-Lib and Python TA-Lib installed successfully!"
