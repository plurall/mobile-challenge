
import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';
import 'package:mobile_challenge/modules/search/infra/models/result_search_perfil_model.dart';

abstract class SearchDatasource{
  Future<List<ResultSearchModel>> getSearch(String searchText);
  Future<ResultSearchPerfilModel> getPerfil(String searchText);
}