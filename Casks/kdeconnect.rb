cask "kdeconnect" do
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"
  version "5528"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/"
    regex(/kdeconnect-kde-master-(\d+)-macos-clang-arm64\.dmg/)
    strategy :page_match
  end

  depends_on macos: ">= :monterey"

  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-5523-macos-clang-arm64.dmg"
      sha256 :no_check
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-5528-macos-clang-x86_64.dmg"
      sha256 :no_check
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
