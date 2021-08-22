import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                return _buildLoadingIndicator();
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
        return _buildUserTile(user);
      }
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Platform.isIOS ? CupertinoActivityIndicator() 
      : CircularProgressIndicator(
        strokeWidth: 1,
      ),
    );
  }

  Widget _buildUserTile(UserDetailEntity user) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed("/profile/${user.login}"),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: CachedNetworkImage(
                imageUrl: user.avatarUrl,
                height: 56,
                width: 56,
              ),
            ),
            SizedBox(width: 12),
            Text(user.login,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ),
    );
  }
}