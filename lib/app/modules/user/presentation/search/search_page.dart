
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/usecases/search_user.dart';
import '../widgets/empty_content_widget.dart';
import '../widgets/loading_indicator_widget.dart';
import '../widgets/no_internet_connection_widget.dart';
import '../widgets/user_listview.dart';
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
                      return EmptyContentWidget();
                  }
                  return UserListView(
                    padding: EdgeInsets.only(top: searchBarHeight + 12),
                    users: controller.searchedUsers
                  );
              }
              else if (controller.state == SearchPageState.LOADING) {
                return LoadingIndicatorWidget();
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
      title: Text("Mobile Challange",
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
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            onSubmitted: controller.searchUsers,
          ),
        )
      ],
    );
  }
}