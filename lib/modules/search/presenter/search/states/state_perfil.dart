import 'package:mobile_challenge/modules/search/domain/entities/result_search_perfil.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';

abstract class SearchPerfilState{}

class SearchSucces implements SearchPerfilState{
  final ResultSearchPerfil perfil;
  SearchSucces(this.perfil);
}
class SearchStart implements SearchPerfilState{}
class SearchLoading implements SearchPerfilState{}
class SearchError implements SearchPerfilState{
  final FailureSearch error;
  SearchError(this.error);
}