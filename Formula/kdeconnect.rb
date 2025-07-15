class Kdeconnect < Formula
  desc "Connect your phone to your computer"
  homepage "https://kdeconnect.kde.org/"
  version "0"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/"
    regex(/kdeconnect-kde-master-(\d+)-macos-clang-arm64\.dmg/)
    strategy :page_match
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-#{version}-macos-clang-x86_64.dmg"
    end
  end

  def install
    # Find the DMG file
    dmg_file = Dir["#{staged_path}/*.dmg"].first
    raise "No DMG file found in staged path" unless dmg_file

    # Generate unique mount point
    mount_point = "/Volumes/KDE Connect #{SecureRandom.hex(4)}"

    # Mount the DMG
    unless system "/usr/bin/hdiutil", "attach", "-nobrowse", "-readonly", "-mountpoint", mount_point, dmg_file
      raise "Failed to mount DMG file"
    end

    begin
      # Find the app in the mounted DMG
      app_path = Pathname.glob("#{mount_point}/KDE Connect.app").first
      raise "KDE Connect.app not found in DMG" unless app_path

      # Install the app to prefix
      prefix.install app_path
      
      # Create Applications symlink automatically
      applications_link = "/Applications/KDE Connect.app"
      
      # Remove existing symlink if it exists
      system "rm", "-f", applications_link if File.exist?(applications_link)
      
      # Create symlink with sudo if needed
      if File.writable?("/Applications")
        system "ln", "-sf", "#{prefix}/KDE Connect.app", applications_link
      else
        system "sudo", "ln", "-sf", "#{prefix}/KDE Connect.app", applications_link
      end
    ensure
      # Unmount the DMG
      system "/usr/bin/hdiutil", "detach", "-force", mount_point
    end
  end

  def uninstall
    # Remove the symlink from Applications
    system "rm", "-f", "/Applications/KDE Connect.app" if File.exist?("/Applications/KDE Connect.app")
  end

  zap trash: [
    "~/Library/Application Support/kdeconnect.app",
    "~/Library/Application Support/kpeoplevcard/kdeconnect-*",
    "~/Library/Preferences/org.kde.kdeconnect.plist",
    "~/Library/Preferences/kdeconnect",
    "~/Library/Caches/kdeconnect",
    "~/Library/Logs/kdeconnect",
    "~/Library/Saved Application State/org.kde.kdeconnect.savedState"
  ]

  test do
    # Check if the app was installed
    assert_predicate prefix/"KDE Connect.app", :exist?
    
    # Check if the app has the expected structure
    assert_predicate prefix/"KDE Connect.app/Contents", :exist?
    assert_predicate prefix/"KDE Connect.app/Contents/Info.plist", :exist?
    
    # Check if the symlink was created
    assert_predicate "/Applications/KDE Connect.app", :exist?
  end
end
