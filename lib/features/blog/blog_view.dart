import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../core/widget/bottom_sheet/blog_bottom_sheet.dart';
import '../../core/widget/card/blog_card.dart';
import 'blog_view_model.dart';
import 'model/blog_model.dart';

class BlogView extends BlogViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(borderRadius: context.normalBorderRadius),
            builder: (context) => BlogBottomSheet(
              onCompleted: (model, image) {
                addPostToFirebase(model, image);
              },
            ),
          );
        },
      ),
      appBar: buildAppBar(context),
      body: fetchFirebaseDatas().toBuild<List<PostModel>>(
          onSuccess: (data) {
            return buildListViewBody(data);
          },
          loadingWidget: LottieBuilder.network('https://assets9.lottiefiles.com/packages/lf20_9mirzvfe.json'),
          notFoundWidget: Text('data'),
          onError: Text('a')),
    );
  }

  ListView buildListViewBody(List<PostModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => BlogCardWidget(model: data[index]),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      leading: Icon(Icons.ac_unit),
      title: Text(
        'data',
        style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {})],
    );
  }
}
