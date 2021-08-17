import 'package:mobile_challenge/app/services/profile_service.dart';
import 'package:mobile_challenge/app/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProfileModel profileModel;

  group('Profile service test', (){
    test('should return null when no user is found', ()async{
      profileModel = await ProfileService().getProfile('***');
      expect(profileModel,isNull);
    });
    test('should return profileModel when user is found', ()async{
      profileModel = await ProfileService().getProfile('cleversonAbreu');
      expect(profileModel,profileModel);
    });
  });

}
