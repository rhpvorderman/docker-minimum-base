#!/usr/bin/env bash
set -eu -o pipefail

BUILD_DIR=./rootfs
sudo rm -rf $BUILD_DIR/*
sudo mmdebstrap \
  --variant=custom \
  --dpkgopt='path-exclude=/usr/share/man/*' \
  --dpkgopt='path-exclude=/usr/share/locale/*' \
  --dpkgopt='path-exclude=/usr/share/doc/*' \
  --dpkgopt='path-exclude=/var/lib/apt/lists/*debian*' \
  --dpkgopt='path-exclude=/var/cache/apt/*.bin' \
  --extract-hook='chroot "$1" busybox --install -s' \
  --setup-hook='mkdir -p "$1/bin"' \
  --setup-hook='mkdir "$1/sys"' \
  --setup-hook='mkdir "$1/proc"' \
  --setup-hook='for p in awk cat chmod chown cp diff echo env grep less ln mkdir mount rm rmdir sed sh sleep sort touch uname; do ln -s busybox "$1/bin/$p"; done' \
  --include dpkg,busybox,bash-static,libc-bin bullseye $BUILD_DIR
