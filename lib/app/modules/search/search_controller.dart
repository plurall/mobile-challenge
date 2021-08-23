import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/search_model.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';

class SearchController extends GetxController {
  final Repository repository;

  SearchController({@required this.repository}) : assert(repository != null);

  List<SearchModel> get usersList => _$usersList();
  set usersList(List<SearchModel> value) => _$usersList.value = value;
  final RxList<SearchModel> _$usersList = RxList();

  bool get isSearching => _$isSearching.value;
  final _$isSearching = false.obs;

  String get searchText => _$searchText();
  set searchText(String value) => _$searchText(value);
  final RxString _$searchText = RxString('');

  String get errorText => _$errorText();
  final RxString _$errorText = RxString('Pesquise um usuário');

  searchUsers() async {
    _$errorText('Nenhum resultado para $searchText');
    if (searchText.isEmpty) {
      _$usersList([]);
      return;
    }
    try {
      _$isSearching(true);
      final List<SearchModel> data =
          await repository.searchUsers(name: searchText);
      _$usersList(data);
    } on DioError catch (e) {
      if (e?.response?.statusCode == null) {
        _$errorText(
          'Opss.. Ocorreu um erro\nverifique a sua conexão com a internet',
        );
      }
    } catch (e) {
      _$errorText('Opss.. Ocorreu um erro');
    } finally {
      _$isSearching(false);
    }
  }
}
