include("${PROJECT_SOURCE_DIR}/cmake/message.cmake")

function(dump_variables)

  get_cmake_property(_variableNames VARIABLES)
  foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
  endforeach()

endfunction()