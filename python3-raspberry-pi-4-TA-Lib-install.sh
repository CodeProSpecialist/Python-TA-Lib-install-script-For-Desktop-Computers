sudo apt update

# Install required packages
sudo apt install -y libhdf5-dev

# Install TA-Lib dependencies
echo "Installing TA-Lib dependencies ..."
sudo apt-get install libatlas-base-dev gfortran -y

# Download and install TA-Lib
echo "Downloading TA-Lib..."
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzvf ta-lib-0.4.0-src.tar.gz

cd ta-lib/
echo "Configuring TA-Lib..."
#./configure --prefix=/usr/local --build=x86_64-unknown-linux-gnu
echo "Building TA-Lib..."
#sudo make -s ARCH=x86_64
echo "Installing TA-Lib..."
#sudo make -s ARCH=x86_64 install

# For Raspberry Pi 4 (aarch64):
./configure --prefix=/usr/local --build=aarch64-unknown-linux-gnu
sudo make -s ARCH=aarch64
sudo make -s ARCH=aarch64 install

cd ..
sudo rm -r -f -I ta-lib
rm ta-lib-0.4.0-src.tar.gz

echo "The installation is done. "
