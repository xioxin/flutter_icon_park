# flutter_icon_park

This is the Flutter implementation of the ByteDance IconPark icon library, a set of SVG-based icons. It supports multiple color modes.
You can customize the color, style, line width, endpoint type, and corner type.
With tree-shaking optimization, only the icons used will be included.

## Installation

```yaml
dependencies:
  flutter_icon_park: ^0.0.1
```

## Usage

```dart

IconPark.bookmark.icon() // Automatically uses theme color and default style

// Specify style
IconPark.bookmark.outline()
IconPark.bookmark.fill()
IconPark.bookmark.twoTone()
IconPark.bookmark.multiColor()


// Specify color
IconPark.bookmark.outline(fill: Colors.red)

// Specify line width
IconPark.bookmark.outline(strokeWidth: 2)

```

## Setting Theme (Optional)

```dart
Widget build(BuildContext context) {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
  return MaterialApp(
    theme: ThemeData(
        colorScheme: colorScheme,
        extensions: {
          // Choose one
          // Automatically generate using color scheme
          // defaultTheme specifies the default style
          IconParkTheme.fromColorScheme(colorScheme, defaultTheme: IconParkThemeType.twoTone, strokeWidth: 5.0),
          
          // Manually specify the style for each theme
          IconParkTheme(
              {
                IconParkThemeType.outline: IconParkProps.outline(Colors.black, strokeWidth: 5.0),
                IconParkThemeType.twoTone: IconParkProps.twoTone(Colors.black, Colors.red, strokeWidth: 5.0),
                IconParkThemeType.fill: ...
                IconParkThemeType.multiColor: ...
              }
          )
        }
    ),
    home: MyHomePage(),
  );
}
```