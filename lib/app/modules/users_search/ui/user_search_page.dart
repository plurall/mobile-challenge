import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/app/utils/form_field_validations.dart';
import 'package:mobile_challenge/app/common/widgets/custom_text_field.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/widgets/user_search_list_widget.dart';

import 'controller/user_search_controller.dart';

class UserSearchHeaderPage extends StatefulWidget {
  const UserSearchHeaderPage({Key? key}) : super(key: key);

  @override
  State<UserSearchHeaderPage> createState() => _UserSearchHeaderPageState();
}

class _UserSearchHeaderPageState extends State<UserSearchHeaderPage> {
  final _form = GlobalKey<FormState>();
  late UserSearchController _controller;
  final TextEditingController? searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = GetIt.instance<UserSearchController>();
  }

  Future<void> submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }

    await _controller.userSearch(searchController!.text);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca de usuários - GitHub'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomFormFieldWidget(
                  hint: 'Usuário',
                  prefix: Icon(Icons.search),
                  textInputType: TextInputType.text,
                  controller: searchController,
                  validator: (text) => FieldValidation.isEmpty(text),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: submit,
              child: Text('Pesquisar'),
            ),
            Container(
              width: double.infinity,
              height: availableHeight * 0.69,
              child: Observer(
                builder: (_) {
                  return _controller.userList.isNotEmpty
                      ? UserListWidget(
                          userList: _controller.userList,
                        )
                      : _controller.loading
                          ? Center(child: CircularProgressIndicator())
                          : Center(
                              child: Icon(
                                Icons.list_outlined,
                                size: 120.0,
                                color: Colors.grey,
                              ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
