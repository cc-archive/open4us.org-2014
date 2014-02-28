#!/bin/bash

CWD=`pwd`
TOPDIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "${TOPDIR}"

# Update toplevel repository and submodules

git pull
git submodule update

# Eek - how do we figure out if a restart is needed?
sudo /etc/init.d/apache2 restart

cd "${CWD}"
