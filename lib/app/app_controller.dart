import 'package:mobile_challenge/app/interfaces/local_storage_interface.dart';
import 'package:mobile_challenge/app/models/appconfig_model.dart';
import 'package:mobile_challenge/app/services/shared_local_storage_service.dart';
import 'package:mobile_challenge/app/viewmodels/change_theme_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class AppController {
  static final AppController instance = AppController._();
  AppController._() {
    changeThemeViewModel.init();
  }

  final ChangeThemeViewModel changeThemeViewModel =
      ChangeThemeViewModel(storage: SharedLocalStorageService());

  bool get isDark => changeThemeViewModel.config.themeSwitch.value;
  ValueNotifier<bool> get themeSwitch =>
      changeThemeViewModel.config.themeSwitch;
}
