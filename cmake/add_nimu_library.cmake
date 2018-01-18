include("${PROJECT_SOURCE_DIR}/cmake/message.cmake")


function(add_nimu_library)

  # Parameters
  set(OPTIONS_ARGS STATIC SHARED MODULE)
  set(ONE_VALUE_ARGS NAME DEFINE)
  set(MULTI_VALUE_ARGS COMPILE_FLAGS LINK_FLAGS FILES DEPENDS INCLUDE_DIRECTORIES OTHER_DEFINES)

  # Parsing parameters
  cmake_parse_arguments(LIBRARY "${OPTIONS_ARGS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN})

  # Library Message
  if(LIBRARY_STATIC)
    status_message("${LIBRARY_NAME}: Static")
  elseif(LIBRARY_SHARED)
    status_message("${LIBRARY_NAME}: Shared")
  elseif(LIBRARY_MODULE)
    status_message("${LIBRARY_NAME}: Module")
  else()
    fatal_message("${LIBRARY_NAME}: No Library Type selected!")
    status_message("${LIBRARY_NAME}: Shared")
  endif()

  # Unused Parameters
  if(NOT "${LIBRARY_UNPARSED_ARGUMENTS}" STREQUAL "")
    fatal_message("${LIBRARY_NAME}: Parameter Error! ${LIBRARY_UNPARSED_ARGUMENTS}")
  endif()

  # Library Name
  if("${LIBRARY_NAME}" STREQUAL "")
    fatal_message("${LIBRARY_NAME}: Name Error!")
  endif()

  # Library Files
  if("${LIBRARY_FILES}" STREQUAL "")
    fatal_message("${LIBRARY_NAME}: File Error!")
  endif()

  # Library Define
  # If library define was not set, a library define is set with NIMU prefix.
  if("${LIBRARY_DEFINE}" STREQUAL "")
    set(LIBRARY_DEFINE NIMU_${LIBRARY_NAME})
    string(TOUPPER ${LIBRARY_DEFINE} LIBRARY_DEFINE)
  endif()

  # Add Library
  if(LIBRARY_STATIC)
    add_library(${LIBRARY_NAME} STATIC ${LIBRARY_FILES})
  elseif(LIBRARY_SHARED)
    add_library(${LIBRARY_NAME} SHARED ${LIBRARY_FILES})
  elseif(LIBRARY_MODULE)
    add_library(${LIBRARY_NAME} MODULE ${LIBRARY_FILES})
  else()
    add_library(${LIBRARY_NAME} SHARED ${LIBRARY_FILES})
  endif()

  # Dependencies
  if(NOT "${LIBRARY_DEPENDS}" STREQUAL "")
    target_link_libraries(${LIBRARY_NAME} PUBLIC ${LIBRARY_DEPENDS})
  endif()

  # Compile Flags
  if(NOT "${LIBRARY_COMPILE_FLAGS}" STREQUAL "")
    target_compile_options(${LIBRARY_NAME} PUBLIC ${LIBRARY_COMPILE_FLAGS})
  endif()

  # Link Flags
  if(NOT "${LIBRARY_LINK_FLAGS}" STREQUAL "")
    set_target_properties(${LIBRARY_NAME} PROPERTIES LINK_FLAGS ${LIBRARY_LINK_FLAGS})
  endif()

  # Defines
  if(NOT "${LIBRARY_DEFINE}" STREQUAL "")
    target_compile_definitions(${LIBRARY_NAME} PRIVATE ${LIBRARY_DEFINE})
    if(NIMU_TEST_ENABLED)
        target_compile_definitions(${LIBRARY_NAME} PRIVATE ${LIBRARY_DEFINE}_TEST)
    endif()
    if(NOT "${LIBRARY_OTHER_DEFINES}" STREQUAL "")
      target_compile_definitions(${LIBRARY_NAME} PRIVATE ${LIBRARY_OTHER_DEFINES})
    endif()
  endif()

  # Include Directories
  if (NOT "${LIBRARY_INCLUDE_DIRECTORIES}" STREQUAL "")
    target_include_directories(${LIBRARY_NAME} PUBLIC ${LIBRARY_INCLUDE_DIRECTORIES})
  endif()

  # Target Properties
  set_target_properties(${LIBRARY_NAME} PROPERTIES LINKER_LANGUAGE CXX)

endfunction(add_nimu_library)
