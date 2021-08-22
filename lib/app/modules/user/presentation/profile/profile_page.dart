import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/app_colors.dart';
import '../../domain/entities/user_detail_entity.dart';
import '../widgets/loading_indicator_widget.dart';
import '../widgets/no_internet_connection_widget.dart';
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
    controller = ProfilePageController();
    controller.getUserDetail(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Observer(builder: (_) {
                if (controller.state == ProfilePageState.IDLE) {
                    final userDetail = controller.userDetail!;
                    return _buildUserDetailContent(userDetail);
                }
                else if (controller.state == ProfilePageState.LOADING) {
                  return LoadingIndicatorWidget();
                }
                else if (controller.state == ProfilePageState.NO_INTERNET) {
                  return NoInternetConnectionWidget();
                }
                return Container();
              }),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: _buildBackButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return BackButton(
      onPressed: () => Modular.to.pop(),
      color: AppColors.primaryTextColor,
    );
  }

  Center _buildUserDetailContent(UserDetailEntity userDetail) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: CachedNetworkImage(
                imageUrl: userDetail.avatarUrl, 
                height: 120, 
                width: 120
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
            userDetail.bio != null ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                textAlign: TextAlign.center,
              ),
            ) : SizedBox(),
            SizedBox(height: 12),
            _buildFavoriteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    bool isFavorite = controller.isFavorite;
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isFavorite ? AppColors.accentColor.withOpacity(.1) : AppColors.accentColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => isFavorite
            ? controller.removeFavorite()
            : controller.saveFavorite(),
          splashColor: AppColors.primaryTextColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined ,
                color: isFavorite? AppColors.accentColor : Colors.white
              ),
              SizedBox(width: 12),
              Text("Favorito",
                style: TextStyle(
                  color: isFavorite? AppColors.accentColor : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}