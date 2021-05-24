import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/models/User.dart';
void main(){
  test('Teste de criação do User', (){
    final user = User(id: 1);
    expect(user.id, 1);
  });



}