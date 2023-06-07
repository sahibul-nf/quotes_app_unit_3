import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app_unit_3/models/quote_api_model.dart';
import 'package:quotes_app_unit_3/repositories/quotes_repository.dart';

class SearchController extends StateNotifier<AsyncValue<List<QuoteApi>>> {
  SearchController(this._quotesRepository) : super(const AsyncValue.data([]));

  final QuotesRepository _quotesRepository;

  Future<void> searchQuotes(String query) async {
    // set state loading
    state = const AsyncValue.loading();

    // send request dengan panggil repo
    final result = await _quotesRepository.searchQuotes(query);

    // set state berhasil dapat data
    state = AsyncValue.data(result);
  }
}

final searchControllerProvider = StateNotifierProvider<SearchController, AsyncValue<List<QuoteApi>>>((ref) {
  final repo = ref.watch(quotesRepositoryProvider);

  return SearchController(repo);
});
