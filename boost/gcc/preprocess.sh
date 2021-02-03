set -u

cd tools/build
sh bootstrap.sh --with-toolset=gcc
./b2 --prefix=$PREFIX install
