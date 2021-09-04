import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/search_store.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Pesquisar',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) async {
        if (query != '') {
          controller.setSearchText(query);
        }
        setState(() {});
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        )
      ],
      builder: (context, transition) {
        return Observer(builder: (_) {
          var state = controller.state;

          if (state is SearchError) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text("Ops houve um erro"),
                    ),
                  ),
                ));
          }

          if (state is SearchStart) {
            return Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Text("Digite sua pesquisa"),
                      ),
                  )),
            ));
          } else if (state is SearchLoading) {
            return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Container(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.black,),
                        ),
                      )),
                ));
          } else if (state is SearchSuccess) {
            final list = (state).list;
            return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: list.map((item) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: ListTile(
                                leading: ClipOval(
                                  child: Image.network(item.avatar),
                                ),
                                title: Text(item.title),
                                trailing: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.star_border_rounded, color: Colors.black,)
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                ));
          } else {
            return Container();
          }
        });
      },
    );
  }
}
