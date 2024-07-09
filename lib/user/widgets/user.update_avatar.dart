import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

/// UserAvatarUpdate
///
/// Displays the user's avatar.
///
/// [badgeNumber] is the number of notifications.
///
/// [delete] is the callback function that is being called when the user taps the delete button.
///
///
/// [onUploadSuccess] is the callback function that is being called when the user's avatar is uploaded.
///
///
class UserUpdateAvatar extends StatefulWidget {
  const UserUpdateAvatar({
    super.key,
    this.size = 140,
    this.radius = 60,
    this.badgeNumber,
    this.delete = false,
    this.onUploadSuccess,
    this.uploadStrokeWidth = 6,
    this.shadowBlurRadius = 16.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.progressBuilder,
  });

  final double size;
  final double radius;
  final int? badgeNumber;
  final bool delete;
  final double uploadStrokeWidth;
  final double shadowBlurRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final void Function()? onUploadSuccess;
  final Widget Function(double? progress)? progressBuilder;

  @override
  State<UserUpdateAvatar> createState() => _UserUpdateAvatarState();
}

class _UserUpdateAvatarState extends State<UserUpdateAvatar> {
  double? progress;

  bool get isNotUploading {
    return progress == null || progress == 0 || progress!.isNaN;
  }

  bool get isUploading => !isNotUploading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ///
        await StorageService.instance.uploadAt(
          context: context,
          ref: UserService.instance.col.doc(my!.uid),
          progress: (p) => setState(() => progress = p),
          complete: () => setState(() => progress = null),
        );
      },
      child: Stack(
        children: [
          MyDoc(
            builder: (user) => UserAvatar(
              user: user!,
              size: widget.size,
              radius: widget.radius,
            ),
          ),
          uploadProgressIndicator(color: Colors.white),
          if (isUploading)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  ((progress ?? 0) * 100).toInt().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (isNotUploading)
            Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                size: 32,
              ),
            ),
          if (widget.delete && isNotUploading)
            StreamBuilder(
              stream: UserService.instance.col.doc(my!.uid).snapshots(),
              builder: (_, event) => event.hasData && event.data!.exists
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () async {
                          /// 이전 사진 삭제
                          ///
                          /// 삭제 실패해도, 계속 진행되도록 한다.
                          StorageService.instance
                              .delete(event.data!['photoUrl']);
                          UserService.instance.col.doc(my!.uid).update({
                            'photoUrl': FieldValue.delete(),
                          });
                        },
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.grey.shade600,
                          size: 30,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }

  uploadProgressIndicator({Color? color}) {
    if (isNotUploading) return const SizedBox.shrink();
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: widget.progressBuilder?.call(progress) ??
            SizedBox(
              width: widget.radius,
              height: widget.radius,
              child: CircularProgressIndicator(
                strokeWidth: widget.uploadStrokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? Theme.of(context).primaryColor,
                ),
                value: progress,
              ),
            ),
      ),
    );
  }
}
