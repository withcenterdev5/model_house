import 'package:flutter/material.dart';
import 'package:model_house/admin/admin.service.dart';
import 'package:model_house/model_house.dart';

/// 관리자인지 판단하여 위젯 빌드
///
/// [builder] 함수에 관리자인지 여부를 파라메타로 전달된다. 이 파라메타에는 배열로 관리자의
/// 권한이 전달된다. 관한 지정이 없는 일반 관리자는 빈 문자열이 전달될 수 있다. 관리자가 아니면,
/// 배열이 아니라 null 값이 전달된다.
///
/// 이 위젯은 AdminService.instance.init() 이 호출된 후에 사용해야 한다. 그렇지 않으면
/// 에러 문자열을 화면에 표시한다.
///
class Admin extends StatelessWidget {
  const Admin({
    super.key,
    required this.builder,
  });

  final Widget Function(List<String>? roles) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AdminService.instance.adminChange,
      builder: (context, snapshot) {
        final service = AdminService.instance;
        if (service.initialized == false) {
          return const Text('Admin Service is not initialized');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        final admins = snapshot.data;
        return builder(admins?[my!.uid]);
      },
    );
  }
}
