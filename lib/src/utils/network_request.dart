import 'dart:convert';
import 'package:http/http.dart' as http;

const String _BaseURL = "https://api.sp-123.online";

class ApiClient {
  Future<String?> getCountry(String ip) async {
    final response = await http.get(
      Uri.parse('https://api.country.is/$ip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final jsonResponse = json.decode(response.body);
    return jsonResponse['country'];
  }

  Future<Map<String, dynamic>> login(
      String email, String password, String country) async {
    final response = await http.post(
      Uri.parse('$_BaseURL/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'country': country
      }),
    );
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<Map<String, dynamic>> checkTwoFa(String email, String twofa) async {
    print("check email $email");
    print("check email $twofa");
    final response = await http.post(
      Uri.parse('$_BaseURL/login_with_2fa'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, "twofa_code": twofa}),
    );
    // Nếu yêu cầu thành công, parse dữ liệu JSON
    final jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  void callApi() {
    http.post(Uri.parse("$_BaseURL/check_login_api"));
  }
}
