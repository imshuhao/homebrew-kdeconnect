class Kdeconnect < Formula
  desc "KDE Connect for macOS - connect your phone to your computer"
  homepage "https://kdeconnect.kde.org/"
  version "0.0.0"  # Version is meaningless for nightlies
  license "GPL-2.0-or-later"
  revision 1
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-latest-macos-clang-arm64.dmg"
      sha256 ""
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-latest-macos-clang-x86_64.dmg"
      sha256 ""
    end
  end

  livecheck do
    skip "No version information available"
  end

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
end