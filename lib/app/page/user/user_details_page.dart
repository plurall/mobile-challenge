import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/page/user/user_details_view_model.dart';
import 'package:mobile_challenge/app/shared/components/image/custom_network_image.dart';
import 'package:stacked/stacked.dart';

class UserDetailsPage extends StatefulWidget {
  final String login;

  const UserDetailsPage({
    Key key,
    this.login,
  }) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UserDetailsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailsViewModel>.reactive(
      viewModelBuilder: () => UserDetailsViewModel(context, widget.login),
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.fecthUserDetailAsync(),
      builder: (context, model, child) {
        _viewModel = model;
        return _buildRoot(context);
      },
    );
  }

  Scaffold _buildRoot(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usúario"),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildStatusView(),
        ),
      ),
    );
  }

  Widget _buildStatusView() {
    if (_viewModel.isBusy) {
      return _buildLoading();
    }

    if (_viewModel.hasError) {
      return _buildErrorMessage();
    }

    return _buildContentInfo();
  }

  Widget _buildLoading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      "Nenhum usuário encontrado",
      textAlign: TextAlign.center,
    );
  }

  Column _buildContentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildImageUrl(),
        const SizedBox(height: 16),
        _buildText(_viewModel.userModel?.name),
        const SizedBox(height: 16),
        _buildText(_viewModel.userModel?.location),
        const SizedBox(height: 16),
        _buildText(_viewModel.userModel?.bio),
        const SizedBox(height: 16),
        _buildText(_viewModel.userModel?.email),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImageUrl() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          child: CustomNetworkImage(
            imageUrl: _viewModel.userModel?.avatarUrl ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Visibility(
      visible: text != null,
      child: Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 20),
      ),
    );
  }
}
