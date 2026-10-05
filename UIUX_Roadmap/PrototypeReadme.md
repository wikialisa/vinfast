# Prototype Screens Overview

This README provides a brief summary of the five Flutter screen prototypes generated for the app.

| Screen | Description | Key Widgets / Layout |
|--------|-------------|----------------------|
| **SplashScreen** | Simple entry screen with centered title. | `Scaffold` with background color `AppColors.primary100` and centered `Text`.
| **OnboardingScreen1** | First onboarding page introducing the app. | `Scaffold`, `Image.asset`, title & subtitle `Text`, and a `Next` `ElevatedButton`. Uses `AppTokens` for padding and spacing.
| **LoginScreen** | Basic login form. | `Scaffold`, `TextField` for email & password, `ElevatedButton` for sign‑in, and a `TextButton` for password recovery.
| **HomeScreen** | Main navigation hub after login. | `Scaffold` with `AppBar`, a `ListView` of `Card` widgets (Profile, Settings, Logout).
| **DashboardScreen** | Grid dashboard showcasing widgets. | `Scaffold` with `AppBar`, `GridView.count` displaying four placeholder cards.

All screens make use of the design token constants defined in `lib/theme/app_colors.dart` and `lib/theme/app_tokens.dart` for consistent theming and spacing.
