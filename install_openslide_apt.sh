#!/bin/bash

PACKAGES="openslide-tools" # could probably be adapted to install any package?

INSTALL_DIR=$HOME/local2
TEMP_DIR=$(mktemp -d)

mkdir -p $INSTALL_DIR

install_dependencies_and_package() {
    cd $TEMP_DIR

    apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances --no-pre-depends ${PACKAGES} | grep "^\w")

    for deb in $TEMP_DIR/*.deb
    do
        dpkg -x "$deb" "$INSTALL_DIR"
    done
}

install_dependencies_and_package