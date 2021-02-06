import 'package:flutter/material.dart';

import '../../../features/sample-fire/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel model;
  final int index;
  const UserCard({Key key, @required this.model, this.index = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title: Text(model.name),
        leading: buildCircularProgressIndicatorLeading(),
      ),
    );
  }

  CircularProgressIndicator buildCircularProgressIndicatorLeading() {
    return CircularProgressIndicator(
      value: 1,
      strokeWidth: 10,
      valueColor: AlwaysStoppedAnimation<Color>(colorValue()),
    );
  }

  MaterialColor colorValue() => index % 2 == 0 ? Colors.blue : Colors.red;
}
