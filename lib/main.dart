import 'package:flutter/material.dart';

import 'features/sample-fire/sample_fire_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SampleFireView(),
    );
  }
}
