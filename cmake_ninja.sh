#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export CCACHE_SLOPPINESS=pch_defines,time_macros
     export CC=clang
     export CXX=clang++
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export CC="clang"
    export CXX="clang++"
fi
# cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
# rm -rf CMakeCache.txt CMakeFiles cmake_install.cmake Makefile
# echo "compile_commands.json built"
rm -rf build
for arg in "$*"
do
		# cmake -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_C_COMPILER=$CC -GNinja -DCMAKE_BUILD_TYPE=Release ..
    # rm -rf CMakeFiles CMakeCache.txt cmake_install.cmake Makefile ofApp_CXX_cotire.cmake cotire

	   echo "build type: $arg"
	   if [ ! -d "build" ]
		 then
 		 	  mkdir build
	   fi
	   cd build/
	  if [[ "$arg" = "debug" ]]
	  then
		    CC=$CC CXX=$CXX cmake -GNinja -DCMAKE_BUILD_TYPE=Debug -DBUILD_FOR_RUN=ON -DUSE_COTIRE=ON ..
	  elif [[ "$arg" = "release" ]]
	  then
		    cmake -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_C_COMPILER=$CC -GNinja -DCMAKE_BUILD_TYPE=Release -DBUILD_FOR_RUN=ON -DUSE_COTIRE=ON ..
	  fi
done
