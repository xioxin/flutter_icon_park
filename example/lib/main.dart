import 'package:flutter/material.dart';
import 'package:flutter_icon_park/flutter_icon_park.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double strokeWidth = 4.0;
  StrokeJoin strokeLineJoin = StrokeJoin.round;
  StrokeCap strokeLineCap = StrokeCap.round;
  IconParkThemeType iconParkTheme = IconParkThemeType.multiColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: colorScheme,
        extensions: {
          IconParkTheme.fromColorScheme(
            colorScheme,
            defaultTheme: IconParkThemeType.outline,
            strokeWidth: 5.0,
          ),
        },
      ),

      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('example app'),
          actions: [

          ],
        ),
        endDrawer: Drawer(child: Text("test")),
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("Test"),
                  FilledButton.icon(
                    onPressed: null,
                    icon: IconPark.bookmark.icon(),
                    label: Text("test"),
                  ),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: IconPark.bookmark.twoTone(),
                    label: Text("test"),
                  ),
                ],
              ),
            ),

            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: 100,
            //       childAspectRatio: 1,
            //     ),
            //     itemCount: allIcons.length,
            //     itemBuilder: (context, index) {
            //       final icon = allIcons[index];
            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           icon.icon(
            //             context,
            //             theme: IconParkThemeType.twoTone,
            //           ),
            //           Text(icon.name),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            SizedBox(
              width: 200,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTheme(
                      data: IconThemeData(size: 50, fill: 1.0, weight: 800),
                      child: Icon(Icons.bookmark_outline),
                    ),

                    Text("strokeWidth: $strokeWidth"),
                    Slider(
                      value: strokeWidth,
                      min: 0,
                      max: 10,
                      onChanged: (value) {
                        setState(() {
                          strokeWidth = value;
                        });
                      },
                    ),
                    Text("strokeLineJoin: $strokeLineJoin"),
                    DropdownButton<StrokeJoin>(
                      value: strokeLineJoin,
                      items:
                          StrokeJoin.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          strokeLineJoin = value!;
                        });
                      },
                    ),
                    Text("strokeLineCap: $strokeLineCap"),
                    DropdownButton<StrokeCap>(
                      value: strokeLineCap,
                      items:
                          StrokeCap.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          strokeLineCap = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
