

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/databases/dbUser.dart';


void main(){

  TestWidgetsFlutterBinding.ensureInitialized();

  test('Teste de criação do bd', (){
    var db = DataBaseHelper();
    expect(db.runtimeType, DataBaseHelper);
  });


}