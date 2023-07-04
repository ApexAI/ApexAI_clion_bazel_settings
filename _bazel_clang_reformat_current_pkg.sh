#!/usr/bin/env bash
#
# Copyright 2019 Apex.AI, Inc.
# All rights reserved.

if [[ -n "$1" ]]; then
    FILE_PATH="$1" # $FilePathRelativeToProjectRoot$
    PACKAGE=$(bazel query $FILE_PATH --output=package)
    shift
else
    echo "Error: The script shall be called with '\$FilePathRelativeToProjectRoot\$' as parameter."
    exit 1
fi

if [ -n "$PACKAGE" ]; then
    set -ex
    bazel run --ui_event_filters=-info --run_under="cd $(pwd) &&" //tools/repo:repo.fix -- \
	--checker clang-format $FILE_PATH
else
    echo "Error: can't find package for $FILE_PATH file."
fi