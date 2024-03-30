import 'package:game_review/config/config.dart';
import 'package:http/http.dart' as http;

class AuthService {

  Future<http.Response> login(formData) async {
    var url = Uri.https(Config.baseUrl, '/api/login');
    Map<String, String> header = Config.header;
    
    return await http.post(url, body: formData, headers: header);
  }


  Future<http.Response> register(formData) async {
    var url = Uri.https(Config.baseUrl, '/api/register');
    Map<String, String> header = Config.header;
    
    return await http.post(url, body: formData, headers: header);
  }
  

  Future<String> fetchUser(formData) async {
    var url = Uri.https(Config.baseUrl, 'login');
    Map<String, String> header = Config.header;
    header['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzEwOTYxNjQ2LCJleHAiOjE3MTA5NjUyNDYsIm5iZiI6MTcxMDk2MTY0NiwianRpIjoiTzBXUWRicHMyTWE3enR3SCIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7y7eg7QLuUtHPAxSnaN30z3J6yF1ukAuzAxTyOEkzCA';
    
    var response = await http.post(url, body: formData, headers: header);
    print('Response body: ${response.body}');
    return response.body;
  }
  
}