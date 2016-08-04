function(ofxaddon OFXADDON)

    set(OFXADDON_DIR ${OFXADDON})

    if (OFXADDON STREQUAL ofx3DModelLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofx3DModelLoader")
        set(OFXSOURCES
                "${OFXADDON_DIR}/src/3DS/model3DS.cpp"
                "${OFXADDON_DIR}/src/3DS/texture3DS.cpp"
                "${OFXADDON_DIR}/src/ofx3dModelLoader.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/src/3DS")


    elseif (OFXADDON STREQUAL ofxAccelerometer)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxAndroid)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxAssimpModelLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxAssimpModelLoader")
        set(OFXSOURCES
                "${OFXADDON_DIR}/src/ofxAssimpAnimation.cpp"
                "${OFXADDON_DIR}/src/ofxAssimpMeshHelper.cpp"
                "${OFXADDON_DIR}/src/ofxAssimpModelLoader.cpp"
                "${OFXADDON_DIR}/src/ofxAssimpTexture.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        pkg_check_modules(ASSIMP REQUIRED assimp)
        include_directories(${ASSIMP_INCLUDE_DIRS})
        link_directories(${ASSIMP_LIBRARY_DIRS})
        set(OPENFRAMEWORKS_LIBRARIES
                ${OPENFRAMEWORKS_LIBRARIES} ${ASSIMP_LIBRARIES} PARENT_SCOPE)


    elseif (OFXADDON STREQUAL ofxEmscripten)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxGui)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxGui")
        set(OFXSOURCES
                "${OFXADDON_DIR}/src/ofxBaseGui.cpp"
                "${OFXADDON_DIR}/src/ofxButton.cpp"
                "${OFXADDON_DIR}/src/ofxGuiGroup.cpp"
                "${OFXADDON_DIR}/src/ofxLabel.cpp"
                "${OFXADDON_DIR}/src/ofxPanel.cpp"
                "${OFXADDON_DIR}/src/ofxSlider.cpp"
                "${OFXADDON_DIR}/src/ofxSliderGroup.cpp"
                "${OFXADDON_DIR}/src/ofxToggle.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")


    elseif (OFXADDON STREQUAL ofxiOS)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxKinect)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxKinect")
        set(OFXSOURCES
                "${OFXADDON_DIR}/libs/libfreenect/src/audio.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/cameras.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/core.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/flags.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/keep_alive.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/loader.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/registration.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/tilt.c"
                "${OFXADDON_DIR}/libs/libfreenect/src/usb_libusb10.c"
                "${OFXADDON_DIR}/src/extra/ofxKinectExtras.cpp"
                "${OFXADDON_DIR}/src/ofxKinect.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/src/extra")
        include_directories("${OFXADDON_DIR}/libs/libfreenect/src")
        include_directories("${OFXADDON_DIR}/libs/libfreenect/include")
        find_package(LibUSB REQUIRED)
        add_definitions(${LIBUSB_1_DEFINITIONS})
        include_directories(${LIBUSB_1_INCLUDE_DIRS})
        set(OPENFRAMEWORKS_LIBRARIES
                ${OPENFRAMEWORKS_LIBRARIES} ${LIBUSB_1_LIBRARIES} PARENT_SCOPE)


    elseif (OFXADDON STREQUAL ofxMultiTouch)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxNetwork)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxNetwork")
        set(OFXSOURCES
                "${OFXADDON_DIR}/src/ofxTCPClient.cpp"
                "${OFXADDON_DIR}/src/ofxTCPManager.cpp"
                "${OFXADDON_DIR}/src/ofxTCPServer.cpp"
                "${OFXADDON_DIR}/src/ofxUDPManager.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")


    elseif (OFXADDON STREQUAL ofxOpenCv)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxOpenCv")
        set(OFXSOURCES
                "${OFXADDON_DIR}/src/ofxCvColorImage.cpp"
                "${OFXADDON_DIR}/src/ofxCvContourFinder.cpp"
                "${OFXADDON_DIR}/src/ofxCvFloatImage.cpp"
                "${OFXADDON_DIR}/src/ofxCvGrayscaleImage.cpp"
                "${OFXADDON_DIR}/src/ofxCvHaarFinder.cpp"
                "${OFXADDON_DIR}/src/ofxCvImage.cpp"
                "${OFXADDON_DIR}/src/ofxCvShortImage.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        pkg_check_modules(OPENCV REQUIRED opencv)
        include_directories(${OPENCV_INCLUDE_DIRS})
        link_directories(${OPENCV_LIBRARY_DIRS})
        foreach (LIBRARY ${OPENCV_LIBRARIES})
            if (NOT ${LIBRARY} MATCHES opencv_ts AND
                    NOT ${LIBRARY} MATCHES opengl32 AND
                    NOT ${LIBRARY} MATCHES glu32)
                find_library(FOUND_${LIBRARY} ${LIBRARY})
                set(OFXADDON_LIBRARIES ${OFXADDON_LIBRARIES} ${FOUND_${LIBRARY}})
            endif ()
        endforeach ()
        find_package(TBB)
        if (TBB_FOUND AND CMAKE_SYSTEM MATCHES Linux)
            include_directories(${TBB_INCLUDE_DIRS})
            list(APPEND OFXADDON_LIBRARIES ${TBB_LIBRARIES})
        endif ()
        set(OPENFRAMEWORKS_LIBRARIES
                ${OPENFRAMEWORKS_LIBRARIES} ${OFXADDON_LIBRARIES} PARENT_SCOPE)


    elseif (OFXADDON STREQUAL ofxOsc)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxOsc")
        set(OFXSOURCES
                "${OFXADDON_DIR}/libs/oscpack/src/ip/IpEndpointName.cpp"
                "${OFXADDON_DIR}/libs/oscpack/src/osc/OscOutboundPacketStream.cpp"
                "${OFXADDON_DIR}/libs/oscpack/src/osc/OscPrintReceivedElements.cpp"
                "${OFXADDON_DIR}/libs/oscpack/src/osc/OscReceivedElements.cpp"
                "${OFXADDON_DIR}/libs/oscpack/src/osc/OscTypes.cpp"
                "${OFXADDON_DIR}/src/ofxOscBundle.cpp"
                "${OFXADDON_DIR}/src/ofxOscMessage.cpp"
                "${OFXADDON_DIR}/src/ofxOscParameterSync.cpp"
                "${OFXADDON_DIR}/src/ofxOscReceiver.cpp"
                "${OFXADDON_DIR}/src/ofxOscSender.cpp"
                )
        if (CMAKE_SYSTEM MATCHES Linux)
            list(APPEND OFXSOURCES
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/NetworkingUtils.cpp"
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/UdpSocket.cpp"
                    )
        elseif (CMAKE_SYSTEM MATCHES Darwin)
            list(APPEND OFXSOURCES
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/NetworkingUtils.cpp"
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/posix/UdpSocket.cpp"
                    )
        elseif (CMAKE_SYSTEM MATCHES Windows)
            list(APPEND OFXSOURCES
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/win32/NetworkingUtils.cpp"
                    "${OFXADDON_DIR}/libs/oscpack/src/ip/win32/UdpSocket.cpp"
                    )
        endif ()
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src/ip")
        include_directories("${OFXADDON_DIR}/libs/oscpack/src/osc")


    elseif (OFXADDON STREQUAL ofxSvg)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxSvg")
        set(OFXSOURCES
                "${OFXADDON_DIR}/libs/svgTiny/src/src_colors.cpp"
                "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny.cpp"
                "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny_gradient.cpp"
                "${OFXADDON_DIR}/libs/svgTiny/src/svgtiny_list.cpp"
                "${OFXADDON_DIR}/src/ofxSvg.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs/svgTiny/src")


    elseif (OFXADDON STREQUAL ofxThreadedImageLoader)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxThreadedImageLoader")
        set(OFXSOURCES "${OFXADDON_DIR}/src/ofxThreadedImageLoader.cpp")
        include_directories("${OFXADDON_DIR}/src")


    elseif (OFXADDON STREQUAL ofxUnitTests)
        message(FATAL_ERROR "${OFXADDON} is not supported yet.")


    elseif (OFXADDON STREQUAL ofxVectorGraphics)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxVectorGraphics")
        set(OFXSOURCES
                "${OFXADDON_DIR}/libs/CreEPS.cpp"
                "${OFXADDON_DIR}/src/ofxVectorGraphics.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")


    elseif (OFXADDON STREQUAL ofxXmlSettings)
        set(OFXADDON_DIR "${OF_ROOT_DIR}/addons/ofxXmlSettings")
        set(OFXSOURCES
                "${OFXADDON_DIR}/libs/tinyxml.cpp"
                "${OFXADDON_DIR}/libs/tinyxmlerror.cpp"
                "${OFXADDON_DIR}/libs/tinyxmlparser.cpp"
                "${OFXADDON_DIR}/src/ofxXmlSettings.cpp"
                )
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")

    else ()

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/${OFXADDON_DIR}/")
            message(FATAL_ERROR "ofxaddon(${OFXADDON_DIR}): the folder doesn't exist.")
        endif ()

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/${OFXADDON_DIR}/src/")
            message(FATAL_ERROR "ofxaddon(${OFXADDON_DIR}): the addon doesn't have src subfolder.")
        endif ()

        file(GLOB_RECURSE OFXHEADERS
                "${OFXADDON_DIR}/src/*.h"
                "${OFXADDON_DIR}/src/*.hh"
                "${OFXADDON_DIR}/src/*.hpp"
                "${OFXADDON_DIR}/src/*CMakeLists.txt"
                "${OFXADDON_DIR}/libs/*.h"
                "${OFXADDON_DIR}/libs/*.hh"
                "${OFXADDON_DIR}/libs/*.hpp"
                )

        file(GLOB_RECURSE OFXSOURCES
                "${OFXADDON_DIR}/src/*.c"
                "${OFXADDON_DIR}/src/*.cc"
                "${OFXADDON_DIR}/src/*.cpp"
                "${OFXADDON_DIR}/libs/*.c"
                "${OFXADDON_DIR}/libs/*.cc"
                "${OFXADDON_DIR}/libs/*.cpp"
                )

        foreach (OFXHEADER_PATH ${OFXHEADERS})
            get_filename_component(OFXHEADER_DIR ${OFXHEADER_PATH} PATH)
            set(OFXHEADER_DIRS ${OFXHEADER_DIRS} ${OFXHEADER_DIR})
        endforeach ()

        include_directories(${OFXHEADER_DIRS})
        include_directories("${OFXADDON_DIR}/src")
        include_directories("${OFXADDON_DIR}/libs")

    endif ()

    if (OFXSOURCES)
        set(OFXADDONS_SOURCES ${OFXADDONS_SOURCES} ${OFXSOURCES} PARENT_SCOPE)
    endif ()

endfunction(ofxaddon)
