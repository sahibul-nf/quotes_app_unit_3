import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app_unit_3/models/quote_api_model.dart';

import '../repositories/quotes_repository.dart';

final getRandomQuotesProvider = FutureProvider<List<QuoteApi>>((ref) async {
  // panggil repository
  final repository = ref.watch(quotesRepositoryProvider);

  // panggil fungsi get random quotes
  final res = await repository.getRandomQuotes();

  // return hasil ke UI
  return res;
});

// class QuotesController {
//   final WidgetRef ref;
//   QuotesController(this.ref);

//   // get random quotes from repository
//   Future<List<QuoteApi>> getRandomQuotes() async {
//     final res = await ref.watch(quotesRepositoryProvider).getRandomQuotes();

//     return res;
//   }
// }
