include("${PROJECT_SOURCE_DIR}/cmake/color.cmake")

function(fatal_message msg)  
  message(FATAL_ERROR "${Red}${msg}${ColourReset}")
endfunction(fatal_message)

function(warning_message msg)
  message(WARNING "${Yellow}${msg}${ColourReset}")
endfunction(warning_message)

function(status_message msg)
  message(STATUS "${Green}${msg}${ColourReset}")
endfunction(status_message)

