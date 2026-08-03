cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # Each arch tracks its own build: KDE's CI retains only the latest DMG per
  # arch and the two can publish a few minutes apart, so a single shared
  # version would 404 for the lagging arch during that window.
  on_arm do
    version "6453"
    sha256 "d4f532b6dbad0c58a842a3352e75d0f734a3b6a330431da01fbc7e4225e83231"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
  end
  on_intel do
    version "6453"
    sha256 "5bf65951d2909c1a088ea3eb8e63535a41ae706b317906e2e096811c09ce8c6d"

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
