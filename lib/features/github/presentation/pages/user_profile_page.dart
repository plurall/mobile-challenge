import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/error_image_widget.dart';

import '../../../../injection_container.dart';

const kPadding = 24.0;

class UserProfilePage extends StatefulWidget {
  final String username;

  const UserProfilePage({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final controller = sl<UserProfileStore>();

  @override
  void initState() {
    super.initState();
    controller.getUserInfo(widget.username);
    controller.checkIfUserIsSaved(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: _size.width,
              height: _size.height * 0.35,
              padding: EdgeInsets.only(left: kPadding + 20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: paddingTop + 20,
            left: kPadding,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: _size.height * 0.28,
            child: Container(
              width: _size.width * 0.92,
              height: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(7, 7),
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Observer(
                builder: (context) =>
                    _getWidgetBasedOnStatus(context, controller),
              ),
            ),
          ),
          Observer(builder: (_) {
            return ProfilePictureWidget(
              imageUrl: controller.userEntity?.avatarUrl ?? null,
            );
          }),
        ],
      ),
    );
  }
}

Widget _getWidgetBasedOnStatus(
    BuildContext context, UserProfileStore controller) {
  if (controller.userStatus is Idle) {
    return SizedBox();
  } else if (controller.userStatus is Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (controller.userStatus is Error) {
    return Center(child: Text(controller.userStatus.props.first));
  }

  return UserInfoWidget(
    controller: controller,
  );
}

class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;

  const ProfilePictureWidget({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    final imageRadius = 60.0;

    return Positioned(
      top: _size.height * 0.28 - imageRadius,
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(imageRadius),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 2 * imageRadius,
                width: 2 * imageRadius,
                placeholder: (_, __) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => Icon(Icons.broken_image_rounded),
              ),
            )
          : ErrorImageWidget(
              imageRadius: imageRadius,
              iconSize: 40,
            ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  final UserProfileStore controller;
  const UserInfoWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  controller.isSaved
                      ? controller.removeUserFromBookmarks()
                      : controller.saveUser();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        controller.isSaved
                            ? 'Usuário removido dos favoritos'
                            : 'Usuário adicionado aos favoritos',
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Observer(builder: (_) {
                  return Icon(
                    controller.isSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                  );
                }),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 25),
          Text(
            controller.userEntity.name ?? controller.userEntity.login,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 24),
              Container(
                // width: 120,
                child: Text(
                  controller.userEntity.location ??
                      'Localização não disponível',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail_outline, size: 24),
              SizedBox(width: 10),
              Container(
                child: Text(
                  controller.userEntity.email ?? 'Email não disponível',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(controller.userEntity.bio ?? 'Nenhuma descrição'),
          ),
        ],
      ),
    );
  }
}
