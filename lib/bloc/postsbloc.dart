
import 'package:flutter_app_test/model/posts.dart';
import 'package:flutter_app_test/provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc{
  var apiProvider = ApiProvider();

  BehaviorSubject<List<Posts>> poststr =BehaviorSubject();

   getPosts() async{
    var posts =await apiProvider.getPosts();

    poststr.sink.add(posts);

  }

  BehaviorSubject<List<Posts>> get postList=>poststr.stream;
}
final bloc = PostsBloc();