#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm hicolor-icon-theme sdl2_mixer sdl2_ttf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano sdl2_image-mini

echo "Building Cataclysm-DDA..."
echo "---------------------------------------------------------------"
REPO="https://github.com/CleverRaven/Cataclysm-DDA"
VERSION="0.I-1"
git clone --depth 1 --branch "$VERSION" "$REPO" ./Cataclysm-DDA
echo "$VERSION" > ~/version

cd ./Cataclysm-DDA

# Specific patches for each versions.
case VERSION in
  "0.H-RELEASE")
    # Fix compiler error on flatbuffers's stl_emulation.h.
    # https://github.com/CleverRaven/Cataclysm-DDA/commit/1400b1018ff37196bd24ba4365bd50beb571ac14
    sed -i 's/const size_type count_;/size_type count_;/g' src/third-party/flatbuffers/stl_emulation.h
    ;;
  "0.I")
    # Disable WARN_ON_MODIFIED by default, preventing debug screen about stale game data on every launch.
    sed -i '2891 s/true/false/' src/options.cpp
    ;;
esac

# There is src/prefix.h.in but I have no idea why src/prefix.h won't generated...
echo '#define PREFIX "/usr"' > src/prefix.h

export LDFLAGS="${LDFLAGS:-}" && export LDFLAGS="${LDFLAGS/-Wl,-z,pack-relative-relocs/}"
export CXXFLAGS="${CXXFLAGS:-} -Wno-error=maybe-uninitialized -Wno-error=sfinae-incomplete"; for flag in "-Wp,-D_GLIBCXX_ASSERTIONS" "-fcf-protection" "-fstack-clash-protection"; do CXXFLAGS="${CXXFLAGS/$flag/}"; done
make -j$(nproc) PREFIX=/usr PCH=0 RELEASE=1 USE_XDG_DIR=1 LTO=1 RUNTESTS=0 TESTS=0 LINTJSON=0 ASTYLE=0 LOCALIZE=1 LANGUAGES=all TILES=1 SOUND=1 install
