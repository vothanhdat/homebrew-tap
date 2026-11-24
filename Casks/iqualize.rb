cask "iqualize" do
  version "0.64.0"
  sha256 "bc57bb1d2779eddb44f5a1e9d8782e272b42980ae8a782e7ab5434a846349038"

  url "https://github.com/vothanhdat/iqualize/releases/download/v#{version}/iQualize-#{version}.dmg"
  name "iQualize"
  desc "System-wide parametric equalizer with microphone room correction"
  homepage "https://github.com/vothanhdat/iqualize"

  livecheck do
    url :url
    strategy :github_latest
  end

  # System audio capture needs macOS 14.2; Homebrew can only express Sonoma, so the caveats say so.
  depends_on macos: :sonoma

  app "iQualize.app"
  binary "#{appdir}/iQualize.app/Contents/Resources/bin/iqualize"

  uninstall quit: "codes.darius.iqualize"

  zap trash: [
    "~/Library/Application Support/iQualize",
    "~/Library/Caches/codes.darius.iqualize",
    "~/Library/Preferences/codes.darius.iqualize.plist",
    "~/Library/Saved Application State/codes.darius.iqualize.savedState",
  ]

  # Ad-hoc signed, not notarized. The quarantine flag is left for the user to clear (see caveats).
  caveats <<~EOS
    iQualize needs macOS 14.2 or later.

    iQualize is ad-hoc signed and not notarized by Apple, so macOS may say it is
    damaged or can't be checked for malware the first time you open it. If it
    does, clear the quarantine flag that macOS puts on downloads:

      xattr -dr com.apple.quarantine /Applications/iQualize.app
  EOS
end
