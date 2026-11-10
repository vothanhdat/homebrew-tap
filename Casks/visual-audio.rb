cask "visual-audio" do
  version "0.2.0"
  sha256 "b1fb88203ad8b53f3fa992ce68e304e77c1d4fc388a0d63999e900ee856fafeb"

  url "https://github.com/vothanhdat/mac-audio-visualize/releases/download/v#{version}/VisualAudio-#{version}.zip"
  name "VisualAudio"
  desc "Low-latency audio spectrum visualizer with native system audio capture"
  homepage "https://github.com/vothanhdat/mac-audio-visualize"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  # System audio capture needs macOS 14.2; the app's LSMinimumSystemVersion enforces the point release.
  depends_on macos: :sonoma

  app "VisualAudio.app"

  # The app is ad-hoc signed, not notarized, so macOS would refuse to open a downloaded copy.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/VisualAudio.app"],
        writable_paths: ["{{appdir}}/VisualAudio.app"]
  end

  uninstall quit: "local.visualaudio.app"

  zap trash: "~/Library/Application Support/VisualAudio"

  caveats <<~EOS
    Open VisualAudio and allow System Audio Recording when macOS asks. Because the app
    is ad-hoc signed, macOS may ask again after an update.
  EOS
end
