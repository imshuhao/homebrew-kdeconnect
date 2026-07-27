cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # Each arch tracks its own build: KDE's CI retains only the latest DMG per
  # arch and the two can publish a few minutes apart, so a single shared
  # version would 404 for the lagging arch during that window.
  on_arm do
    version "6423"
    sha256 "6e5e48b22e5df813aa3d87d2a74ac74ad234b85154702d430a27257770532b6d"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
  end
  on_intel do
    version "6423"
    sha256 "0e02b320554fdf53371a4fc0ad66abb01719a5b925128bd435e0966edf628e40"

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
