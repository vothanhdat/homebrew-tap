cask "macmon-indicator" do
  version "0.1.5"
  sha256 "28fa7e14e3d9c4a435445cd4aec2600657c64f443ab4f00e1ea35412a6bc16ab"

  url "https://github.com/vothanhdat/macmon-menubar/releases/download/v#{version}/MacMon-Indicator-#{version}.zip"
  name "MacMon Indicator"
  desc "Menu bar monitor for CPU, GPU, RAM, power, temperature, fans and disk"
  homepage "https://github.com/vothanhdat/macmon-menubar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "MacMon Indicator.app"

  # The app is ad-hoc signed, not notarized, so macOS would refuse to open a downloaded copy.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MacMon Indicator.app"],
        writable_paths: ["{{appdir}}/MacMon Indicator.app"]
  end

  # The optional root helper (Settings → Show system processes). Removing it needs an admin
  # password, so only ask when it is installed.
  uninstall_postflight_steps do
    if_path_exists "/Library/LaunchDaemons/local.MacMonIndicator.helper.plist" do
      run "/bin/launchctl",
          args:         ["bootout", "system/local.MacMonIndicator.helper"],
          sudo:         true,
          must_succeed: false
      remove ["/Library/LaunchDaemons/local.MacMonIndicator.helper.plist",
              "/Library/PrivilegedHelperTools/local.MacMonIndicator.helper"],
             sudo: true
    end
  end

  uninstall quit: "local.MacMonIndicator"

  zap trash: [
    "~/Library/Application Support/MacMonIndicator",
    "~/Library/Preferences/local.MacMonIndicator.plist",
  ]
end
