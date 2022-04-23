import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    //we've used the variable decodeData as a dynamic variable because we actually don't know the type that will return from jsonDecode untill the data completed.
    //so if i know it i can change it to it's right type as following,but leave as decodeData as a dynamic you can change tem,name etc.
    else
      print(response.statusCode);
  }
}
