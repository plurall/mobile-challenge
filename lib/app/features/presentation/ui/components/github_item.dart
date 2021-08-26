import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/features/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_user_detail_page.dart';

class GithubItem extends StatelessWidget {
  final ResultSearch resultSearch;

  const GithubItem({Key? key, required this.resultSearch}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return GithubUserDetailPage(username: resultSearch.username!);
          }),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: resultSearch.imageUrl!.isNotEmpty
                        ? Image.network(
                            resultSearch.imageUrl!,
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  resultSearch.username!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
