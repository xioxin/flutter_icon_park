import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconParkTheme { outline, filled, twoTone, multiColor }

typedef IconParkSvgBuilder = String Function(IconParkProps props);

String? colorToCssRgba(Color? color) {
  if (color == null) return null;
  return 'rgba(${(color.r * 255).toStringAsFixed(0)}, ${(color.g * 255).toStringAsFixed(0)}, ${(color.b * 255).toStringAsFixed(0)}, ${color.a.toStringAsFixed(4)})';
}

class IconParkProps {
  final double? size;
  final double? strokeWidth;
  final StrokeJoin? strokeLineJoin;
  final StrokeCap? strokeLineCap;
  final List<String?> colors;
  final IconParkTheme theme;

  const IconParkProps({
    this.size,
    this.strokeWidth,
    this.strokeLineJoin,
    this.strokeLineCap,
    this.theme = IconParkTheme.outline,
    this.colors = const [],
  });

  static IconParkProps outline({
    double? size,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    Color? fill,
    Color? background,
  }) {
    return IconParkProps(
      size: size,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: IconParkTheme.outline,
      colors: [
        fill != null ? colorToCssRgba(fill) : null,
        background != null ? colorToCssRgba(background) : null,
        fill != null ? colorToCssRgba(fill) : null,
        background != null ? colorToCssRgba(background) : null,
      ],
    );
  }

  static IconParkProps filled({
    double? size,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    Color? fill,
    Color? background,
  }) {
    return IconParkProps(
      size: size,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: IconParkTheme.filled,
      colors: [
        fill != null ? colorToCssRgba(fill) : null,
        fill != null ? colorToCssRgba(fill) : null,
        background != null ? colorToCssRgba(background) : null,
        background != null ? colorToCssRgba(background) : null,
      ],
    );
  }

  static IconParkProps twoTone({
    double? size,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    Color? fill,
    Color? twoTone,
  }) {
    return IconParkProps(
      size: size,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: IconParkTheme.twoTone,
      colors: [
        fill != null ? colorToCssRgba(fill) : null,
        twoTone != null ? colorToCssRgba(twoTone) : null,
        fill != null ? colorToCssRgba(fill) : null,
        twoTone != null ? colorToCssRgba(twoTone) : null,
      ],
    );
  }

  static IconParkProps multiColor({
    double? size,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
  }) {
    return IconParkProps(
      size: size,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: IconParkTheme.multiColor,
      colors: [
        outStrokeColor != null ? colorToCssRgba(outStrokeColor) : null,
        outFillColor != null ? colorToCssRgba(outFillColor) : null,
        innerStrokeColor != null ? colorToCssRgba(innerStrokeColor) : null,
        innerFillColor != null ? colorToCssRgba(innerFillColor) : null,
      ],
    );
  }

  static IconParkProps formMaterialTheme(
    BuildContext context, {
    IconParkTheme? theme,
    double? size,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? opacity,
  }) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    opacity ??= iconTheme.opacity;
    size ??= iconTheme.size;

    final outStrokeColor = iconTheme.color ?? Color(0xff000000);
    final outFillColor = colorScheme.primary;
    final innerStrokeColor = colorScheme.onPrimary;
    final innerFillColor = colorScheme.primaryFixedDim;

    final transparent = Color(0x00000000);

    theme ??= IconParkTheme.outline;
    List<Color?> colors = [];
    if (theme == IconParkTheme.outline) {
      colors = [outStrokeColor, transparent, outStrokeColor, transparent];
    } else if (theme == IconParkTheme.filled) {
      colors = [
        outStrokeColor,
        outStrokeColor,
        innerStrokeColor,
        innerStrokeColor,
      ];
    } else if (theme == IconParkTheme.twoTone) {
      colors = [outStrokeColor, outFillColor, outStrokeColor, outFillColor];
    } else if (theme == IconParkTheme.multiColor) {
      colors = [outStrokeColor, outFillColor, innerStrokeColor, innerFillColor];
    }

    return IconParkProps(
      size: size,
      strokeWidth: strokeWidth,
      strokeLineJoin: strokeLineJoin,
      strokeLineCap: strokeLineCap,
      theme: theme,
      colors: colors.map((v) => colorToCssRgba(v)).toList(),
    );
  }

  static IconParkProps? maybeOf(BuildContext context) {
    final def =
        context.dependOnInheritedWidgetOfExactType<DefaultIconParkProps>();
    return def?.props;
  }

  static IconParkProps of(BuildContext context) {
    final def =
        context.dependOnInheritedWidgetOfExactType<DefaultIconParkProps>();
    assert(def != null, 'No DefaultIconParkProps found in context');
    return def!.props!;
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IconParkProps) return false;
    return size == other.size &&
        strokeWidth == other.strokeWidth &&
        strokeLineJoin == other.strokeLineJoin &&
        strokeLineCap == other.strokeLineCap &&
        colors.join(',') == other.colors.join(',') &&
        theme == other.theme;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      size,
      strokeWidth,
      strokeLineJoin,
      strokeLineCap,
      theme,
      ...colors,
    ]);
  }
}

class DefaultIconParkProps extends InheritedWidget {
  DefaultIconParkProps({this.props, required super.child});

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
  final bool rtl;

  const IconParkData(this.name, this.rtl, this.builder);

  icon(IconParkProps props) {
    return SvgPicture.string(
      builder(props),
      // width: size,
      // height: size,
      // semanticsLabel: semanticsLabel,
      // theme: SvgTheme(currentColor: fill),
    );
  }

  outline(
    BuildContext context, {
    double? size,
    Color? fill,
    Color? background,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? opacity,
    String? semanticsLabel,
  }) {
    final IconThemeData iconTheme = IconTheme.of(context);
    fill ??= iconTheme.color ?? Color(0xff000000);
    background ??= Color(0x00000000);
    opacity ??= iconTheme.opacity;
    final colors = [fill, background, fill, background];
    size ??= iconTheme.size;
    final svg = builder(
      IconParkProps(
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
        colors: colors.map((v) => colorToCssRgba(v)).toList(),
      ),
    );
    // print(svg);
    return SvgPicture.string(
      svg,
      width: size,
      height: size,
      semanticsLabel: semanticsLabel,
      theme: SvgTheme(currentColor: fill),
    );
  }

  filled(
    BuildContext context, {
    double? size,
    Color? fill,
    Color? background,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? opacity,
    String? semanticsLabel,
  }) {
    final IconThemeData iconTheme = IconTheme.of(context);
    fill ??= iconTheme.color ?? Color(0xff000000);
    background ??= Color(0xffffffff);
    opacity ??= iconTheme.opacity;
    final colors = [fill, fill, background, background];
    size ??= iconTheme.size;
    final svg = builder(
      IconParkProps(
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
        colors: colors.map((v) => colorToCssRgba(v)).toList(),
      ),
    );
    return SvgPicture.string(
      svg,
      width: size,
      height: size,
      semanticsLabel: semanticsLabel,
    );
  }

  twoTone(
    BuildContext context, {
    double? size,
    Color? fill,
    Color? twoTone,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? opacity,
    String? semanticsLabel,
  }) {
    final IconThemeData iconTheme = IconTheme.of(context);
    fill ??= iconTheme.color ?? Color(0xff000000);
    twoTone ??= Theme.of(context).colorScheme.primary;
    opacity ??= iconTheme.opacity;
    size ??= iconTheme.size;
    final colors = [fill, twoTone, fill, twoTone];
    final svg = builder(
      IconParkProps(
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
        colors: colors.map((v) => colorToCssRgba(v)).toList(),
      ),
    );
    return SvgPicture.string(
      svg,
      width: size,
      height: size,
      semanticsLabel: semanticsLabel,
    );
  }

  multiColor(
    BuildContext context, {
    double? size,
    Color? outStrokeColor,
    Color? outFillColor,
    Color? innerStrokeColor,
    Color? innerFillColor,
    double? strokeWidth,
    StrokeJoin? strokeLineJoin,
    StrokeCap? strokeLineCap,
    double? opacity,
    String? semanticsLabel,
  }) {
    final IconThemeData iconTheme = IconTheme.of(context);
    outStrokeColor ??= iconTheme.color ?? Color(0xff000000);
    final colorScheme = Theme.of(context).colorScheme;
    outFillColor ??= colorScheme.primary;
    innerStrokeColor ??= colorScheme.onPrimary;
    innerFillColor ??= colorScheme.primaryFixedDim;
    opacity ??= iconTheme.opacity;
    size ??= iconTheme.size;
    final colors = [
      outStrokeColor,
      outFillColor,
      innerStrokeColor,
      innerFillColor,
    ];
    final svg = builder(
      IconParkProps(
        strokeWidth: strokeWidth,
        strokeLineJoin: strokeLineJoin,
        strokeLineCap: strokeLineCap,
        colors: colors.map((v) => colorToCssRgba(v)).toList(),
      ),
    );
    return SvgPicture.string(
      svg,
      width: size,
      height: size,
      semanticsLabel: semanticsLabel,
    );
  }
}
