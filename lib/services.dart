import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Service(this.url);
  final String url;
  Future<double> getRates() async {
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['rate'];
    } else
      print(response.statusCode);
    return 0;
  }
}
