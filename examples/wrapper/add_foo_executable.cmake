include("${PROJECT_SOURCE_DIR}/cmake/add_nimu_executable.cmake")


function(add_foo_executable)

  # Parameters
  set(OPTIONS_ARGS)
  set(ONE_VALUE_ARGS NAME)
  set(MULTI_VALUE_ARGS FILES)

  # Parsing parameters
  cmake_parse_arguments(EXECUTABLE "${OPTIONS_ARGS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN})

  # Unused Parameters
  if(NOT ${EXECUTABLE_UNPARSED_ARGUMENTS} STREQUAL "")
    fatal_message("${EXECUTABLE_NAME}: Parameter Error! ${EXECUTABLE_UNPARSED_ARGUMENTS}")
  endif()

  # Library Name
  if("${EXECUTABLE_NAME}" STREQUAL "")
    fatal_message("${EXECUTABLE_NAME}: Name Error!")
  endif()

  # Library Files
  if("${EXECUTABLE_FILES}" STREQUAL "")
    fatal_message("${EXECUTABLE_NAME}: File Error!")
  endif()

  #
  add_nimu_executable(
    NAME ${EXECUTABLE_NAME}
    FILES ${EXECUTABLE_FILES}
    ENABLE_EXPORTS
    COMPILE_FLAGS "-Wl,--export-dynamic" # custom flags
    DEPENDS stdc++fs boost_system boost_program_options dl rt pthread # custom libraries
  )

endfunction(add_foo_executable)
