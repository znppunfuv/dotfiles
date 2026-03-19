#!/usr/bin/env bash
set -Eeuo pipefail

setup_defaults() {
  echo 'start setting up defaults...'

  ### システム全般の設定 ###
  # バッテリー残量のパーセント表示
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true
  # スクロールバーを常に表示する
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  # 時計を 24 時間表示にする
  defaults write com.apple.menuextra.clock Is24Hour -bool true
  # 時計に日付を表示する
  defaults write com.apple.menuextra.clock ShowDayOfMonth -bool true
  # 時計に曜日を表示する
  defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
  # 時計に秒を表示する
  defaults write com.apple.menuextra.clock ShowSeconds -bool true

  ### Dockの設定 ###
  # 最近使った項目をDockに表示しない
  defaults write com.apple.dock show-recents -bool false
  # Dockのアイコンサイズを小さくする
  defaults write com.apple.dock tilesize -int 36

  ### Finderの設定 ###
  # 隠しファイルを表示する
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # 拡張子を表示する
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  # パスバー，ステータスバー，アイテム情報を表示する
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write com.apple.finder ShowItemInfo -bool true

  killall SystemUIServer
  killall ControlCenter
  killall Finder
  killall Dock

  echo 'Defaults setup completed.'
}

setup_defaults