
class Posts{
  /*{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  }*/
String userId,id,title,body;

Posts.fromJson(Map<String,dynamic> datas):
    userId=datas['userId'].toString(),id=datas['id'].toString(),title=datas['title'],body=datas['body'];

}