import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/app/modules/user/presentation/widgets/user_listview.dart';

import '../../../../shared/utils/app_colors.dart';
import '../widgets/empty_content_widget.dart';
import '../widgets/loading_indicator_widget.dart';
import '../widgets/user_tile.dart';
import 'favorites_page_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({ Key? key }) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final controller = FavoritesPageController();

  @override
  void initState() {
    controller.getFavorites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Observer(builder: (_) {
              if (controller.state == FavoritesPageState.IDLE) {
                  if (controller.favorites.isEmpty) {
                      return EmptyContentWidget();
                  }
                  return UserListView(
                    padding: EdgeInsets.only(top: 24),
                    users: controller.favorites,
                  );
              }
              else if (controller.state == FavoritesPageState.LOADING) {
                return LoadingIndicatorWidget();
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: AppColors.primaryTextColor,
      ),
      title: Text("Favorites",
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 21,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

}