#!/bin/bash
# Runs the given test binary and succeeds only if it fails, mirroring CMake's
# `set_tests_properties(coal-broadphase PROPERTIES WILL_FAIL TRUE)`.
set -u

"$1"
status=$?

if [ "$status" -eq 0 ]; then
  echo "expected $1 to fail, but it exited successfully" >&2
  exit 1
fi

exit 0
