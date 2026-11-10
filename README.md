# vothanhdat/tap

Homebrew tap for Apple Silicon Mac apps. Both apps are ad-hoc signed, not notarized, so each cask
clears the quarantine flag after installing (otherwise macOS would refuse to open them).

## MacMon Indicator

[MacMon Indicator](https://github.com/vothanhdat/macmon-menubar) is a small menu bar monitor
(CPU, GPU, RAM, power, temperature, fans, disk).

```bash
brew install --cask vothanhdat/tap/macmon-indicator
```

Then open **MacMon Indicator** and turn on **Settings… → Launch at login**.

- Update: `brew upgrade --cask macmon-indicator`
- Remove: `brew uninstall --cask macmon-indicator` (add `--zap` to also delete history and settings)

macmon is included in the app.

## VisualAudio

[VisualAudio](https://github.com/vothanhdat/mac-audio-visualize) is a low-latency audio spectrum
visualizer that captures system audio without a virtual audio driver. Requires macOS 14.2 or newer.

```bash
brew install --cask vothanhdat/tap/visual-audio
```

Then open **VisualAudio** and allow **System Audio Recording** when macOS asks. Because the app is
ad-hoc signed, macOS may ask again after an update.

- Update: `brew upgrade --cask visual-audio`
- Remove: `brew uninstall --cask visual-audio` (add `--zap` to also delete settings)
