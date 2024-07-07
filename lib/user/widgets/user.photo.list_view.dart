import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

///
class UserPhotoListView extends StatelessWidget {
  const UserPhotoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: UserListView(
        scrollDirection: Axis.horizontal,
        itemBuilder: (user, index) => Padding(
          padding: EdgeInsets.fromLTRB(index == 0 ? 24 : 4, 0, 4, 0),
          child: SizedBox(
            width: 72 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(user: user),
                DisplayName(user: user, maxLines: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
