// ls_theme.dart — Lazy Sleeper design tokens
// Source: TK ForgeWorks design system (colors_and_type.css) + Lazy Sleeper HTML designs.
// Fonts: Poppins (UI/headers), Source Serif 4 (editorial asides), JetBrains Mono (data).
// Load via google_fonts or bundle the ttf files from design_reference/fonts/.

import 'package:flutter/material.dart';

/// Dark palette — the primary design target.
abstract class LsColorsDark {
  static const purplePrimary = Color(0xFFC495F4);
  static const purpleSecondary = Color(0xFFA05CF7);
  static const purpleDark = Color(0xFFD9B5FD); // hover shift on dark
  static const purpleTint = Color(0xFF372367);
  static const forgeYellow = Color(0xFFFBDF19);
  static const forgeOrange = Color(0xFFF9A03F); // ForgeModel accent — never status
  static const forgeRed = Color(0xFFF4553F);
  static const forgeTint = Color(0xFF3A2410);
  static const forgeText = Color(0xFFFBDF19);
  static const textPrimary = Color(0xFFE2E8F0);
  static const textSecondary = Color(0xFFCBD5E1);
  static const background = Color(0xFF0F172A);
  static const backgroundLight = Color(0xFF1E293B);
  static const border = Color(0xFF334155);
  static const errorPrimary = Color(0xFFF87171);
  static const errorLight = Color(0xFF450A0A);
  static const errorText = Color(0xFFFCA5A5);
  static const successPrimary = Color(0xFF4ADE80);
  static const successLight = Color(0xFF052E16);
  static const successText = Color(0xFF86EFAC);
  static const warningPrimary = Color(0xFFFBBF24);
  static const warningLight = Color(0xFF451A03);
  static const warningText = Color(0xFFFCD34D);
  static const infoPrimary = Color(0xFF38BDF8);
  static const infoLight = Color(0xFF082F49);
  static const infoText = Color(0xFF7DD3FC);
  /// Ink used on top of purplePrimary fills (buttons, "until you" box).
  static const onPurple = Color(0xFF141327);
  /// Row divider / subtle tracks.
  static const divider = Color(0x59334155); // rgba(51,65,85,.35)
  static const track = Color(0x80334155); // rgba(51,65,85,.5)
  static const rowHover = Color(0x12C495F4); // rgba(196,149,244,.07)
  static const panicScrim = Color(0xF70B101D);
}

/// Light palette — first-class alternative.
abstract class LsColorsLight {
  static const purplePrimary = Color(0xFF8532D6);
  static const purpleSecondary = Color(0xFF9632F3);
  static const purpleDark = Color(0xFF601BBC);
  static const purpleTint = Color(0xFFF2E9FE);
  static const forgeYellow = Color(0xFFFBDF19);
  static const forgeOrange = Color(0xFFF68F25);
  static const forgeRed = Color(0xFFEE3423);
  static const forgeTint = Color(0xFFFFF3E0);
  static const forgeText = Color(0xFF9A4A0F);
  static const textPrimary = Color(0xFF334155);
  static const textSecondary = Color(0xFF64748B);
  static const background = Color(0xFFFFFFFF);
  static const backgroundLight = Color(0xFFF8FAFC);
  static const border = Color(0xFFE2E8F0);
  static const errorPrimary = Color(0xFFDC2626);
  static const errorLight = Color(0xFFFEF2F2);
  static const errorText = Color(0xFF991B1B);
  static const successPrimary = Color(0xFF16A34A);
  static const successLight = Color(0xFFF0FDF4);
  static const successText = Color(0xFF166534);
  static const warningPrimary = Color(0xFFD97706);
  static const warningLight = Color(0xFFFFFBEB);
  static const warningText = Color(0xFF92400E);
  static const infoPrimary = Color(0xFF0284C7);
  static const infoLight = Color(0xFFF0F9FF);
  static const infoText = Color(0xFF0C4A6E);
  static const onPurple = Color(0xFFFFFFFF);
}

/// App-specific scales — identical in both themes.
abstract class LsTiers {
  static const t1 = Color(0xFFC495F4);
  static const t2 = Color(0xFF38BDF8);
  static const t3 = Color(0xFF4ADE80);
  static const t4 = Color(0xFFFBBF24);
  static const t5 = Color(0xFFF87171);
  static Color of(int tier) => const [t1, t2, t3, t4, t5][tier.clamp(1, 5) - 1];
}

abstract class LsSources {
  static const sleeper = Color(0xFFA05CF7);
  static const espn = Color(0xFF38BDF8);
  static const forge = Color(0xFFF9A03F);
  static const ensemble = Color(0xFFC495F4);
}

abstract class LsGradients {
  /// Logo hammer + panic-mode name ONLY.
  static const forge = LinearGradient(
    begin: Alignment.centerLeft, end: Alignment.centerRight,
    colors: [Color(0xFFFBDF19), Color(0xFFF68F25), Color(0xFFEE3423)],
    stops: [0.0, 0.52, 1.0],
  );
  /// Logo anvil ONLY.
  static const anvil = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color(0xFF9632F3), Color(0xFF8532D6), Color(0xFF601BBC)],
    stops: [0.0, 0.52, 1.0],
  );
}

abstract class LsSpacing {
  static const xs = 4.0, sm = 8.0, md = 12.0, lg = 16.0, xl = 20.0, xxl = 24.0;
}

abstract class LsRadius {
  static const chip = 4.0; // chips, badges, availability cells
  static const segment = 6.0; // segmented tabs, slot chips, alt chips
  static const card = 8.0; // cards, buttons, alerts
  static const frame = 12.0; // screen frames
  static const sheet = 22.0; // mobile bottom sheet top corners
  static const full = 999.0; // capsules, tracks
}

abstract class LsFonts {
  static const header = 'Poppins';
  static const body = 'Source Serif 4';
  static const code = 'JetBrains Mono';
}

/// Text styles from the designs (colors applied at call site).
abstract class LsText {
  static const screenTitle = TextStyle(fontFamily: LsFonts.header, fontSize: 15, fontWeight: FontWeight.w700);
  static const drawerName = TextStyle(fontFamily: LsFonts.header, fontSize: 20, fontWeight: FontWeight.w600);
  static const recName = TextStyle(fontFamily: LsFonts.header, fontSize: 26, fontWeight: FontWeight.w700, height: 1.15);
  static const panicName = TextStyle(fontFamily: LsFonts.header, fontSize: 64, fontWeight: FontWeight.w800, height: 1.05);
  static const rowTitle = TextStyle(fontFamily: LsFonts.header, fontSize: 12.5, fontWeight: FontWeight.w500);
  static const navPill = TextStyle(fontFamily: LsFonts.header, fontSize: 12.5, fontWeight: FontWeight.w500);
  static const button = TextStyle(fontFamily: LsFonts.header, fontSize: 14, fontWeight: FontWeight.w600);
  static const dataCell = TextStyle(fontFamily: LsFonts.code, fontSize: 12, fontWeight: FontWeight.w400);
  static const dataCellBold = TextStyle(fontFamily: LsFonts.code, fontSize: 12, fontWeight: FontWeight.w600);
  static const statValue = TextStyle(fontFamily: LsFonts.code, fontSize: 21, fontWeight: FontWeight.w700);
  static const timer = TextStyle(fontFamily: LsFonts.code, fontSize: 32, fontWeight: FontWeight.w700, height: 1.1);
  static const microLabel = TextStyle(fontFamily: LsFonts.code, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.8);
  static const caption = TextStyle(fontFamily: LsFonts.code, fontSize: 10.5, fontWeight: FontWeight.w400);
  static const aside = TextStyle(fontFamily: LsFonts.body, fontSize: 13, fontStyle: FontStyle.italic, height: 1.5);
}

/// Motion: 200ms ease, color/background only. No entry animations.
const lsDuration = Duration(milliseconds: 200);
const lsCurve = Curves.ease;

/// Desktop layout at and above this width.
const lsDesktopBreakpoint = 1024.0;

ThemeData lsDarkTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: LsColorsDark.background,
      colorScheme: const ColorScheme.dark(
        primary: LsColorsDark.purplePrimary,
        onPrimary: LsColorsDark.onPurple,
        secondary: LsColorsDark.forgeOrange,
        surface: LsColorsDark.backgroundLight,
        onSurface: LsColorsDark.textPrimary,
        error: LsColorsDark.errorPrimary,
        outline: LsColorsDark.border,
      ),
      dividerColor: LsColorsDark.divider,
      fontFamily: LsFonts.header,
      useMaterial3: true,
    );

ThemeData lsLightTheme() => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: LsColorsLight.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: LsColorsLight.purplePrimary,
        onPrimary: LsColorsLight.onPurple,
        secondary: LsColorsLight.forgeOrange,
        surface: LsColorsLight.background,
        onSurface: LsColorsLight.textPrimary,
        error: LsColorsLight.errorPrimary,
        outline: LsColorsLight.border,
      ),
      dividerColor: LsColorsLight.border,
      fontFamily: LsFonts.header,
      useMaterial3: true,
    );
