class Kdeconnect < Formula
  desc "Connect your phone to your computer"
  homepage "https://kdeconnect.kde.org/"
  version "0.20250715"
  license "GPL-2.0-or-later"

  livecheck do
    skip "No version information available"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-5218-macos-clang-arm64.dmg"
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-5218-macos-clang-x86_64.dmg"
    end
  end

  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    # Extract the .app directory from the DMG and install to prefix
    mount_point = "/Volumes/KDE Connect"

    # Find the DMG file
    dmg_file = Dir["#{staged_path}/*.dmg"].first

    # Mount the DMG
    system "/usr/bin/hdiutil", "attach", "-nobrowse", "-readonly", "-mountpoint", mount_point, dmg_file

    begin
      # Copy the app to the prefix
      prefix.install Pathname.glob("#{mount_point}/KDE Connect.app").first
    ensure
      # Unmount the DMG
      system "/usr/bin/hdiutil", "detach", "-force", mount_point
    end
  end

  def caveats
    <<~EOS
      KDE Connect.app was installed to:
        #{prefix}

      You can link it into your Applications folder with:
        ln -sf "#{prefix}/KDE Connect.app" "/Applications/KDE Connect.app"
    EOS
  end

  test do
    system "/usr/bin/false"
  end
end