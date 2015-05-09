ofLiveApp
=========

ofLiveApp is Linux-only for now. Tested under Ubuntu 14.04.

Write your code in `ofLiveApp.cpp` file. Once the code is compiled you can just save the source file and see your changes in your application after ~5 seconds.

If you need global variables which should not be resetted on each code update, see [`ofGlobals` struct](https://github.com/ofnode/ofLiveApp/blob/690ed70/src/ofLiveApp.h#L12-L14) and fill it with such objects (i.e. cameras).

You can compile application normally by passing `-DOF_ENABLE_LIVECODE=OFF` to CMake on project generation step.

Giant thanks to [@kritzikratzi](https://github.com/kritzikratzi) for making his code and notes available for anyone! Chack them out here:

https://github.com/kritzikratzi/runtimeCPPDraw

Compiling
---------

Make sure that [of](https://github.com/ofnode/of) and ofApp share the same folder.

![ScreenShot](http://i.imgur.com/xTQQYv4.png)

Change directory to ofApp and perform these steps:

```bash
git submodule update --init --recursive
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release
ninja
```

### [Compiling ofApp with IDE on Linux](https://github.com/ofnode/of/wiki/Compiling-ofApp-with-IDE-on-Linux)


See also
--------

### [ofTools](https://github.com/ofnode/ofTools)
