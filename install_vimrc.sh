#!/bin/bash

USER_ID=$(id -u)
HOME_FOLDER=$HOME

VIMRC_FILE=( "$HOME_FOLDER/.vimrc" "$HOME_FOLDER/.vim" ) 
INSTALL_MODe=0

# description: install vimrc file as $HOME/.vimrc
function install_vimrc() {
  /usr/bin/cp -rfv vimrc "$HOME/.vimrc"
}

# description: install vim-folder as $HOME/.vim
function install_vim() {
  /usr/bin/cp -rfv vim "$HOME/.vim"
}

# description: main function  
# param 1: should be the command line args
function main () {

  declare -A install

  install["$HOME_FOLDER/.vimrc"]=install_vimrc
  install["$HOME_FOLDER/.vim"]=install_vim


  if [[ "$USER_ID" == "0" ]]; then
    echo "You are root please do not run this script as root"
    exit 1
  fi

  for value in ${VIMRC_FILE[@]}; do
    if ls $value &>/dev/null; then
      read -p "$value already exists. Overwrite? [y|N] " answer
      case $answer in
        y|Y)
          ${install["$value"]}
          ;;
        n|N)
          echo "Keep healthy and have a good day =) "
          exit 0
          ;;
        *)
          echo "invalid answer $answer"
          echo "abort installing"
          exit 1
          ;;
      esac
    fi
  done

  echo "Installing done ... have good day and stay hydrated =) "
}

main $*
