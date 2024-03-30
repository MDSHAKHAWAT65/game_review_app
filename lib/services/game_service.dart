import 'package:game_review/config/config.dart';
// import 'package:game_review/models/game_model.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class GameService {

   Future<http.Response> fetchGames() async {
    var url = Uri.https(Config.baseUrl, '/api/games');
    Map<String, String> header = Config.header;

    String token = getStringAsync('access_token');
    header['Authorization'] = "Bearer $token";
    
    return await http.get(url, headers: header);
  }

   Future<http.Response> ratingSubmit(formData) async {
    var url = Uri.https(Config.baseUrl, '/api/games/ratings');
    Map<String, String> header = Config.header;

    String token = getStringAsync('access_token');
    header['Authorization'] = "Bearer $token";

    print(formData);
    
    return await http.post(url, body: formData, headers: header);
  }

}
