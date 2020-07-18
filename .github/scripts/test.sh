#!/bin/bash

set -eo pipefail

xcodebuild -workspace Marvel.xcworkspace \
            -scheme Marvel \
            -destination platform=iOS\ Simulator,name=iPhone\ 11 \
            clean test | xcpretty
