# Contributing to VinFast Companion Clone

Thank you for your interest in improving this project! Below is a quick guide to help you get started.

## 📋 Prerequisites
- **Flutter SDK** (≥ 3.22) installed – run `flutter doctor` to verify.
- **Git** installed and configured with your GitHub account.
- Familiarity with the repository’s **design‑system** (see `UIUX_Roadmap/SKILL.MD`).

## 🛠️ Development workflow
1. **Fork the repository** (click the *Fork* button on GitHub). 
2. **Clone your fork**:
   ```bash
   git clone https://github.com/<your‑username>/vinfast.git
   cd vinfast
   ```
3. **Create a new branch** for your feature or bug‑fix:
   ```bash
   git checkout -b <feature‑or‑bug‑name>
   ```
4. **Make changes** – add/modify code, documentation, or assets.
5. **Run the tests / lint** (optional but encouraged):
   ```bash
   flutter analyze
   flutter test   # if test suite exists
   ```
6. **Commit** using a clear, conventional message:
   ```bash
   git add .
   git commit -m "feat: description of the change"
   ```
7. **Push** to your fork and open a Pull Request:
   ```bash
   git push origin <feature‑or‑bug‑name>
   ```
   Then go to the GitHub UI and create a PR against the `main` branch of the upstream `wikialisa/vinfast` repo.

## ✅ Pull‑request checklist
- [ ] **Code follows the design system** – use tokens from `app_colors.dart` / `app_tokens.dart`.
- [ ] **All new/modified Dart files are formatted** (`dart format .`).
- [ ] **Static analysis passes** (`flutter analyze`).
- [ ] **Update documentation** if you added new screens or components (e.g., update `UIUX_Roadmap/Roadmap.md` or `SKILL.MD`).
- [ ] **Add unit / widget tests** for new logic where appropriate (see `test/` folder).
- [ ] **Screens are responsive** – test on at least one mobile and one web device.

## 📚 Resources
- **Design System** – `UIUX_Roadmap/SKILL.MD`
- **Flutter documentation** – https://flutter.dev/docs
- **GitHub Flow** – https://docs.github.com/en/get-started/quickstart/github-flow

## 🗺️ Project layout
```
vinfast/
├─ UIUX_Roadmap/
│  ├─ SKILL.MD               # design system definition
│  ├─ Roadmap.md             # screen roadmap & Mermaid diagram
│  └─ lib/
│     ├─ theme/
│     │   ├─ app_colors.dart   # colour tokens
│     │   └─ app_tokens.dart   # spacing/radius/elevation tokens
│     └─ screens/             # Flutter screen widgets
└─ README.md                 # repository overview (this file)
```

---
*Happy coding!*
