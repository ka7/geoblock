#!/bin/bash
# unit test / data-check goes into here.

command -v shellcheck >/dev/null 2>&1 || { echo >&2 "I require 'shellcheck' but it's not installed; consider install it"; }

echo "output of 'shellcheck' is.."
# run shellcheck.. zero errors would be great!
shellcheck ./*.sh 

echo "no output? good sign, seems to have no issues..."
