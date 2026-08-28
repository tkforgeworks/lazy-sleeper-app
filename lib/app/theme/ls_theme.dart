// Lazy Sleeper design tokens.
//
// Source of truth: docs/design_handoff_lazy_sleeper/lib/ls_theme.dart (TK ForgeWorks
// design system). This file adapts it for bundled fonts: JetBrains Mono and
// Source Serif 4 ship as variable fonts, which only respond to `wght` through
// [FontVariation], so every mono/serif style carries one alongside [FontWeight].

import 'package:flutter/material.dart';

/// Desktop layout at and above this width (top text-pill nav, drawers);
/// below it: bottom NavigationBar, bottom sheets, stacked cards.
const lsDesktopBreakpoint = 1024.0;

/// Motion: 200ms ease, colour/background only. No entry animations.
const lsDuration = Duration(milliseconds: 200);
const lsCurve = Curves.ease;

abstract class LsFonts {
  static const header = 'Poppins';
  static const body = 'Source Serif 4';
  static const code = 'JetBrains Mono';
}

/// Palette for one brightness. Read it with `context.ls`.
@immutable
class LsColors extends ThemeExtension<LsColors> {
  const LsColors({
    required this.purplePrimary,
    required this.purpleSecondary,
    required this.purpleDark,
    required this.purpleTint,
    required this.forgeYellow,
    required this.forgeOrange,
    required this.forgeRed,
    required this.forgeTint,
    required this.forgeText,
    required this.textPrimary,
    required this.textSecondary,
    required this.background,
    required this.backgroundLight,
    required this.border,
    required this.errorPrimary,
    required this.errorLight,
    required this.errorText,
    required this.successPrimary,
    required this.successLight,
    required this.successText,
    required this.warningPrimary,
    required this.warningLight,
    required this.warningText,
    required this.infoPrimary,
    required this.infoLight,
    required this.infoText,
    required this.onPurple,
    required this.divider,
    required this.track,
    required this.rowHover,
    required this.panicScrim,
  });

  final Color purplePrimary;
  final Color purpleSecondary;

  /// Hover shift for links/pills.
  final Color purpleDark;
  final Color purpleTint;
  final Color forgeYellow;

  /// ForgeModel accent. Never a status colour.
  final Color forgeOrange;
  final Color forgeRed;
  final Color forgeTint;
  final Color forgeText;
  final Color textPrimary;
  final Color textSecondary;
  final Color background;
  final Color backgroundLight;
  final Color border;
  final Color errorPrimary;
  final Color errorLight;
  final Color errorText;
  final Color successPrimary;
  final Color successLight;
  final Color successText;
  final Color warningPrimary;
  final Color warningLight;
  final Color warningText;
  final Color infoPrimary;
  final Color infoLight;
  final Color infoText;

  /// Ink on top of [purplePrimary] fills (buttons, "until you" box).
  final Color onPurple;

  /// Row divider.
  final Color divider;

  /// Subtle tracks (progress, sliders).
  final Color track;
  final Color rowHover;
  final Color panicScrim;

  /// Dark palette: the primary design target.
  static const dark = LsColors(
    purplePrimary: Color(0xFFC495F4),
    purpleSecondary: Color(0xFFA05CF7),
    purpleDark: Color(0xFFD9B5FD),
    purpleTint: Color(0xFF372367),
    forgeYellow: Color(0xFFFBDF19),
    forgeOrange: Color(0xFFF9A03F),
    forgeRed: Color(0xFFF4553F),
    forgeTint: Color(0xFF3A2410),
    forgeText: Color(0xFFFBDF19),
    textPrimary: Color(0xFFE2E8F0),
    textSecondary: Color(0xFFCBD5E1),
    background: Color(0xFF0F172A),
    backgroundLight: Color(0xFF1E293B),
    border: Color(0xFF334155),
    errorPrimary: Color(0xFFF87171),
    errorLight: Color(0xFF450A0A),
    errorText: Color(0xFFFCA5A5),
    successPrimary: Color(0xFF4ADE80),
    successLight: Color(0xFF052E16),
    successText: Color(0xFF86EFAC),
    warningPrimary: Color(0xFFFBBF24),
    warningLight: Color(0xFF451A03),
    warningText: Color(0xFFFCD34D),
    infoPrimary: Color(0xFF38BDF8),
    infoLight: Color(0xFF082F49),
    infoText: Color(0xFF7DD3FC),
    onPurple: Color(0xFF141327),
    divider: Color(0x59334155), // rgba(51,65,85,.35)
    track: Color(0x80334155), // rgba(51,65,85,.5)
    rowHover: Color(0x12C495F4), // rgba(196,149,244,.07)
    panicScrim: Color(0xF70B101D),
  );

  /// Light palette: first-class alternative.
  static const light = LsColors(
    purplePrimary: Color(0xFF8532D6),
    purpleSecondary: Color(0xFF9632F3),
    purpleDark: Color(0xFF601BBC),
    purpleTint: Color(0xFFF2E9FE),
    forgeYellow: Color(0xFFFBDF19),
    forgeOrange: Color(0xFFF68F25),
    forgeRed: Color(0xFFEE3423),
    forgeTint: Color(0xFFFFF3E0),
    forgeText: Color(0xFF9A4A0F),
    textPrimary: Color(0xFF334155),
    textSecondary: Color(0xFF64748B),
    background: Color(0xFFFFFFFF),
    backgroundLight: Color(0xFFF8FAFC),
    border: Color(0xFFE2E8F0),
    errorPrimary: Color(0xFFDC2626),
    errorLight: Color(0xFFFEF2F2),
    errorText: Color(0xFF991B1B),
    successPrimary: Color(0xFF16A34A),
    successLight: Color(0xFFF0FDF4),
    successText: Color(0xFF166534),
    warningPrimary: Color(0xFFD97706),
    warningLight: Color(0xFFFFFBEB),
    warningText: Color(0xFF92400E),
    infoPrimary: Color(0xFF0284C7),
    infoLight: Color(0xFFF0F9FF),
    infoText: Color(0xFF0C4A6E),
    onPurple: Color(0xFFFFFFFF),
    divider: Color(0xFFE2E8F0),
    track: Color(0x80E2E8F0),
    rowHover: Color(0x128532D6), // purplePrimary at .07
    panicScrim: Color(0xF70B101D), // panic mode is dark in both themes
  );

  /// Tokens are fixed per theme; there is nothing to override piecemeal.
  @override
  LsColors copyWith() => this;

  /// Theme changes snap rather than tween: the design has no colour
  /// interpolation between palettes, only the 200ms transitions widgets do
  /// themselves.
  @override
  LsColors lerp(LsColors? other, double t) =>
      other == null || t < 0.5 ? this : other;
}

/// Tier scale, identical in both themes.
abstract class LsTiers {
  static const t1 = Color(0xFFC495F4);
  static const t2 = Color(0xFF38BDF8);
  static const t3 = Color(0xFF4ADE80);
  static const t4 = Color(0xFFFBBF24);
  static const t5 = Color(0xFFF87171);
  static Color of(int tier) => const [t1, t2, t3, t4, t5][tier.clamp(1, 5) - 1];
}

/// Projection-source colours, identical in both themes.
abstract class LsSources {
  static const sleeper = Color(0xFFA05CF7);
  static const espn = Color(0xFF38BDF8);
  static const forge = Color(0xFFF9A03F);
  static const ensemble = Color(0xFFC495F4);
}

abstract class LsGradients {
  /// Logo hammer + panic-mode name ONLY.
  static const forge = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFBDF19), Color(0xFFF68F25), Color(0xFFEE3423)],
    stops: [0.0, 0.52, 1.0],
  );

  /// Logo anvil ONLY.
  static const anvil = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF9632F3), Color(0xFF8532D6), Color(0xFF601BBC)],
    stops: [0.0, 0.52, 1.0],
  );
}

abstract class LsSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
}

abstract class LsRadius {
  static const chip = 4.0; // chips, badges, availability cells
  static const segment = 6.0; // segmented tabs, slot chips, alt chips
  static const card = 8.0; // cards, buttons, alerts
  static const frame = 12.0; // screen frames
  static const sheet = 22.0; // mobile bottom sheet top corners
  static const full = 999.0; // capsules, tracks
}

/// [FontVariation] list for a weight, for the variable fonts.
List<FontVariation> lsWeight(FontWeight weight) => [
  FontVariation.weight(weight.value.toDouble()),
];

/// Text styles from the designs (colours applied at call site).
abstract class LsText {
  // Poppins (static weights): FontWeight is enough.
  static const screenTitle = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  static const drawerName = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const recName = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );
  static const panicName = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 64,
    fontWeight: FontWeight.w800,
    height: 1.05,
  );
  static const rowTitle = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
  );
  static const navPill = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
  );
  static const button = TextStyle(
    fontFamily: LsFonts.header,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // JetBrains Mono (variable): needs the wght axis.
  static const dataCell = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontVariations: [FontVariation('wght', 400)],
  );
  static const dataCellBold = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
  );
  static const statValue = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 21,
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation('wght', 700)],
  );
  static const timer = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.1,
    fontVariations: [FontVariation('wght', 700)],
  );
  static const microLabel = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    fontVariations: [FontVariation('wght', 600)],
  );
  static const caption = TextStyle(
    fontFamily: LsFonts.code,
    fontSize: 10.5,
    fontWeight: FontWeight.w400,
    fontVariations: [FontVariation('wght', 400)],
  );

  // Source Serif 4 italic (variable): the app's editorial voice.
  static const aside = TextStyle(
    fontFamily: LsFonts.body,
    fontSize: 13,
    fontStyle: FontStyle.italic,
    height: 1.5,
    fontVariations: [FontVariation('wght', 400)],
  );
}

ThemeData lsDarkTheme() => _theme(LsColors.dark, Brightness.dark);

ThemeData lsLightTheme() => _theme(LsColors.light, Brightness.light);

ThemeData _theme(LsColors c, Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final surface = dark ? c.backgroundLight : c.background;
  final scheme = ColorScheme(
    brightness: brightness,
    primary: c.purplePrimary,
    onPrimary: c.onPurple,
    secondary: c.forgeOrange,
    onSecondary: c.onPurple,
    surface: surface,
    onSurface: c.textPrimary,
    error: c.errorPrimary,
    onError: c.onPurple,
    outline: c.border,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: dark ? c.background : c.backgroundLight,
    dividerColor: c.divider,
    fontFamily: LsFonts.header,
    splashFactory: NoSplash.splashFactory, // motion is colour-only
    navigationBarTheme: NavigationBarThemeData(
      height: 64,
      backgroundColor: surface,
      indicatorColor: c.purpleTint,
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(LsRadius.segment)),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => LsText.navPill.copyWith(
          color: states.contains(WidgetState.selected)
              ? c.purplePrimary
              : c.textSecondary,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          size: 22,
          color: states.contains(WidgetState.selected)
              ? c.purplePrimary
              : c.textSecondary,
        ),
      ),
    ),
    extensions: [c],
  );
}

extension LsThemeContext on BuildContext {
  /// The Lazy Sleeper palette for the current theme.
  LsColors get ls => Theme.of(this).extension<LsColors>()!;

  /// Desktop (at least 1024 dp) vs mobile layout.
  bool get isDesktop => MediaQuery.sizeOf(this).width >= lsDesktopBreakpoint;
}
