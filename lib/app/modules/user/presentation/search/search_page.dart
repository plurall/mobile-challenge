import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/presentation/widgets/user_tile.dart';
import 'package:mobile_challenge/app/shared/utils/app_colors.dart';
import 'package:mobile_challenge/app/modules/user/presentation/widgets/no_internet_connection_widget.dart';

import '../../domain/entities/user_detail_entity.dart';
import '../../domain/usecases/search_user.dart';
import 'search_page_controller.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final usecase = Modular.get<SearchUserImpl>();
  late final SearchPageController controller;
  final double searchBarHeight = 60;
  @override
  void initState() {
    controller = SearchPageController(usecase);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Observer(builder: (_) {
              if (controller.state == SearchPageState.IDLE) {
                  if (controller.searchedUsers.isEmpty) {
                      return _buildEmptyListContent();
                  }
                  return _buildSearchedUserListView();
              }
              else if (controller.state == SearchPageState.LOADING) {
                return _buildLoadingIndicator();
              }
              else if (controller.state == SearchPageState.NO_INTERNET) {
                return NoInternetConnectionWidget();
              }
              return Container();
            }),
          ),
          _buildHeader(),
        ],
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("Github Search",
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 21,
          fontWeight: FontWeight.w500
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Modular.to.pushNamed('/profile/favorites'), 
          icon: Icon(Icons.favorite, color: Colors.redAccent)
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          height: searchBarHeight,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.16),
                offset: Offset(0,10),
                blurRadius: 60
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              isCollapsed: true,              
              hintText: "Type to search",
              suffixIcon: Icon(Icons.search, color: AppColors.primaryTextColor),
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: controller.onChangeSearchText
          ),
        )
      ],
    );
  }

  Widget _buildEmptyListContent() {
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
      padding: EdgeInsets.only(top: searchBarHeight + 24),
      itemCount: controller.searchedUsers.length,
      itemBuilder: (_, index) {
        final user = controller.searchedUsers[index];
        return UserTile(user);
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
}