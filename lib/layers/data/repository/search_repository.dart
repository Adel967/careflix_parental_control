import '../data_provider/search_provider.dart';
import '../model/show.dart';

class SearchRepository {
  SearchProvider _searchProvider;

  SearchRepository(this._searchProvider);

  Future<List<Show>> searchShow(String text) async {
    final res = await _searchProvider.searchShow();
    final List<Show> resShows = getShowListFromListMap(res.docs);

    return List.from(resShows.where(
        (element) => element.title.toLowerCase().contains(text.toLowerCase())));
  }
}
