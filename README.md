# vothanhdat/tap

Homebrew tap for [MacMon Indicator](https://github.com/vothanhdat/macmon-menubar), a small menu bar
monitor for Apple Silicon Macs (CPU, GPU, RAM, power, temperature, fans, disk).

```bash
brew install --cask vothanhdat/tap/macmon-indicator
```

Then open **MacMon Indicator** and turn on **Settings… → Launch at login**.

- Update: `brew upgrade --cask macmon-indicator`
- Remove: `brew uninstall --cask macmon-indicator` (add `--zap` to also delete history and settings)

The app is ad-hoc signed, not notarized, so the cask clears the quarantine flag after installing
(otherwise macOS would refuse to open it). macmon is included in the app.
