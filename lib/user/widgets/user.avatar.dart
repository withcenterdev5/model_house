import 'package:flutter/material.dart';
import 'package:model_house/user/widgets/user_doc.dart';

// temporary using image.network for now bucase cached_network_image is currently
// outdated with the current flutter sdk
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.uid,
    this.size = 48,
    this.radius = 20,
    this.border,
  });
  final String uid;
  final double size;
  final double radius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return UserDoc.sync(
      uid: uid,
      builder: (user) {
        if (user!.photoUrl == null) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(radius),
                border: border),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: border,
            ),
            child: Image.network(
              user.photoUrl!,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
