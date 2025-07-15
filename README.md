# Homebrew KDE Connect

A Homebrew tap for installing KDE Connect nightly builds on macOS.

## Installation

```bash
brew tap imshuhao/kdeconnect
brew install --cask kdeconnect
```

This will install the latest nightly build of KDE Connect for your architecture (arm64 or x86_64).

## Usage

After installation, KDE Connect will be available in your Applications folder and can be launched normally.

## Updating

To update to the latest nightly build:

```bash
brew update
brew upgrade --cask kdeconnect
```

## How it works

This tap automatically uses the nightly builds from the official KDE CI:
- ARM64: https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/
- x86_64: https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/

A GitHub Action runs daily to:
1. Find the latest DMG file for both ARM64 and x86_64 architectures
2. Update the cask with the direct URLs to these files
3. Update the version to force Homebrew to recognize it as a new version
4. Create a pull request with the changes

The cask automatically installs the app to your Applications folder.

## License

This tap is licensed under the MIT License. KDE Connect itself is licensed under GPL-2.0-or-later.