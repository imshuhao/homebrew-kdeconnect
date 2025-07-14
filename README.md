# Homebrew KDE Connect

A Homebrew tap for installing KDE Connect nightly builds on macOS.

## Installation

```bash
brew tap yourusername/kdeconnect
brew install kdeconnect
```

This will install the latest nightly build of KDE Connect for your architecture (arm64 or x86_64).

## Usage

After installation, you can link KDE Connect to your Applications folder:

```bash
ln -sf "$(brew --prefix kdeconnect)/KDE Connect.app" "/Applications/KDE Connect.app"
```

Or simply run it from the installed location:

```bash
open "$(brew --prefix kdeconnect)/KDE Connect.app"
```

## Updating

To update to the latest nightly build:

```bash
brew update
brew upgrade kdeconnect
```

## How it works

This tap automatically uses the nightly builds from the official KDE CI:
- ARM64: https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/
- x86_64: https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/

A GitHub Action runs daily to:
1. Find the latest DMG file for both ARM64 and x86_64 architectures
2. Update the formula with the direct URLs to these files
3. Update the formula revision to force Homebrew to recognize it as a new version
4. Create a pull request with the changes

The formula uses `:no_check` for the SHA256 to allow installing without verification, as these are nightly builds that change frequently.

## License

This tap is licensed under the MIT License. KDE Connect itself is licensed under GPL-2.0-or-later.