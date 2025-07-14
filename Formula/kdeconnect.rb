class Kdeconnect < Formula
  desc "KDE Connect for macOS - connect your phone to your computer"
  homepage "https://kdeconnect.kde.org/"
  license "GPL-2.0-or-later"
  revision 1
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-latest-macos-clang-arm64.dmg"
      sha256 :no_check
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-latest-macos-clang-x86_64.dmg"
      sha256 :no_check
    end
  end

  def install
    # Extract the .app directory from the DMG and install to prefix
    mount_point = "/Volumes/KDE Connect"
    system_command "/usr/bin/hdiutil",
                   args: ["attach", "-nobrowse", "-readonly", "-mountpoint", mount_point, "#{staged_path}/#{basename}"]
    
    begin
      prefix.install "#{mount_point}/KDE Connect.app"
    ensure
      system_command "/usr/bin/hdiutil",
                    args: ["detach", "-force", mount_point]
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