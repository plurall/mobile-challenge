import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/app_widget.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';

main() {

  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));

  test('Must retrieve the usecase with no error', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });
}
