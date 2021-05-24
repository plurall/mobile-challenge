import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/models/Users.dart';


void main() {
   test('Teste de criação do Users', (){
    final users = Users(id: 1);
    expect(users.id, 1);
  });


}
