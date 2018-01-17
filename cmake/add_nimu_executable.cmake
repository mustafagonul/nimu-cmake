include("${PROJECT_SOURCE_DIR}/cmake/message.cmake")


function(add_nimu_executable)

  # Parameters
  set(OPTIONS_ARGS ENABLE_EXPORTS)
  set(ONE_VALUE_ARGS NAME)
  set(MULTI_VALUE_ARGS COMPILE_FLAGS FILES DEPENDS)

  # Parsing parameters
  cmake_parse_arguments(EXECUTABLE "${OPTIONS_ARGS}" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN})

  # Executable Message
  status_message("${EXECUTABLE_NAME}: Executable")

  # Unused Parameters
  if(NOT ${EXECUTABLE_UNPARSED_ARGUMENTS} STREQUAL "")
    fatal_message("${EXECUTABLE_NAME}: Parameter Error! ${LIBRARY_UNPARSED_ARGUMENTS}")
  endif()

  # Executable Name
  if("${EXECUTABLE_NAME}" STREQUAL "")
    fatal_message("${EXECUTABLE_NAME}: Name Error!")
  endif()

  # Executable Files
  if(NOT EXECUTABLE_FILES)
    fatal_message("${EXECUTABLE_NAME}: File Error!")
  endif()

  # Add Executable
  add_executable(${EXECUTABLE_NAME} ${EXECUTABLE_FILES})

  # Compile Flags
  if(EXECUTABLE_COMPILE_FLAGS)
    target_compile_options(${EXECUTABLE_NAME} PUBLIC ${EXECUTABLE_COMPILE_FLAGS})
  endif()

  # Dependencies
  target_link_libraries(${EXECUTABLE_NAME} PUBLIC "${EXECUTABLE_DEPENDS}")

  # Defines
  #target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ${EXECUTABLE_DEFINE})
  #if (NIMU_TEST_ENABLED)
  #  target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ${EXECUTABLE_DEFINE}_TEST)
  #endif()
  #target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ${EXECUTABLE_OTHER_DEFINES})

  # Target Properties
  set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINKER_LANGUAGE CXX)

  # Enable Export
  if(EXECUTABLE_ENABLE_EXPORTS)
    set_target_properties(${EXECUTABLE_NAME} PROPERTIES ENABLE_EXPORTS ON)
  endif()

endfunction(add_nimu_executable)
