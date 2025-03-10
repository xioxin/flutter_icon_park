import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconParkThemeType { outline, filled, twoTone, multiColor }

typedef IconParkSvgBuilder = String Function(IconParkProps props);

typedef IconParkThemeTypeMap = Map<IconParkThemeType, IconParkProps>;

String? colorToCssRgba(Color? color) {
  if (color == null) return null;
  return 'rgba(${(color.r * 255).toStringAsFixed(0)}, ${(color.g * 255).toStringAsFixed(0)}, ${(color.b * 255).toStringAsFixed(0)}, ${color.a.toStringAsFixed(4)})';
}

class IconParkProps {
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;

  final double? strokeWidth;
  final StrokeJoin? strokeLineJoin;
  final StrokeCap? strokeLineCap;
  final IconParkThemeType theme;

  const IconParkProps({
    this.color1 = const Color(0x00000000),
    this.color2 = const Color(0x00000000),
    this.color3 = const Color(0x00000000),
    this.color4 = const Color(0x00000000),
    this.strokeWidth,
    this.strokeLineJoin,
    this.strokeLineCap,
    this.theme = IconParkThemeType.outline,
  });

  String get c1 => colorToCssRgba(color1)!;

  String get c2 => colorToCssRgba(color2)!;

  String get c3 => colorToCssRgba(color3)!;

  String get c4 => colorToCssRgba(color4)!;

  static IconParkProps outline(
    Color fill, {
    Color background = const Color(0x00000000),
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
  }) {
    return IconParkProps(
      color1: fill,
      color2: background,
      color3: fill,
      color4: background,
      theme: IconParkThemeType.outline,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
    );
  }

  static IconParkProps filled(
    Color fill,
    Color innerStroke, {
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
  }) {
    return IconParkProps(
      color1: fill,
      color2: fill,
      color3: innerStroke,
      color4: innerStroke,
      theme: IconParkThemeType.filled,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
    );
  }

  static IconParkProps twoTone(
    Color fill,
    Color twoTone, {
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
  }) {
    return IconParkProps(
      color1: fill,
      color2: twoTone,
      color3: fill,
      color4: twoTone,
      theme: IconParkThemeType.twoTone,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
    );
  }

  static IconParkProps multiColor(
    Color outStrokeColor,
    Color outFillColor,
    Color innerStrokeColor,
    Color innerFillColor, {
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
  }) {
    return IconParkProps(
      color1: outStrokeColor,
      color2: outFillColor,
      color3: innerStrokeColor,
      color4: innerFillColor,
      theme: IconParkThemeType.multiColor,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
    );
  }

  static IconParkProps fromColorScheme(
    ColorScheme colorScheme,
    IconParkThemeType type, {
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
  }) {
    switch (type) {
      case IconParkThemeType.outline:
        return IconParkProps.outline(
          outStrokeColor ?? colorScheme.onSurface,
          background: outFillColor ?? Colors.transparent,
          strokeWidth: strokeWidth,
          strokeLineJoin: strokeLineJoin,
          strokeLineCap: strokeLineCap,
        );
      case IconParkThemeType.filled:
        return IconParkProps.filled(
          outStrokeColor ?? colorScheme.onSurface,
          innerStrokeColor ?? colorScheme.onPrimary,
          strokeWidth: strokeWidth,
          strokeLineJoin: strokeLineJoin,
          strokeLineCap: strokeLineCap,
        );
      case IconParkThemeType.twoTone:
        return IconParkProps.twoTone(
          outStrokeColor ?? colorScheme.onSurface,
          outFillColor ?? colorScheme.primaryFixedDim,
          strokeWidth: strokeWidth,
          strokeLineJoin: strokeLineJoin,
          strokeLineCap: strokeLineCap,
        );
      case IconParkThemeType.multiColor:
        return IconParkProps.multiColor(
          outStrokeColor ?? colorScheme.onSurface,
          outFillColor ?? colorScheme.primary,
          innerStrokeColor ?? colorScheme.onPrimary,
          innerFillColor ?? colorScheme.primaryFixedDim,
          strokeWidth: strokeWidth,
          strokeLineJoin: strokeLineJoin,
          strokeLineCap: strokeLineCap,
        );
    }
  }

  IconParkProps copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
    Color? color4,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    bool? useCurrentColor,
  }) {
    return IconParkProps(
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      color4: color4 ?? this.color4,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeLineJoin: strokeLineJoin ?? this.strokeLineJoin,
      strokeLineCap: strokeLineCap ?? this.strokeLineCap,
      theme: theme,
    );
  }

  IconParkProps copyWithColor({
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    bool? useCurrentColor,
  }) {
    return switch (theme) {
      IconParkThemeType.outline => copyWith(
        color1: outStrokeColor,
        color2: outFillColor,
        color3: outStrokeColor,
        color4: outFillColor,
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
      ),
      IconParkThemeType.filled => copyWith(
        color1: outStrokeColor,
        color2: outStrokeColor,
        color3: innerStrokeColor,
        color4: innerStrokeColor,
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
      ),
      IconParkThemeType.twoTone => copyWith(
        color1: outStrokeColor,
        color2: outFillColor,
        color3: outStrokeColor,
        color4: outFillColor,
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
      ),
      IconParkThemeType.multiColor => copyWith(
        color1: outStrokeColor,
        color2: outFillColor,
        color3: innerStrokeColor,
        color4: innerFillColor,
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
      ),
    };
  }

  IconParkProps lerp(IconParkProps end, double t) {
    return IconParkProps(
      color1: Color.lerp(color1, end.color1, t)!,
      color2: Color.lerp(color2, end.color2, t)!,
      color3: Color.lerp(color3, end.color3, t)!,
      color4: Color.lerp(color4, end.color4, t)!,
      strokeWidth: lerpDouble(strokeWidth, end.strokeWidth, t),
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: theme,
    );
  }

  static IconParkProps? maybeOf(BuildContext context) {
    final def =
        context.dependOnInheritedWidgetOfExactType<DefaultIconParkProps>();
    return def?.props;
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is IconParkProps) {
      return color1 == other.color1 &&
          color2 == other.color2 &&
          color3 == other.color3 &&
          color4 == other.color4 &&
          strokeWidth == other.strokeWidth &&
          strokeLineJoin == other.strokeLineJoin &&
          strokeLineCap == other.strokeLineCap &&
          theme == other.theme;
    }
    return false;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      strokeWidth,
      strokeLineJoin,
      strokeLineCap,
      theme,
      color1,
      color2,
      color3,
      color4,
    ]);
  }
}

class IconParkTheme extends ThemeExtension<IconParkTheme> {
  late final IconParkThemeTypeMap paletteMap;
  final IconParkThemeType defaultTheme;

  IconParkProps? get(IconParkThemeType type) {
    return paletteMap[type];
  }

  IconParkTheme.fromColorScheme(
    ColorScheme colorScheme, {
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    this.defaultTheme = IconParkThemeType.outline,
  }) {
    paletteMap = {};
    for (final type in IconParkThemeType.values) {
      paletteMap[type] = IconParkProps.fromColorScheme(
        colorScheme,
        type,
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
      );
    }
  }

  IconParkTheme(
    this.paletteMap, {
    this.defaultTheme = IconParkThemeType.outline,
  });

  @override
  IconParkTheme copyWith({IconParkThemeTypeMap? paletteMap}) {
    return IconParkTheme(paletteMap ?? this.paletteMap);
  }

  IconParkTheme copyWithMerge(IconParkTheme other) {
    return IconParkTheme({...paletteMap, ...other.paletteMap});
  }

  @override
  IconParkTheme lerp(IconParkTheme? other, double t) {
    if (other is! IconParkTheme) {
      return this;
    }
    final newPaletteMap = <IconParkThemeType, IconParkProps>{};
    for (final entry in paletteMap.entries) {
      final otherStyle = other.paletteMap[entry.key];
      if (otherStyle != null) {
        newPaletteMap[entry.key] = entry.value.lerp(otherStyle, t);
      } else {
        newPaletteMap[entry.key] = entry.value;
      }
    }
    return IconParkTheme(newPaletteMap, defaultTheme: defaultTheme);
  }

  @override
  String toString() => 'IconParkTheme(paletteMap: $paletteMap)';
}

class DefaultIconParkProps extends InheritedWidget {
  const DefaultIconParkProps({super.key, this.props, required super.child});

  final IconParkProps? props;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is DefaultIconParkProps) {
      return oldWidget.props != props;
    }
    return true;
  }
}

class IconParkData {
  final String name;
  final IconParkSvgBuilder builder;
  final bool matchTextDirection;

  static IconParkSvgBuilder replace(String svg) {
    final rawSvg = svg;
    return (IconParkProps props) {
      var svg = rawSvg;
      svg = svg.replaceAllMapped(
        RegExp(r'stroke-linejoin="(\w+)"'),
        (match) =>
            'stroke-linejoin="${props.strokeLineJoin?.name ?? match.group(1)}"',
      );
      svg = svg.replaceAllMapped(
        RegExp(r'stroke-linecap="(\w+)"'),
        (match) =>
            'stroke-linecap="${props.strokeLineCap?.name ?? match.group(1)}"',
      );
      svg = svg.replaceAllMapped(
        RegExp(r'stroke-width="(\d+)"'),
        (match) => 'stroke-width="${props.strokeWidth ?? match.group(1)}"',
      );
      svg = svg.replaceAllMapped(RegExp(r'(fill|stroke)="([^"]+)"'), (match) {
        final type = match.group(1);
        final color = match.group(2)?.toLowerCase();
        String? targetColor;
        if (color == 'black' || color == '#000' || color == '#000000') {
          targetColor = props.c1;
        } else if (color == '#2f88ff') {
          targetColor = props.c2;
        } else if (color == 'white' || color == '#fff' || color == '#ffffff') {
          targetColor = props.c3;
        } else if (color == '#43ccf8') {
          targetColor = props.c4;
        }
        if (targetColor != null) {
          return '$type="$targetColor"';
        }
        return match.group(0) ?? '';
      });
      return svg;
    };
  }

  const IconParkData(this.name, this.matchTextDirection, this.builder);

  Widget icon({
    IconParkProps? props,
    IconParkThemeType? theme,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? size,
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
    bool? applyTextScaling,
    String? semanticLabel,
  }) {
    return Builder(
      builder: (context) {
        props ??= IconParkProps.maybeOf(context);
        if (props == null) {
          final parkTheme = Theme.of(context).extension<IconParkTheme>();
          theme ??= parkTheme?.defaultTheme ?? IconParkThemeType.outline;
          props = parkTheme?.paletteMap[theme];
          props ??= IconParkProps.fromColorScheme(
            Theme.of(context).colorScheme,
            theme!,
          );
        }
        final iconTheme = IconTheme.of(context);
        if (iconTheme.color != null) {
          props = props!.copyWithColor(outStrokeColor: iconTheme.color!);
        }
        size ??= iconTheme.size ?? kDefaultFontSize;

        applyTextScaling ??= iconTheme.applyTextScaling ?? false;

        final double? iconSize =
            applyTextScaling!
                ? MediaQuery.textScalerOf(context).scale(size!)
                : size;

        props = props!.copyWithColor(
          outStrokeColor: outStrokeColor,
          outFillColor: outFillColor,
          innerStrokeColor: innerStrokeColor,
          innerFillColor: innerFillColor,
          strokeWidth: strokeWidth,
          strokeLineJoin: strokeLineJoin,
          strokeLineCap: strokeLineCap,
        );

        Widget icon = SvgPicture.string(
          builder(props!),
          width: iconSize,
          height: iconSize,
          matchTextDirection: matchTextDirection,
        );
        if (iconTheme.opacity != null) {
          icon = Opacity(opacity: iconTheme.opacity!, child: icon);
        }
        if (semanticLabel != null) {
          icon = Semantics(
            label: semanticLabel,
            child: ExcludeSemantics(child: icon),
          );
        }
        return icon;
      },
    );
  }

  Widget outline(
    BuildContext context, {
    Color? fill,
    Color? background,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? size,
  }) {
    return icon(
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      size: size,
      theme: IconParkThemeType.outline,
      outFillColor: fill,
      outStrokeColor: background,
    );
  }

  Widget filled(
    BuildContext context, {
    Color? fill,
    Color? innerStroke,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? size,
  }) {
    return icon(
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      size: size,
      theme: IconParkThemeType.filled,
      outFillColor: fill,
      innerStrokeColor: innerStroke,
    );
  }

  Widget twoTone(
    BuildContext context, {
    Color? fill,
    Color? twoTone,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? size,
  }) {
    return icon(
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      size: size,
      theme: IconParkThemeType.twoTone,
      outStrokeColor: fill,
      outFillColor: twoTone,
    );
  }

  Widget multiColor(
    BuildContext context, {
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? size,
  }) {
    return icon(
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      size: size,
      theme: IconParkThemeType.multiColor,
      outStrokeColor: outStrokeColor,
      outFillColor: outFillColor,
      innerStrokeColor: innerStrokeColor,
      innerFillColor: innerFillColor,
    );
  }
}
