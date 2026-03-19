#!/usr/bin/env bash
set -Eeuo pipefail

install_ios_simulator() {
  echo 'start installing iOS Simulator...'

  if xcrun simctl list runtimes | grep -q "iOS"; then
    echo "iOS Simulator is already installed."
    return
  fi

  echo "Please enter your password for Xcode setup."
  sudo -v
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -license accept
  sudo xcodebuild -runFirstLaunch
  xcodebuild -downloadPlatform iOS

  echo 'iOS Simulator installation completed.'
}

install_ios_simulator
