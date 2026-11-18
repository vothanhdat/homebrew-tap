cask "visual-audio" do
  version "0.3.0"
  sha256 "1951aa44a3c8ba968687c7e7c6147a6b8a72055b93379fa52d0e4d70bdfef9d3"

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
