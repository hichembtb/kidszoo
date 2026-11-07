# kidsZoo — Little Wilds

**Little Wilds** is a playful, woodland-themed animal memory matching game built natively with **SwiftUI**. Players flip cards in a 3×4 grid to discover and match woodland animals—foxes, owls, bears, rabbits, raccoons, and hedgehogs—while tracking their total moves, matched pairs, and utilizing an optional hint to find pairs.

---

## Features

- **Cohesive Woodland Theme:** Handcrafted visual identity featuring natural earthy tones, canopy branch overlays, and a mountain landscape background.
- **Card Matching Mechanics:** Smooth 3D flip card animations, turn tracking, match confirmation checkmarks, and celebratory completion banner upon finding all 6 pairs.
- **Single-Use Hint Helper:** Built-in hint capability that briefly reveals unmatched animal cards to assist younger players.
- **Interactive Restart:** Instantly reshuffles the animal deck, resets move counters, and restores hint availability.
- **Modern SwiftUI Architecture:** Uses declarative SwiftUI views, reactive state management (`@State`, `@AppStorage`), and custom design tokens (`WoodlandPalette`).
- **Developer-Friendly Hot Reloading:** Configured with [Inject](https://github.com/krzysztofzablocki/Inject) for instant live view updates when paired with InjectionIII.

---

## Technology Stack

- **Language:** Swift 5.0+
- **UI Framework:** SwiftUI
- **IDE Support:** Xcode 16+ / Visual Studio Code
- **Dependency Management:** Swift Package Manager (SPM)
- **Developer Tooling:** [Inject](https://github.com/krzysztofzablocki/Inject) & [InjectionIII](https://github.com/johnno1962/InjectionIII) (optional hot reloading)

---

## Requirements

- **macOS:** macOS Sonoma or later
- **Xcode:** Xcode compatible with the configured iOS deployment target (iOS 17+)
- **Simulator:** Any available iPhone Simulator runtime
- *(Optional)* **InjectionIII:** Version 4.x+ installed at `/Applications/InjectionIII.app` if you wish to use live code injection.

---

## Installation & Running

### Option 1: Running in Xcode (Standard Workflow)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/hichembtb/kidszoo.git
   cd kidszoo
   ```

2. **Open the project in Xcode:**
   ```bash
   open kidsZoo.xcodeproj
   ```

3. **Resolve dependencies:**
   Xcode will automatically fetch and resolve package dependencies pinned in `Package.resolved` (`Inject` v1.6.0). You can manually trigger this via **File → Packages → Resolve Package Versions**.

4. **Select a Destination & Run:**
   - Choose any available iPhone Simulator from the scheme destination menu (e.g., *iPhone 16 Pro* or *iPhone 18 Pro*).
   - Press **Cmd + R** or click the **Play** button to build and launch the application.

---

### Option 2: Running from VS Code / Terminal

The project includes an automated helper script (`run.sh`) and a configured VS Code task.

1. **Run via terminal:**
   ```bash
   ./run.sh
   ```
   The script dynamically detects an already booted iPhone simulator (or boots an available one), builds the application using `xcodebuild`, installs it, and launches the app.

2. **Run via VS Code shortcut:**
   - Open the repository folder in VS Code.
   - Press **Cmd + Shift + B** (the default build shortcut) to launch the *"Run kidsZoo on iOS Simulator"* task.

---

## Optional: SwiftUI Hot Reloading with InjectionIII

For instant live code reloading without restarting the simulator:

1. **Install InjectionIII:**
   Download and install [InjectionIII](https://github.com/johnno1962/InjectionIII) to `/Applications/InjectionIII.app` (available on the Mac App Store or GitHub Releases).

2. **Launch InjectionIII:**
   Open `InjectionIII.app` from your Applications folder. Ensure it is running in your macOS menu bar.

3. **Open Project Directory:**
   In InjectionIII, select **Open Project** and select this repository's root folder (`kidsZoo`).

4. **Run the App:**
   Start the app using `./run.sh` or through Xcode. In the Xcode console / terminal logs, you will see confirmation that the injection bundle has connected:
   ```text
   💉 InjectionIII connected /Users/...
   💉 Watching ...
   ```

5. **Edit & Save:**
   Modify any SwiftUI view (such as `kidsZoo/mainView.swift`) and press **Cmd + S**. The view will update instantly in the simulator.

> [!NOTE]
> InjectionIII is strictly a local developer convenience. All injection code is wrapped in `#if DEBUG` and is completely disabled in Release builds.

---

## Project Structure

```text
kidsZoo/
├── .vscode/
│   └── tasks.json             # VS Code build task for ./run.sh
├── kidsZoo.xcodeproj/          # Xcode project and workspace configuration
│   ├── project.pbxproj        # Targets, build configurations & SPM references
│   └── xcshareddata/          # Shared schemes and Package.resolved lockfile
├── kidsZoo/
│   ├── kidsZooApp.swift       # Application entry point and injection loader
│   ├── mainView.swift         # Main game container, background layers & layout
│   ├── mainViewAppBar.swift   # Top navigation bar (avatar, title, settings button)
│   ├── matchedItemView.swift  # 3x4 card grid, flip animations, scoring & hint logic
│   ├── WoodlandPalette.swift  # Cohesive color palette definitions
│   └── kidsZoo.xcassets/      # Asset catalog (animal illustrations, cardback, icons)
├── ATTRIBUTION.md             # Third-party asset credits and licensing details
├── run.sh                     # Portable CLI simulator build & launch script
└── .gitignore                 # Comprehensive Xcode, SPM, macOS & VS Code ignore rules
```

---

## Licensing & Attribution

- **Third-Party Assets & Attribution:** See [ATTRIBUTION.md](ATTRIBUTION.md) for detailed credit and source records.
- **Third-Party Libraries:** The `Inject` package is licensed under the [MIT License](https://github.com/krzysztofzablocki/Inject/blob/main/LICENSE).
- **Application Code:** All original application code is subject to repository ownership. No formal open-source license has been attached; please contact the repository owner regarding distribution or commercial use.
