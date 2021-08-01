import 'package:bloc/bloc.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/modules/search/presenter/search/states/state.dart';
import 'package:rxdart/rxdart.dart';
class SearchBlock extends Bloc<String,SearchState> {
  final SearchByText usecase;
  SearchBlock(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText)async* {
    yield SearchLoading();
     final result = await usecase(searchText);
     yield result.fold((l) => SearchError(l), (r) => SearchSucces(r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events, TransitionFunction<String, SearchState> transitionFn) {
    // TODO: implement transformEvents
    return super.transformEvents(events.debounceTime(Duration(microseconds: 800)), transitionFn);
  }
}