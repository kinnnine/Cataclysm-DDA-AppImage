#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm hicolor-icon-theme sdl2_mixer sdl2_ttf
pacman -Syu --noconfirm 

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano sdl2_image-mini

echo "Building Cataclysm-DDA..."
echo "---------------------------------------------------------------"
REPO="https://github.com/CleverRaven/Cataclysm-DDA"
VERSION="0.H-RELEASE"
git clone --depth 1 --branch "$VERSION" "$REPO" ./Cataclysm-DDA
echo "$VERSION" > ~/version

cd ./Cataclysm-DDA

# https://github.com/CleverRaven/Cataclysm-DDA/commit/1400b1018ff37196bd24ba4365bd50beb571ac14
sed -i 's/const size_type count_;/size_type count_;/g' src/third-party/flatbuffers/stl_emulation.h

export LDFLAGS="${LDFLAGS:-}" && export LDFLAGS="${LDFLAGS/-Wl,-z,pack-relative-relocs/}"
export CXXFLAGS="${CXXFLAGS:-} -Wno-error=maybe-uninitialized -Wno-error=sfinae-incomplete"; for flag in "-Wp,-D_GLIBCXX_ASSERTIONS" "-fcf-protection" "-fstack-clash-protection"; do CXXFLAGS="${CXXFLAGS/$flag/}"; done
make -j$(nproc) PREFIX=/usr PCH=0 RELEASE=1 USE_XDG_DIR=1 LTO=1 RUNTESTS=0 TESTS=0 LINTJSON=0 ASTYLE=0 LOCALIZE=1 LANGUAGES=all install
make -j$(nproc) PREFIX=/usr PCH=0 RELEASE=1 USE_XDG_DIR=1 LTO=1 RUNTESTS=0 TESTS=0 LINTJSON=0 ASTYLE=0 LOCALIZE=1 LANGUAGES=all TILES=1 SOUND=1 install
