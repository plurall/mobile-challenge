import 'package:async/async.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

@Injectable()
class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final SearchByText searchByText;
  CancelableOperation cancellableOperation;

  _SearchStoreBase(this.searchByText) {
    reaction((_) => searchText, (text) async {
      stateReaction(text, cancellableOperation);
    }, delay: 500);
  }

  Future stateReaction(String text,
      [CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation =
    CancelableOperation<SearchState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(SearchStart());
      return;
    }

    setState(SearchLoading());

    setState(await cancellableOperation.valueOrCancellation(SearchLoading()));
  }

  Future<SearchState> makeSearch(String text) async {
    var result = await searchByText(text);
    return result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  @observable
  String searchText = "";

  @observable
  SearchState state = SearchStart();

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;
}