import 'package:http/http.dart' as http;

Future<bool> testServerConnection(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Esse link existe');
        return true;
      }
      print('Esse link NÃO existe');
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
