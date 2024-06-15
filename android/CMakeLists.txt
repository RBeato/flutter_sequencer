cmake_minimum_required(VERSION 3.26.3)
project(Sequencer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(OBOE_DIR ./third_party/oboe)
add_subdirectory(${OBOE_DIR} ./build/oboe)
include_directories(${OBOE_DIR}/include)

set(TSF_DIR ./third_party/TinySoundFont)
include_directories(${TSF_DIR})

option(SFIZZ_JACK "" OFF)
option(SFIZZ_RENDER "" OFF)
option(SFIZZ_LV2 "" OFF)
option(SFIZZ_LV2_UI "" OFF)
option(SFIZZ_VST "" OFF)
option(SFIZZ_AU "" OFF)
option(SFIZZ_SHARED "" OFF)
set(SFIZZ_DIR ./third_party/sfizz)
add_subdirectory(${SFIZZ_DIR})

add_library(flutter_sequencer SHARED)
target_include_directories(flutter_sequencer PRIVATE
    ../ios/Classes/CallbackManager
    ../ios/Classes/Scheduler
    ../ios/Classes/IInstrument
)
target_sources(flutter_sequencer PRIVATE
    ../ios/Classes/CallbackManager/CallbackManager.h
    ../ios/Classes/CallbackManager/CallbackManager.cpp
    ../ios/Classes/Scheduler/BaseScheduler.h
    ../ios/Classes/Scheduler/BaseScheduler.cpp
    ../ios/Classes/Scheduler/Buffer.h
    ../ios/Classes/Scheduler/SchedulerEvent.h
    ../ios/Classes/Scheduler/SchedulerEvent.cpp
    ./src/main/cpp/AndroidEngine/AndroidEngine.h
    ./src/main/cpp/AndroidEngine/AndroidEngine.cpp
    ../ios/Classes/IInstrument/IInstrument.h
    ../ios/Classes/IInstrument/SharedInstruments/SfizzSamplerInstrument.h
    ./src/main/cpp/AndroidInstruments/Mixer.h
    ./src/main/cpp/AndroidInstruments/SoundFontInstrument.h
    ./src/main/cpp/Utils/AssetManager.h
    ./src/main/cpp/Utils/Logging.h
    ./src/main/cpp/Utils/OptionArray.h
    ./src/main/cpp/Plugin.cpp
)

find_library(android-lib android)

target_link_libraries(flutter_sequencer ${android-lib} oboe sfizz_static)
