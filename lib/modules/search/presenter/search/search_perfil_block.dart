import 'package:bloc/bloc.dart';
import 'package:mobile_challenge/modules/search/domain/usecases/search_perfil_by_text.dart';
import 'package:mobile_challenge/modules/search/presenter/search/states/state_perfil.dart';
import 'package:rxdart/rxdart.dart';

class SearchPerfilBlock extends Bloc<String,SearchPerfilState> {
  final SearchPerfilByText usecase;
  SearchPerfilBlock(this.usecase) : super(SearchStart());

  @override
  Stream<SearchPerfilState> mapEventToState(String searchText)async* {
    yield SearchLoading();
     final result = await usecase(searchText);
     yield result.fold((l) => SearchError(l), (r) => SearchSucces(r));
  }

  @override
  Stream<Transition<String, SearchPerfilState>> transformEvents(Stream<String> events, TransitionFunction<String, SearchPerfilState> transitionFn) {
    // TODO: implement transformEvents
    return super.transformEvents(events.debounceTime(Duration(microseconds: 800)), transitionFn);
  }
}