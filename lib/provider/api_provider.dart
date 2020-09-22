import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app_test/model/posts.dart';

class ApiProvider {
  var https = http.Client();

  Future<List<Posts>> getPosts() async {
    var response =
        await https.get('https://jsonplaceholder.typicode.com/posts');
    List<Posts> postList = [];

    var data = json.decode(response.body) as List<dynamic>;
    if (response.statusCode == 200) {
      print('data$data');
      for (int i = 0; i < data.length; i++) {
        postList.add(Posts.fromJson(data[i]));
      }

      return postList;
    }
  }
}
