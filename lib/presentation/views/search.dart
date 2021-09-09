import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final viewModel = GetIt.instance.get<SearchViewModel>();
  final _form = GlobalKey<FormState>();
  final _searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenKeyboardChanges();
    reloadLastSearch();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  reloadLastSearch() {
    final String initialSearchValue =
        Provider.of<SearchProvider>(context, listen: false).search;
    _searchFieldController.text = initialSearchValue;
  }

  listenKeyboardChanges() =>
      _searchFieldController.addListener(onSearchFieldChange);

  onSearchFieldChange() => viewModel.clearSearchError();

  tryValidate() {
    Future.delayed(const Duration(milliseconds: 100),
        () => _form.currentState?.validate());
  }

  onSearch(String searchData) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enviando...')),
    );
    await viewModel.search(searchData);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() => tryValidate());
  }

  Widget _showForm() => Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              controller: _searchFieldController,
              onChanged: (value) =>
                  Provider.of<SearchProvider>(context, listen: false).search =
                      value,
              validator: (value) {
                if (!viewModel.haveFoundUsers()) {
                  return 'Não foram encontrados usuários com esta busca';
                }
                if (value!.isEmpty) {
                  return 'Digite o nome do usuário';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Buscar'),
                    Icon(Icons.search),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () => {
                  if (_form.currentState!.validate())
                    {
                      onSearch(_searchFieldController.text),
                    },
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    final users = viewModel.getUsers();
    return Container(
      margin: const EdgeInsets.all(10),
      child: isConnected
          ? Column(
              children: [
                _showForm(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserCard(users[index]);
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Não é possível realizar buscas, verifique a sua conexão com a Internet.',
              ),
            ),
    );
  }
}
