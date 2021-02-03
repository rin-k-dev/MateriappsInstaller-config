BJAM="$PREFIX/bin/b2 --layout=system --ignore-site-config toolset=gcc"

# setup config files

echo "using mpi : $(which mpicc) ;" > user-config.jam
. $SCRIPT_DIR/../python3/find.sh
if [ ${MA_HAVE_PYTHON3} = "yes" ]; then
  cp user-config.jam user-config-python3.jam
  echo "using python : ${MA_PYTHON3_VERSION_MAJOR}.${MA_PYTHON3_VERSION_MINOR} : ${MA_PYTHON3} ;" >> user-config-python3.jam
fi

# build

env BOOST_BUILD_PATH=. ${BJAM} --user-config=user-config.jam --without-python
if [ ${MA_HAVE_PYTHON3} = "yes" ]; then
  env BOOST_BUILD_PATH=. ${BJAM} --user-config=user-config-python3.jam --build-dir=build-python3 --stagedir=stage-python3 --with-python --with-mpi python=${MA_PYTHON3_VERSION_MAJOR}.${MA_PYTHON3_VERSION_MINOR}
fi
