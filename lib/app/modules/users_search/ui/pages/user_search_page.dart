import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/app/common/constants/app_string.dart';
import 'package:mobile_challenge/app/utils/form_field_validations.dart';
import 'package:mobile_challenge/app/common/widgets/custom_text_field.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/widgets/user_search_list_widget.dart';

import '../controller/user_search_controller.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
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
        title: Text(AppString.titleSearchPage),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Form(
                      key: _form,
                      child: CustomFormFieldWidget(
                        hint: AppString.fieldLabel,
                        prefix: Icon(Icons.search),
                        textInputType: TextInputType.text,
                        controller: searchController,
                        validator: (text) => FieldValidation.isEmpty(text),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: submit,
                      child: Text(AppString.btnSearchLabel),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: availableHeight * 0.82,
              child: Observer(
                builder: (_) {
                  return _controller.userList.userListEntity!.isNotEmpty
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
