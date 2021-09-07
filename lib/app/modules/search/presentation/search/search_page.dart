import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mobile_challenge/app/core/widgets/list_tile_area.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/search_store.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/widgets/custom_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Pesquisar',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 300),
      onQueryChanged: (query) async {
        if (query != '') {
          controller.setSearchText(query);
        }
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        )
      ],
      builder: (context, transition) {
        var content;
        return Observer(builder: (_) {
          var state = controller.state;

          if (state is SearchError) {
            content = ListTileArea(
              child: Center(
                child: Text("Ops houve um erro"),
              ),
            );
          }

          if (state is SearchStart) {
            content = ListTileArea(
              child: Center(
                child: Text("Digite sua pesquisa"),
              ),
            );
          } else if (state is SearchLoading) {
            return ListTileArea(
              child: Center(
                child: CircularProgressIndicator(color: Colors.black,),
              ),
            );
          } else if (state is SearchSuccess) {
            var list = (state).list;

            content = Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: list.map((item) {
                          return CustomListTile(
                            userSearch: item,
                          );
                        }).toList(),
                      ),
                  ),
                )
            );
          } else {
            content = Container();
          }
          return content;
        });
      },
    );
  }
}
