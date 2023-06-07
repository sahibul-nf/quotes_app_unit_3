import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app_unit_3/models/quote_api_model.dart';

final quotesRepositoryProvider = Provider<QuotesRepository>((ref) {
  return QuotesRepository();
});

class QuotesRepository {
  // Fungsi Get Random Quotes
  Future<List<QuoteApi>> getRandomQuotes() async {
    String url = "https://api.quotable.io/quotes/random?limit=20";

    // send request to api
    final response = await http.get(Uri.parse(url));

    // jika gagal
    if (response.statusCode != 200) {
      throw Exception("Error get random quotes");
    }

    // jika berhasil
    print(response.body);

    // decode json
    final jsonData = jsonDecode(response.body);

    List<QuoteApi> quotes = [];

    for (var i in jsonData) {
      final quote = QuoteApi.fromJson(i);
      quotes.add(quote);
    }

    return quotes;
  }

  Future<List<QuoteApi>> searchQuotes(String query) async {
    String url = "https://api.quotable.io/search/quotes/?query=$query";

    // send request to api
    final response = await http.get(Uri.parse(url));

    // jika gagal
    if (response.statusCode != 200) {
      throw Exception("Error get random quotes");
    }

    // jika berhasil
    print(response.body);

    // decode json
    final jsonData = jsonDecode(response.body);
    final data = jsonData['results'] as List;

    List<QuoteApi> quotes = [];

    for (var i in data) {
      final quote = QuoteApi.fromJson(i);
      quotes.add(quote);
    }

    return quotes;
  }
}
