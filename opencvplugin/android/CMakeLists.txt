cmake_minimum_required(VERSION 3.10.2)

# opencv
set(OpenCV_STATIC ON)
set(OpenCV_DIR $ENV{OPENCV_ANDROID}/sdk/native/jni)
find_package (OpenCV REQUIRED)

add_library( # Sets the name of the library.
    opencvplugin
    SHARED
    # Provides a relative path to your source file(s).
    ../ios/Classes/aimodel/main.cpp
    ../ios/Classes/opencvplugin.cpp
)

target_include_directories(
    opencvplugin PRIVATE
    ../ios/Classes/aimodel
)

find_library(log-lib log)

target_link_libraries( # Specifies the target library.
    opencvplugin
    ${OpenCV_LIBS}
    ${log-lib}
)