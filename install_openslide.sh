#!/bin/bash

# Set Installation folder
INSTALL_DIR=$HOME/local2

# Create the installation directory if it doesn't exist.
mkdir -p $INSTALL_DIR

# Temporary folder for downloading dependencies.
TEMP_DIR=$(mktemp -d)

install_dependency() {
    local url="$1"
    local filename=$(basename "$url")

    # Download
    wget -P "$TEMP_DIR" "$url"

    if [[ "$filename" == *.tar.gz ]]; then
        local dirname=$(tar -tzf "$TEMP_DIR/$filename" | head -n 1 | sed -e 's@^\./@@' -e 's@/.*@@' | uniq)
        tar -xzf "$TEMP_DIR/$filename" -C "$TEMP_DIR"
    elif [[ "$filename" == *.tar.xz ]]; then
        local dirname=$(tar -tf "$TEMP_DIR/$filename" | head -n 1 | sed -e 's@^\./@@' -e 's@/.*@@' | uniq)
        tar -xf "$TEMP_DIR/$filename" -C "$TEMP_DIR"
    fi
    cd "$TEMP_DIR/$dirname" || exit

    # Configure, compile, and install
    ./configure --prefix="$INSTALL_DIR"
    make
    make install

    cd "$TEMP_DIR" || exit

}

# Dependencies based on openslide readme file
install_dependency "http://www.ijg.org/files/jpegsrc.v9d.tar.gz"
install_dependency "https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz"
install_dependency "https://download.osgeo.org/libtiff/tiff-4.3.0.tar.gz"
install_dependency "https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.12.tar.xz"
install_dependency "https://cairographics.org/releases/pixman-0.40.0.tar.gz"
install_dependency "https://cairographics.org/releases/cairo-1.16.0.tar.xz"


url="https://github.com/openslide/openslide/releases/download/v3.4.1/openslide-3.4.1.tar.xz"
filename=$(basename "$url")
wget -P "$TEMP_DIR" "$url"
if [[ "$filename" == *.tar.gz ]]; then
    dirname=$(tar -tzf "$TEMP_DIR/$filename" | head -n 1 | sed -e 's@^\./@@' -e 's@/.*@@' | uniq)
    tar -xzf "$TEMP_DIR/$filename" -C "$TEMP_DIR"
elif [[ "$filename" == *.tar.xz ]]; then
    dirname=$(tar -tf "$TEMP_DIR/$filename" | head -n 1 | sed -e 's@^\./@@' -e 's@/.*@@' | uniq)
    tar -xf "$TEMP_DIR/$filename" -C "$TEMP_DIR"
fi
cd "$TEMP_DIR/$dirname" || exit
#meson setup --prefix="$INSTALL_DIR" builddir
#meson compile -C builddir
#meson install -C builddir
./configure --prefix="$INSTALL_DIR"
make
make install

cd "$TEMP_DIR" || exit
