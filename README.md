# VinFast Companion Clone

This repository contains a **Flutter prototype** that reproduces the UI/UX of the official VinFast Companion app (`com.vinfast.companion.app`).

## What’s inside?
- **Design System** (`UIUX_Roadmap/SKILL.MD`) – colour tokens, spacing, typography, autolayout rules following the Digital‑Arithmetic Colour Law.
- **Flutter token files** – `app_colors.dart` & `app_tokens.dart` exposing the design‑system constants.
- **Roadmap** (`UIUX_Roadmap/Roadmap.md`) – a high‑level navigation diagram (Mermaid) and a table of ~100 screens.
- **Prototype screens** – `SplashScreen`, `OnboardingScreen1`, `LoginScreen`, `HomeScreen`, `DashboardScreen` (in `UIUX_Roadmap/lib/screens/`).
- **CI/CD ready** – ready to be built and tested locally.

## Getting started
```bash
# Clone the repo
git clone https://github.com/wikialisa/vinfast.git
cd vinfast

# Install Flutter (if not already)
flutter doctor

# Install dependencies
flutter pub get

# Run the app (Android/iOS/Web)
flutter run
```

## Contributing
See the [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## License
MIT – see `LICENSE` for details.
