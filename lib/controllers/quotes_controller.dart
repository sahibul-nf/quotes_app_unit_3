import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app_unit_3/models/quote_api_model.dart';

import '../repositories/quotes_repository.dart';

final getRandomQuotesProvider = FutureProvider<List<QuoteApi>>((ref) async {
  // panggil class repository via provider
  final repo = ref.watch(quotesRepositoryProvider);

  // panggil class controller
  final controller = QuotesController(repo);

  // dapatin data dari fungsi getRandomQuotes()
  final dataRandomQuotes = await controller.getRandomQuotes();

  // return data ke UI
  return dataRandomQuotes;
});

class QuotesController {
  QuotesController(this._quotesRepository);

  final QuotesRepository _quotesRepository;

  // get random quotes from repository
  Future<List<QuoteApi>> getRandomQuotes() async {
    final res = await _quotesRepository.getRandomQuotes();

    return res;
  }
}
