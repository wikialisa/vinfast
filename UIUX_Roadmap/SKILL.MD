# Design System – SKILL.md

## Digital‑Arithmetic Colour Law
The colour palette follows the rule that the sum of the RGB components of each colour must be divisible by **9**. This ensures a mathematically harmonious set of colours.

### Colour Tokens
| Token | Hex | RGB | Sum | Divisible by 9 |
|-------|-----|-----|-----|----------------|
| **primary**   | `#336699` | (51,102,153) | 306 | ✅ |
| **secondary** | `#669933` | (102,153,51) | 306 | ✅ |
| **accent**    | `#CC3333` | (204,51,51)  | 306 | ✅ |
| **background**| `#D8D8D8` | (216,216,216)| 648 | ✅ |
| **surface**   | `#FFFFFF` | (255,255,255)| 765 | ✅ |
| **onPrimary** | `#FFFFFF` | (255,255,255)| 765 | ✅ |
| **onBackground**| `#333333`| (51,51,51)   | 153 | ✅ |

### Spacing Tokens (px)
```dart
const double spacing0 = 0.0;
const double spacing1 = 4.0;
const double spacing2 = 8.0;
const double spacing3 = 12.0;
const double spacing4 = 16.0;
const double spacing5 = 24.0;
const double spacing6 = 32.0;
const double spacing7 = 40.0;
const double spacing8 = 48.0;
const double spacing9 = 64.0;
```

### Radius Tokens (px)
```dart
const double radiusNone = 0.0;
const double radiusSmall = 4.0;
const double radiusMedium = 8.0;
const double radiusLarge = 16.0;
const double radiusPill = 9999.0; // full pill shape
```

### Elevation Tokens (dp)
```dart
const double elevation0 = 0.0;
const double elevation1 = 1.0;
const double elevation2 = 2.0;
const double elevation3 = 4.0;
const double elevation4 = 8.0;
```

### Typography Tokens
- **Font family**: `Inter`
- **Weights**: `FontWeight.w400` (Regular), `FontWeight.w500` (Medium), `FontWeight.w700` (Bold)
```dart
const double fontSizeXS = 12.0;
const double fontSizeSM = 14.0;
const double fontSizeMD = 16.0;
const double fontSizeLG = 20.0;
const double fontSizeXL = 24.0;
const double fontSizeXXL = 32.0;
```

### Autolayout Constraints
- **Grid columns**: 12
- **Gutter width**: 16 px
- **Margin**: 24 px (horizontal), 16 px (vertical)
- **Breakpoint widths**: 
  - xs: ≤ 599 px
  - sm: 600‑839 px
  - md: 840‑1079 px
  - lg: 1080‑1439 px
  - xl: ≥ 1440 px

These tokens are exported as `const` values in the Flutter files under `lib/theme/`.
