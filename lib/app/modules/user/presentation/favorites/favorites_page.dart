import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/presentation/widgets/loading_indicator_widget.dart';
import 'package:mobile_challenge/app/modules/user/presentation/widgets/user_tile.dart';

import '../../../../shared/utils/app_colors.dart';
import '../../domain/entities/user_detail_entity.dart';
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
                      return _buildEmptyFavoriteList();
                  }
                  return _buildSearchedUserListView();
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

  Widget _buildEmptyFavoriteList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text("There's nothing here yet",
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w300,
            fontSize: 14
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  Widget _buildSearchedUserListView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 24),
      itemCount: controller.favorites.length,
      itemBuilder: (_, index) {
        final user = controller.favorites[index];
        return UserTile(user);
      }
    );
  }

}