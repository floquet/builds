SpWx
====
Brief Installation instructions for SpWx Library 

- See [govcloud](https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx/-/wikis/source-build) 
  for full details and other options available

Maintainer
----------
Obtain SpWx:

```
mkdir $HOME/SpWx
cd $HOME/SpWx/
git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source
```

gitlab token authentication may be inserted in command line, ie

`git clone https://<user>:<token>@swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git source`

  -  where `<user>` and `<token>` are replaced with your specific information

### Build Procedure

```
cd $HOME/SpWx
mkdir build
cd build
cmake3 ../source -DCMAKE_INSTALL_PREFIX=../
```
- Other flags may be needed, such as -DEXT_LIBS_ROOT, etc; see Wiki page

```
make
make test
make install
```

- Following a successful build and install, the SpWx installation will have this layout:

```
SpWx/
 +-- build/                 Local CMake build
 +-- data/                  (installed by CMake)
 |    +-- UnitTestInput/    (previously located in the 'Common' subdirectory)
 |    \-- <model database HDF5 files>
 +-- include/               (installed by CMake)
 +-- lib/                   (installed by CMake)
 +-- python/                (installed by CMake)
 \-- source/                Local clone of 'SpWx' repository source code
```

End-user
--------
To build and install SpWx release, e.g. v2.3

```
git clone https://swe-gitlab.aer-govcloud.net/afrl-support/SpWx.git --branch SpWx_version_2.3_release
mkdir build
cd build
cmake ../SpWx -DCMAKE_INSTALL_PREFIX=$HOME/usr/local
make
make test
make install
```
In your project CMakeLists.txt

```
cmake_minimum_required(VERSION 3.6)
project(spwxclient)

list(APPEND CMAKE_PREFIX_PATH $ENV{HOME}/usr/local)
find_package(spwx REQUIRED)
add_executable(myexe main.cpp)
target_include_directories(myexe PUBLIC ${spwx_INCLUDE_DIRS})
target_link_libraries(myexe cmagfield_shared)
```



Doxygen sentinel: {#mainpage}
