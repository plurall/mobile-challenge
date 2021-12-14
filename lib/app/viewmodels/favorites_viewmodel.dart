import 'package:mobile_challenge/app/interfaces/favorites_database_interface.dart';
import 'package:mobile_challenge/app/models/favorites_model.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/services/favorites_database_service.dart';

class FavoritesViewModel {
  final IFavoritesDatabase repository;

  FavoritesViewModel({this.repository});

  Future delete(int id) async {
    await FavoriteDatabaseService.instance.delete(id);
  }

  Future create(
      String login, String email, String location, String bio, int id) async {
    if (email == null) email = "sem e-mail";
    if (location == null) location = "sem localização";
    if (bio == null) bio = "sem bio";
    final data = FavoritesModel(
      id: id,
      login: login,
      email: email,
      location: location,
      bio: bio,
      // createdTime: DateTime.now(),
    );

    await FavoriteDatabaseService.instance.create(data);
  }
}
