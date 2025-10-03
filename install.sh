#!/usr/bin/env bash

PACKAGE_NAME="clean-acmart"
PACKAGE_GIT="https://gitlab.up.pt/up202208755/$PACKAGE_NAME.git"
VERSION="0.0.1"

LINUX_DATA_HOME="$HOME/.local/share"
XDG_DATA_HOME=${XDG_DATA_HOME:-$LINUX_DATA_HOME}

DATA_DIR=$XDG_DATA_HOME

case "$OSTYPE" in
  linux*)   ;;
  darwin*)  DATA_DIR="~/Library/Application Support" ;; 
  win*)     DATA_DIR="%APPDATA%" ;;
  #msys*)    exit(1) ;;
  #cygwin*)  exit(1) ;;
  #bsd*)     exit(1) ;;
  #solaris*) exit(1) ;;
  *)         echo "Unknown OSTYPE: '$OSTYPE'" && exit 1;;
esac

TEMPLATE_DIR="$DATA_DIR/typst/packages/local/$PACKAGE_NAME"

mkdir -p $TEMPLATE_DIR || exit 1
pushd $TEMPLATE_DIR || exit 1 

if [ ! -f $VERSION ] && [ ! -d $VERSION ]; then
  git clone $PACKAGE_GIT --depth 1
  mv $PACKAGE_NAME $VERSION
  echo "Installed successfully!"
else
  echo "It seems like the template is already installed."
  echo "Consider deleting the installed template to reinstall."
  echo "    rm -rf $TEMPLATE_DIR/$VERSION"
fi
popd

