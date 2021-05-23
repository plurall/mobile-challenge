import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/page/main_view_model.dart';
import 'package:mobile_challenge/app/shared/components/item/search_item_widget.dart';
import 'package:stacked/stacked.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(context),
      builder: (context, model, child) {
        _viewModel = model;
        return _buildRoot(context);
      },
    );
  }

  Scaffold _buildRoot(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub usúarios"),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 24),
              _buildLoading(),
              _buildStatusMessage(),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Pesquisar...',
        contentPadding: EdgeInsets.fromLTRB(10, 6, 0, 6),
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (text) async {
        if (_viewModel.currentSearch == text) return;
        _viewModel.currentSearch = text;
        _viewModel.fecthSearchUsersAsync();
      },
    );
  }

  Widget _buildLoading() {
    return Visibility(
      visible: _viewModel.isBusy,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildStatusMessage() {
    final length = _viewModel.searchModel?.items?.length ?? 0;
    return Visibility(
      visible: (_viewModel.hasError || length == 0) && !_viewModel.isBusy,
      child: Text(
        "Nenhum usuário encontrado",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildListView() {
    final length = _viewModel.searchModel?.items?.length ?? 0;
    return Visibility(
      visible: !_viewModel.isBusy,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          final item = _viewModel.searchModel.items[index];
          return SearchItemWidget(item: item);
        },
      ),
    );
  }
}
