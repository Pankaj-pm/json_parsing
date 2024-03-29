import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper obj = ApiHelper._();
  final String _baseUrl = "https://jsonplaceholder.typicode.com/";

  ApiHelper._();

  factory ApiHelper() {
    return obj;
  }

  Future<String> getApiData(String endPoint) async {
    //https://jsonplaceholder.typicode.com/comments?postId=1
    //https://jsonplaceholder.typicode.com/posts

    var future = await http.get(Uri.parse("$_baseUrl$endPoint"));
    return future.body;
  }

  Future<String?> getApiDataWithUrl(Uri uri) async {
    var future = await http.get(uri);
    if (future.statusCode == 200) {
      return future.body;
    } else {
      return null;
    }
  }

  Future<String?> post(String url, Map<String, dynamic> body) async {
    var postReq = await http.post(Uri.parse(url), body: body);

    if (postReq.statusCode >= 200 && postReq.statusCode <= 299) {
      return postReq.body;
    } else {
      return null;
    }

    return "";
  }
}
