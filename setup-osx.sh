#!/bin/bash -e
mkdir -p ${HOME}/projects

# bash things
[[ ! -f ${HOME}/.bash_profile ]] && touch ${HOME}/.bash_profile
# TODO bash prompt sugar

function addToBashProfile() {
  grep -q -F "${1}" ${HOME}/.bash_profile || ( echo "${1}" >> ${HOME}/.bash_profile)
}

addToBashProfile "alias ll='ls -laG'"
addToBashProfile "alias gs='git status'"

## Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock workspaces-swoosh-animation-off -bool true
defaults write com.apple.dock tilesize -int 20
killall Dock

## Finder
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder AppleShowAllFiles -bool false

## Homebrew
[ -x /usr/local/bin/brew ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask
brew cask install google-chrome
brew cask install sizeup
## TODO: add sizeup license key
brew cask install java
brew cask install virtualbox
brew cask install sublime-text
## TODO: add sublime license key
brew cask install intellij-idea
## TODO: add intellij license key
brew install wget
brew install curl
brew install git

## gradle & gdub
brew install gradle
if [[ ! -x /usr/local/bin/gw ]]; then
  git clone https://github.com/dougborg/gdub.git ${HOME}/projects/gdub
  cd ${HOME}/projects/gdub
  ./install
fi

## Docker things
brew install docker
brew install docker-machine
brew install docker-compose

## Node things
brew install nvm
addToBashProfile 'export NVM_DIR=~/.nvm'
addToBashProfile 'source $(brew --prefix nvm)/nvm.sh'

brew doctor

