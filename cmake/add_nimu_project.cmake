include("${PROJECT_SOURCE_DIR}/cmake/message.cmake")

function(prepare_project)

  # Echo & Color & Current Dir
  ##set(CMAKE_COLOR_MAKEFILE ON PARENT_SCOPE)
  ##set(CMAKE_INCLUDE_CURRENT_DIR ON PARENT_SCOPE)

  # Setting C++ Standart
  ##set(CMAKE_CXX_STANDARD 14)

  # Nimu test are enabled default
  set(NIMU_TEST_ENABLED ON CACHE INTERNAL "Nimu Unit Tests")
  #option(NIMU_TEST_ENABLED "Nimu Unit tests." OFF)

  include_directories(${CMAKE_SOURCE_DIR})

  # SET a default build type if none was specified
  if(NOT CMAKE_BUILD_TYPE)
    warning_message("Setting build type to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
    # SET the possible values of build type for cmake-gui
  endif()


  # Common compiler flags
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    status_message("GNU toolchain selected")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1z -Wall -Wextra -Werror")
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    status_message("Clang toolchain selected")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1z -Wall -Wextra -Werror" PARENT_SCOPE)
  elseif(MSVC)
    fatal_message("Currently there is no support for MSVC.")
  else()
    fatal_message("Unknown Compiler!.")
  endif()

  # Release compiler flags
  if (CMAKE_BUILD_TYPE MATCHES Release)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3" PARENT_SCOPE)
  endif()

  # Debug compiler flags
  if (CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -fno-inline -fno-inline-functions" PARENT_SCOPE)
    set(CMAKE_VERBOSE_MAKEFILE ON PARENT_SCOPE)
  endif()

  # Profiler compiler flags
  if (CMAKE_BUILD_TYPE MATCHES Profile)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg -O3 -DNDEBUG" PARENT_SCOPE)
  endif()

  # Trying to find boost
  find_package(Boost REQUIRED system filesystem program_options)
  if(Boost_FOUND)
    include_directories("${Boost_INCLUDE_DIRS}")
    link_directories(${Boost_LIBRARY_DIR})
  else()
    fatal_message("Boost cannot be found!")
  endif()

  # Tring to find gtest
  if (NIMU_TEST_ENABLED)
    enable_testing()
    find_package(GTest REQUIRED)
    if (GTest_FOUND)
      include_directories(${GTest_INCLUDE_DIRS})
    endif()
  endif()

endfunction(prepare_project)
