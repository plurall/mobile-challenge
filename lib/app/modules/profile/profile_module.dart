import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/profile/data/remote_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/profile/domain/usecases/user_profile.dart';
import 'package:mobile_challenge/app/modules/profile/infra/repositories/profile_repository_impl.dart';

import 'ui/profile_page.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => RemoteProfileDatasource(i())),
    Bind((i) => ProfileRepositoryImpl(i())),
    Bind((i) => UserProfileImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/:username', child: (_, args) => ProfilePage(args.params["username"])),
  ];

}