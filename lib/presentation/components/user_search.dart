import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatefulWidget {
  final bool haveFoundUsers;
  final Function onPress;
  final Function clearSearchFeedback;

  UserSearch(this.onPress, this.haveFoundUsers, this.clearSearchFeedback);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final _form = GlobalKey<FormState>();
  final _searchFieldController = TextEditingController();

  tryValidate() {
    Future.delayed(const Duration(milliseconds: 100),
        () => _form.currentState?.validate() ?? null);
  }

  onSearchFieldChange() {
    widget.clearSearchFeedback(tryValidate);
  }

  @override
  void initState() {
    super.initState();
    final String initialSearchValue =
        Provider.of<SearchProvider>(context, listen: false).search;
    _searchFieldController.text = initialSearchValue;
    if (initialSearchValue.length > 0) {
      widget.onPress(initialSearchValue, tryValidate);
    }
    _searchFieldController.addListener(onSearchFieldChange);
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Nome',
            ),
            controller: _searchFieldController,
            onChanged: (value) =>
                Provider.of<SearchProvider>(context, listen: false).search =
                    value,
            validator: (value) {
              if (!widget.haveFoundUsers) {
                return 'Não foram encontrados usuários com esta busca';
              }
              if (value!.isEmpty) {
                return 'Digite o nome do usuário';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    widget.onPress(_searchFieldController.text, tryValidate),
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enviando...')),
                    ),
                  },
              },
            ),
          ),
        ],
      ),
    );
  }
}
