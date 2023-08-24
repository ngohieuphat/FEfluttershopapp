import '../models/sneaker_model.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Helper {
  static final http.Client _client = http.Client();

  Future<List<Sneakers>> getMaleSneakers() async {
    try {
      var url = Uri.parse("${Config.apiUrl}/${Config.sneaker}");
      Map<String, String> headers = {};
      headers['Content-Type'] = 'application/json; charset=UTF-8';
      var response = await _client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final maleList = sneakersFromJson(response.body);
        var male =
            maleList.where((element) => element.category == "Men's Running");
        return male.toList();
      } else {
        throw Exception(
            "Failed to get sneakers list. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<Sneakers>> getFemaleSneakers() async {
    try {
      var url = Uri.parse("${Config.apiUrl}/${Config.sneaker}");
      Map<String, String> headers = {};
      headers['Content-Type'] = 'application/json; charset=UTF-8';
      var response = await _client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final femaleList = sneakersFromJson(response.body);
        var femaleSneakers = femaleList
            .where((element) => element.category == "Women's Running");
        return femaleSneakers.toList();
      } else {
        throw Exception("Failed to get sneakers list");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<Sneakers>> getKidsSneakers() async {
    try {
      var url = Uri.parse("${Config.apiUrl}/${Config.sneaker}");
      Map<String, String> headers = {};
      headers['Content-Type'] = 'application/json; charset=UTF-8';
      var response = await _client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final kidList = sneakersFromJson(response.body);
        var kidsSneakers =
            kidList.where((element) => element.category == "Kids' Running");
        return kidsSneakers.toList();
      } else {
        throw Exception("Failed to get sneakers list");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    try {
      var url = Uri.parse('${Config.apiUrl}${Config.search}$searchQuery');
      var response = await _client.get(url, headers: {
        'Content-Type': 'application/json ;  charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final results = sneakersFromJson(response.body);
        return results;
      } else {
        throw Exception("Failed to get sneakers list");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  // Close the client instance when it's no longer needed.
  static void closeClient() {
    _client.close();
  }
}
