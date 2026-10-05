# Prototype Screens Overview

This README provides a brief summary of the seven Flutter screen prototypes generated for the app.

| Screen | Description | Key Widgets / Layout |
|--------|-------------|----------------------|
| **SplashScreen** | Simple entry screen with centered title. | `Scaffold` with background color `AppColors.primary100` and centered `Text`.
| **OnboardingScreen1** | First onboarding page introducing the app. | `Scaffold`, `Image.asset`, title & subtitle `Text`, and a `Next` `ElevatedButton`. Uses `AppTokens` for padding and spacing.
| **LoginScreen** | Basic login form. | `Scaffold`, `TextField` for email & password, `ElevatedButton` for sign‑in, and a `TextButton` for password recovery.
| **HomeScreen** | Main navigation hub after login. | `Scaffold` with `AppBar`, a `ListView` of `Card` widgets (Profile, Settings, Logout).
| **DashboardScreen** | Grid dashboard showcasing widgets. | `Scaffold` with `AppBar`, `GridView.count` displaying four placeholder cards.
| **BatteryDetailScreen** | Displays current battery level and estimated range. | `Scaffold` with `AppBar`, `Card` containing `LinearProgressIndicator` (78 %) and a `Refresh` `ElevatedButton.icon`. Uses `AppColors.primary100` card background and `AppTokens.spacingLg` padding.
| **MapScreen** | Placeholder map view with a location FAB. | `Scaffold` with `AppBar`, full-screen `Container` placeholder for a map widget (e.g., GoogleMap), and a `FloatingActionButton` (my_location icon) anchored bottom-right via `Stack`/`Positioned`.
| **RemoteControlScreen** | Grid of four remote-control action buttons. | `Scaffold` with `AppBar`, `GridView.count` (2 columns) of `_RemoteButton` widgets for Lock/Unlock, Lights, Climate, and Horn actions. Uses `AppColors.secondary600` for button colour.

All screens make use of the design token constants defined in `lib/theme/app_colors.dart` and `lib/theme/app_tokens.dart` for consistent theming and spacing.
