import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? info;

  const UserInfo(this.icon, this.label, this.info);

  @override
  Widget build(BuildContext context) {
    if (info == null || info!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(info!),
          ),
        ],
      ),
    );
  }
}
