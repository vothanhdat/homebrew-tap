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

  # The app is ad-hoc signed, not notarized, so macOS would refuse to open a downloaded copy.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/iQualize.app"],
        writable_paths: ["{{appdir}}/iQualize.app"]
  end

  uninstall quit: "codes.darius.iqualize"

  zap trash: [
    "~/Library/Application Support/iQualize",
    "~/Library/Caches/codes.darius.iqualize",
    "~/Library/Preferences/codes.darius.iqualize.plist",
    "~/Library/Saved Application State/codes.darius.iqualize.savedState",
  ]

  caveats <<~EOS
    iQualize needs macOS 14.2 or later. Open iQualize and allow System Audio
    Recording when macOS asks; Room Correction also asks for the microphone the
    first time you measure. Because the app is ad-hoc signed, macOS may ask again
    after an update.
  EOS
end
