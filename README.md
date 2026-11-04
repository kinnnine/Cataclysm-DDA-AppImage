<div align="center">

# Cataclysm-DDA-AppImage 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/kinnnine/Cataclysm-DDA-AppImage/total?logo=github&label=GitHub%20Downloads)](https://github.com/kinnnine/Cataclysm-DDA-AppImage/releases/latest)
[![CI Build Status](https://github.com/kinnnine/Cataclysm-DDA-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/kinnnine/Cataclysm-DDA-AppImage/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/kinnnine/Cataclysm-DDA-AppImage)](https://github.com/kinnnine/Cataclysm-DDA-AppImage/releases/latest)

<p align="center">
  <img src="https://github.com/pkgforge-dev.png" width="128" />
</p>


| Latest Stable Release | Upstream URL |
| :---: | :---: |
| [Click here](https://github.com/kinnnine/Cataclysm-DDA-AppImage/releases/latest) | [Click here](https://github.com/CleverRaven/Cataclysm-DDA/tree/0.H-RELEASE) |

</div>

## FAQ

### Where to install extra soundpacks, tilesets or mods?
User's data folder is located at `$HOME/.local/share/cataclysm-dda`, install it there.<br>
In that folder should contains `sound`, `gfx` and `mods`, tileset must be in `gfx` and the rest are self-explanatory.

Inside user's data folder also containing your saves files. 

### Where is the game configuration file?
User's config folder is located at `$HOME/.config/cataclysm-dda`, there's should be `config.json` inside the folder after running the game for the first time.

### How is this different from an official distribution?
The main difference is the game executable and its data are packed into AppImage instead of binary tarball, even so the game is freshly compiled inside this GitHub action, this is not a repacked of an official binary tarball. 

### How can I run this on NixOS?
Every AppImages built with `quick-sharun` are using DwarFS instead of SquashFS, including this one.<br>
When you execute this AppImage by either running though `appimage-run` or just directly execute the file, it will always go though `appimage-run` unless binfmt is disabled in your NixOS configuration.<br>
The problem with `appimage-run` is this wrapper is expecting only SquashFS, DwarFS is completely unsupported by `appimage-run`.

In order to run this AppImage and every AppImage built with `quick-sharun`, you must disable binfmt in your `configuration.nix` or where your `programs.appimage` is defined.

```
programs.appimage = {
    enable = true;
    binfmt = false;
};
```

Reference: [https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/FAQ.md#i-get-error-cant-find-a-valid-squashfs-superblock-in-nixos](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/FAQ.md#i-get-error-cant-find-a-valid-squashfs-superblock-in-nixos)

---

AppImage made using [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks. 

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)
