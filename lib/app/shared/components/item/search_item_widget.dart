import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/helpers/router_helper.dart';
import 'package:mobile_challenge/app/shared/components/image/custom_network_image.dart';
import 'package:mobile_challenge/app/shared/model/serach_item/search_item_model.dart';
import 'package:mobile_challenge/config/main_common.dart';

class SearchItemWidget extends StatelessWidget {
  final SearchItemModel item;

  const SearchItemWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
      elevation: 4.0,
      child: InkWell(
        onTap: () => onShowNextPage(context),
        splashColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.3),
        child: Ink(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageUrl(context),
              _buildContentText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUrl(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
      child: CustomNetworkImage(
        imageUrl: item.avatarUrl ?? "",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContentText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextTitle(context),
          const SizedBox(height: 4),
          _buildTextDescription(context),
        ],
      ),
    );
  }

  Widget _buildTextTitle(BuildContext context) {
    return Text(
      "Login:",
      style: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
    );
  }

  Widget _buildTextDescription(BuildContext context) {
    return Text(
      item.login,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  void onShowNextPage(BuildContext context) {
    onHideKeyboard(context);
    Navigator.pushNamed(
      context,
      R.userDetailsPage,
      arguments: item.login,
    );
  }

  void onHideKeyboard(BuildContext context) {
    try {
      FocusScope.of(context).unfocus();
    } catch (error) {
      logger.d('FocusScope $error');
    }
  }
}
