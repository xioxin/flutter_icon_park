import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_park/icon_park.dart';
import 'package:icon_park/all_icons.dart';

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
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('example app'),
          actions: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: IconPark.setting.icon(context),
            ),
          ],
        ),
        endDrawer: Drawer(child: Text("test")),
        body: Row(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 1,
                ),
                itemCount: allIcons.length,
                itemBuilder: (context, index) {
                  final icon = allIcons[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon.icon(context, theme: IconParkThemeType.multiColor),
                      Text(icon.name),
                    ],
                  );
                },
              ),
            ),
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
