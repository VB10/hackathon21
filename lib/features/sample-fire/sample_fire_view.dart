import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/widget/card/user_card.dart';
import 'model/user_model.dart';

class SampleFireView extends StatefulWidget {
  @override
  _SampleFireViewState createState() => _SampleFireViewState();
}

class _SampleFireViewState extends State<SampleFireView> {
  bool _isLoading = false;
  final String _baseUrl = 'https://flutterhackathon2021-default-rtdb.firebaseio.com/';

  List<UserModel> _userModels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      appBar: AppBar(title: Text('Hackathon21')),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : buildBodyListView(),
    );
  }

  ListView buildBodyListView() {
    return ListView.builder(
      itemCount: _userModels.length,
      itemBuilder: (context, index) => UserCard(model: _userModels[index], index: index),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.get_app),
      onPressed: () async {
        _changeLoading();
        final items = await fetchFireDatas();
        _userModels = items;
        _changeLoading();
      },
    );
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<List<UserModel>> fetchFireDatas() async {
    final response = await http.get('$_baseUrl/todo.json');
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = jsonDecode(response.body);
      // jsonBody.
      if (jsonBody is List) {
        return jsonBody.map((e) => UserModel.fromJson(e)).toList();
      }
    }
    throw Exception('Firebase deosnt work');
    // return null;
  }
}
