include("${PROJECT_SOURCE_DIR}/cmake/add_nimu_library.cmake")


function(add_foo_library)

  # Parameters
  set(OPTIONS_ARGS)
  set(ONE_VALUE_ARGS NAME)
  set(MULTI_VALUE_ARGS FILES DEPENDS INCLUDE_DIRECTORIES OTHER_DEFINES)

  # Parsing parameters
  cmake_parse_arguments(LIBRARY "${OPTIONS_ARGS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN})

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

  #
  add_nimu_library(
    NAME ${LIBRARY_NAME}
    STATIC
    FILES ${LIBRARY_FILES}
    DEPENDS ${LIBRARY_DEPENDS}
    COMPILE_FLAGS "-fPIC"  # Custom flags
    INCLUDE_DIRECTORIES ${LIBRARY_INCLUDE_DIRECTORIES}
    OTHER_DEFINES ${LIBRARY_OTHER_DEFINES}
  )

endfunction(add_foo_library)

