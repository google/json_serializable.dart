#!/bin/bash
# Created with https://github.com/dart-lang/mono_repo

# Fast fail the script on failures.
set -e

if [ -z "$PKG" ]; then
  echo -e "[31mPKG environment variable must be set![0m"
  exit 1
elif [ -z "$TASK" ]; then
  echo -e "[31mTASK environment variable must be set![0m"
  exit 1
fi

pushd $PKG
pub upgrade

case $TASK in
dartanalyzer) echo
  echo -e "[1mTASK: dartanalyzer[22m"
  dartanalyzer .
  ;;
dartfmt) echo
  echo -e "[1mTASK: dartfmt[22m"
  dartfmt -n --set-exit-if-changed .
  ;;
test) echo
  echo -e "[1mTASK: test[22m"
  pub run test
  ;;
test_1) echo
  echo -e "[1mTASK: test_1[22m"
  pub run test --run-skipped
  ;;
*) echo -e "[31mNot expecting TASK '${TASK}'. Error![0m"
  exit 1
  ;;
esac
