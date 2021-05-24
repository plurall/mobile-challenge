import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_state.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_store.dart';
import 'package:shimmer/shimmer.dart';

class DetailsUserPage extends StatefulWidget {
  final String username;

  const DetailsUserPage({Key? key, required this.username}) : super(key: key);
  @override
  _DetailsUserPageState createState() => _DetailsUserPageState();
}

class _DetailsUserPageState
    extends ModularState<DetailsUserPage, UserDetailStore> {
  @override
  void initState() {
    controller.showUserDetail(widget.username);
    super.initState();
  }

  Padding _buildUserDetail(UserDetailEntity user) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Column(
        children: [
          Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  user.image,
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          Row(
            children: [
              Expanded(child: _rowInfo(label: 'Nickname', desc: user.nickname)),
              Observer(builder: (_) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (!controller.isFavorited) {
                      controller.favoriteUser(user);
                    }
                  },
                  icon: Icon(
                    controller.isFavorited ? Icons.favorite_border : Icons.face,
                    size: 12,
                  ),
                );
              }),
            ],
          ),
          _rowInfo(label: 'E-mail', desc: user.email ?? ''),
          _rowInfo(label: 'Localização', desc: user.location ?? ''),
          _rowInfo(label: 'Bio', desc: user.bio ?? ''),
        ],
      ),
    );
  }

  Padding _rowInfo({required String label, required String desc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Expanded(child: Text(desc)),
        ],
      ),
    );
  }

  Shimmer _buildLoader() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFE0E0E0),
      highlightColor: Color(0xFFF5F5F5),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
            ),
            Column(
              children: [1, 2, 3, 4]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(height: 10, width: 40, color: Colors.white),
                          SizedBox(width: 8),
                          Container(
                              height: 10, width: 100, color: Colors.white),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do usuário"),
        brightness: Brightness.dark,
      ),
      body: Container(
        child: Observer(builder: (_) {
          var state = controller.state;
          if (state is LoadingState) {
            return _buildLoader();
          }
          if (state is ErrorState) {
            return Center(
              child: Text('Error ao buscar detalhes do usuário'),
            );
          }

          if (state is LoadedState) {
            return _buildUserDetail(state.user);
          }

          return Container();
        }),
      ),
    );
  }
}
