# flutter_icon_park

这是 ByteDance IconPark图标库的 Flutter 实现，这是一套基于SVG的图标。支持多种色彩模式。
可以自定义颜色、风格、线宽、端点类型、拐点类型。
利用摇树优化，只会引入使用到的图标。

## 安装

```yaml
dependencies:
  flutter_icon_park: ^0.0.1
```

## 使用

```dart

IconPark.bookmark.icon() // 自动使用主题色和默认风格

// 指定风格
IconPark.bookmark.outline()
IconPark.bookmark.fill()
IconPark.bookmark.twoTone()
IconPark.bookmark.multiColor()


// 指定颜色
IconPark.bookmark.outline(fill: Colors.red)

// 指定线宽
IconPark.bookmark.outline(strokeWidth: 2)

```


## 设置主题 (可选)

```dart
Widget build(BuildContext context) {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
  return MaterialApp(
    theme: ThemeData(
        colorScheme: colorScheme,
        extensions: {
          // 二选一
          // 使用颜色方案自动生成
          // defaultTheme 指定默认风格
          IconParkTheme.fromColorScheme(colorScheme, defaultTheme: IconParkThemeType.twoTone, strokeWidth: 5.0),
          
          // 手动指定每一个风格的样式
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
