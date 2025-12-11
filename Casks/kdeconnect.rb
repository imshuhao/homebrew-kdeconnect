cask "kdeconnect" do
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"
  version "5602"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/"
    regex(/kdeconnect-kde-master-(\d+)-macos-clang-arm64\.dmg/)
    strategy :page_match
  end

  depends_on macos: ">= :monterey"

  on_macos do
    if Hardware::CPU.arm?
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-5602-macos-clang-arm64.dmg"
      sha256 "f5ab3bd5c7963d512f30d9f4d93822d6f6c1db25cf6ba83e3a2daadbf32919d5"
    else
      url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-5602-macos-clang-x86_64.dmg"
      sha256 "ae412cb2f810347cfad0e33cfa5f1373828d6d7c40d31551add7acf8ea30e1da"
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
