# Razer macOS

Razer macOS is an open-source macOS control app for Razer peripherals. This fork is now moving away from the legacy Electron shell and toward a native SwiftUI/AppKit app backed by the existing `librazermacos` IOKit/HID driver code.

The current development focus is practical macOS support for newer Razer devices imported from OpenRazer, starting with the Razer DeathAdder V3 Pro.

## Current Status

- Native SwiftUI/AppKit app shell in `NativeRazerMacOS`
- macOS menu-bar resident app with a persistent status item
- Native settings window with Launch at Login support through `ServiceManagement`
- Native device controls for DPI and polling rate
- Battery/status display when the bridge can read it from hardware
- C bridge from Swift into `librazermacos`
- Refreshed device catalog under `src/devices` with 267 device JSON profiles
- Legacy Electron app retained as a reference implementation and fallback

The native app currently targets:

| Device | Product ID | Native controls |
| --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | Discovery, DPI, polling rate, battery/status |

## Known Hardware Limitation

On the current test machine, the native bridge and the legacy Node addon both detect the DeathAdder V3 Pro through `librazermacos`.

The native hardware probe reports:

```text
productId=0x00B7 internalDeviceId=0 dpi=0 pollingRate=0
count=1
```

The device is detected, but DPI, polling-rate, and battery readback commands can still time out on this hardware path. The native UI therefore uses safe default values when readback returns `0`, clearly reports that settings readback timed out, and only reports write commands as sent through the bridge.

## Native App

Build and open the native app:

```sh
./script/build_and_run.sh
```

Build, open, and verify the app process starts:

```sh
./script/build_and_run.sh --verify
```

Scan connected Razer mice through the native C bridge:

```sh
./script/build_and_run.sh --scan-hardware
```

Run Swift tests:

```sh
swift test --package-path NativeRazerMacOS
```

The native app keeps running after its main window is closed. Reopen it from the menu-bar item, Dock, or the Razer command menu. Launch at Login is available from the native Settings window.

## Legacy Electron App

The original Electron app remains in the repository while the native app catches up feature by feature. It still provides the historical menu-bar UI, color effects, state management, and broader device coverage.

Install Node dependencies:

```sh
yarn
```

Run the Electron development app:

```sh
yarn dev
```

Rebuild the native Node addon after driver changes:

```sh
yarn rebuild
```

Compile the Electron app:

```sh
yarn compile
```

Build a distribution package:

```sh
yarn dist
```

## Architecture

The repository currently has two application layers over the same driver lineage:

- `NativeRazerMacOS/` contains the new SwiftUI/AppKit macOS app.
- `NativeRazerMacOS/Sources/NativeRazerBridgeC/` exposes the C driver functions to Swift.
- `librazermacos/` contains the low-level Razer USB/HID protocol implementation.
- `src/` contains the legacy Electron UI, state manager, menu-bar app, and Node addon integration.
- `src/devices/` contains device profiles imported and maintained from OpenRazer and the previous razer-macos work.

Long-term, the SwiftUI/AppKit app should become the primary macOS UI because it fits menu-bar behavior, Launch at Login, signing, notarization, and IOKit/HID integration more naturally than Electron.

## Device Support Policy

New-device support should be grounded in OpenRazer device definitions, then verified on real hardware whenever possible. For devices not physically available, the repo can import identifiers and capability metadata, but UI controls should stay conservative until a matching hardware path is tested.

For the DeathAdder V3 Pro path, the next driver-level task is improving or replacing the timed-out settings readback commands for DPI, polling rate, and battery state.

## Installation Notes

Packaged, signed, and notarized native builds are not complete yet. For local development, run from source with `./script/build_and_run.sh`.

The legacy Electron packaging flow still supports ad-hoc signing:

```sh
codesign -s - --deep --force ./dist/mac-universal/Razer\ macOS.app
```

## Credits

This project builds on work from:

- [1kc/razer-macos](https://github.com/1kc/razer-macos)
- [openrazer/openrazer](https://github.com/openrazer/openrazer)
- [osx-razer-blade](https://github.com/kprinssu/osx-razer-blade)
- [osx-razer-led](https://github.com/dylanparker/osx-razer-led)
