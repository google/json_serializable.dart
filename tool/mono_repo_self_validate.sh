#!/bin/bash
# Created with package:mono_repo v2.5.0

# Support built in commands on windows out of the box.
function pub {
       if [[ $TRAVIS_OS_NAME == "windows" ]]; then
        command pub.bat "$@"
    else
        command pub "$@"
    fi
}

set -v -e
pub global activate mono_repo 2.5.0
pub global run mono_repo travis --validate
