import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/constant/project_constant.dart';
import '../../core/network/firebase_string_extension.dart';
import '../../core/network/network_path.dart';
import 'blog.dart';
import 'model/blog_model.dart';

abstract class BlogViewModel extends State<Blog> {
  final firebaseDatabaseDio = Dio(BaseOptions(baseUrl: ProjectConstant.FIREBASE_DATABASE));
  final firebaseStorageDio = Dio();

  bool isLoading = false;

  Future<List<PostModel>> fetchFirebaseDatas() async {
    final response = await firebaseDatabaseDio.get(NetworkPath.POST.rawValue.toJson);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseData = response.data;
        if (responseData is Map) {
          final items = responseData.values.map((e) {
            final item = PostModel.fromJson(e);
            item.key = responseData.keys.singleWhere((element) => responseData[element] == e);
            return item;
          }).toList();
          return items;
        } else {
          return [];
        }
        break;
      default:
        throw Exception();
    }
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> addPostToFirebase(PostModel postModel, File file) async {
    _changeLoading();
    final uploadFile = await _uploadFileToSever(file);
    postModel.imageUrl = 'vb'.toFirebaseCloudUrl(ProjectConstant.FIREBASE_STROAGE);
    final postUpload = await _sendDatabase(postModel);
    _changeLoading();
  }

  Future<bool> _uploadFileToSever(File file) async {
    var fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await firebaseStorageDio.post('vb'.toFirebaseCloudUrl(ProjectConstant.FIREBASE_STROAGE), data: formData);

    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> _sendDatabase(PostModel model) async {
    final response = await firebaseDatabaseDio.post(NetworkPath.POST.rawValue.toJson, data: model);
// response.d
    return response.statusCode == HttpStatus.ok;
  }
}
