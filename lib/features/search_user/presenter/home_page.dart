import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/presenter/search_user_state.dart';
import 'package:mobile_challenge/features/search_user/presenter/search_user_store.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, SearchUserStore> {
  final _controller = TextEditingController();

  ListView _buildList(List<UserEntity> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.nickname),
        );
      },
    );
  }

  Shimmer _buildLoader() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFE0E0E0),
      highlightColor: Color(0xFFF5F5F5),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  height: 8,
                  width: 100,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pesquise...",
              ),
              onSubmitted: (text) {
                controller.makeSearch(text);
              },
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                var state = controller.state;
                if (state is LoadingState) {
                  return _buildLoader();
                }

                if (state is ErrorState) {
                  return Center(
                    child: Text('Error ao buscar usuário'),
                  );
                }

                if (state is LoadedState) {
                  return _buildList(state.users);
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
