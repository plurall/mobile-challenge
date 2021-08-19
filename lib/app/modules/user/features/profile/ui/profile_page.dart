import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/utils/app_colors.dart';
import '../domain/entities/user_detail_entity.dart';
import '../domain/usecases/user_profile.dart';
import 'profile_page_controller.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage(this.username);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfilePageController controller;

  @override
  void initState() {
    final usecase = Modular.get<UserProfile>();
    controller = ProfilePageController(usecase);
    controller.getUserDetail(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Observer(builder: (_) {
        if (controller.state == ProfilePageState.LOADING) {
          return _buildLoadingIndicator();
        } else {
          final userDetail = controller.userDetail!;
          return _buildUserDetailContent(userDetail);
        }
      }),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Platform.isIOS ? CupertinoActivityIndicator() 
        : CircularProgressIndicator(strokeWidth: 1, color: AppColors.accentColor),
    );
  }

  Center _buildUserDetailContent(UserDetailEntity userDetail) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: CachedNetworkImage(
              imageUrl: userDetail.avatarUrl, 
              height: 150, 
              width: 150
            ),
          ),
          SizedBox(height: 24),
          userDetail.name != null ? Text(userDetail.name!,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 21
            ),
          ) : SizedBox(),
          SizedBox(height: 12),
          Text("@${userDetail.login}",
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12),
          userDetail.location != null ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: AppColors.secondaryTextColor),
              SizedBox(width: 12),
                Text(userDetail.location!,
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ) : SizedBox(),
          SizedBox(height: 24),
          userDetail.bio != null ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(width: 1, color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(userDetail.bio!,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ) : SizedBox(),
        ],
      ),
    );
  }
}