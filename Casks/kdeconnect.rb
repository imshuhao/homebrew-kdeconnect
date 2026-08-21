cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # Each arch tracks its own build: KDE's CI retains only the latest DMG per
  # arch and the two can publish a few minutes apart, so a single shared
  # version would 404 for the lagging arch during that window.
  on_arm do
    version "6510"
    sha256 "77ef9d6f38e65b24654584181b06d42a23201643358d2c0c2e8dde2524aaa41f"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
  end
  on_intel do
    version "6510"
    sha256 "5671f75e069ab74b15c20649600a959f74ee007ae78b3b35c91b0baaf0991d38"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-#{version}-macos-clang-x86_64.dmg"
  end

  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-#{arch}/"
    regex(/kdeconnect-kde-master-(\d+)-macos.*?#{arch}\.dmg/i)
    strategy :page_match
  end

  depends_on macos: :ventura

  app "KDE Connect.app"

  zap trash: [
    "~/Library/Application Support/kdeconnect.app",
    "~/Library/Application Support/kpeoplevcard/kdeconnect-*",
    "~/Library/Caches/kdeconnect",
    "~/Library/Logs/kdeconnect",
    "~/Library/Preferences/kdeconnect",
    "~/Library/Preferences/org.kde.kdeconnect.plist",
    "~/Library/Saved Application State/org.kde.kdeconnect.savedState",
  ]
end
