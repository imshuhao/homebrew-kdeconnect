cask "kdeconnect" do
  name "KDE Connect"
  desc "Connect your phone to your computer"
  homepage "https://kdeconnect.kde.org/"
  version "0"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/"
    regex(/kdeconnect-kde-master-(\d+)-macos-clang-arm64\.dmg/)
    strategy :page_match
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-5218-macos-clang-arm64.dmg"
      sha256 "35eef0facd814f3503de43e935ae650f1616a0c0d7b39b7821ad1f1c83373063"
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-5218-macos-clang-x86_64.dmg"
      sha256 "35eef0facd814f3503de43e935ae650f1616a0c0d7b39b7821ad1f1c83373063"
    end
  end

  app "KDE Connect.app"

  zap trash: [
    "~/Library/Application Support/kdeconnect.app",
    "~/Library/Application Support/kpeoplevcard/kdeconnect-*",
    "~/Library/Preferences/org.kde.kdeconnect.plist",
    "~/Library/Preferences/kdeconnect",
    "~/Library/Caches/kdeconnect",
    "~/Library/Logs/kdeconnect",
    "~/Library/Saved Application State/org.kde.kdeconnect.savedState"
  ]
end
