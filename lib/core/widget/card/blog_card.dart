import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../features/blog/model/blog_model.dart';

class BlogCardWidget extends StatelessWidget {
  final PostModel model;

  const BlogCardWidget({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: Card(
          child: ListTile(
        title: AspectRatio(aspectRatio: 2.5, child: Image.network(model.imageUrl)),
        subtitle: Text(model.title),
      )),
    );
  }
}
