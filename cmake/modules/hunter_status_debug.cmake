# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.
include_guard()

function(hunter_status_debug)
  if(HUNTER_STATUS_DEBUG)
    string(TIMESTAMP timestamp)
    if(HUNTER_CACHE_RUN)
      set(type "DEBUG (CACHE RUN)")
    else()
      set(type "DEBUG")
    endif()
    message(STATUS "[hunter *** ${type} *** ${timestamp}] ${ARGV}")
  endif()
endfunction()
