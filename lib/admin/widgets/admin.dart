import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

/// 관리자인지 판단하여 위젯 빌드 할 때 사용
///
/// [builder] 함수에 관리자인지 여부를 파라메타로 전달된다. 전달되는 파라메타의 값이
/// 관리자이면 true 이고, 아니면 false 이다.
///
/// 참고로, 이 위젯은 reacitve 하다. 굳이 실시간 업데이트를 할 필요 없지만,
/// [MyDoc] 을 사용하므로, 자동으로 reactive 하게 동작한다.
class Admin extends StatelessWidget {
  const Admin({
    super.key,
    required this.builder,
  });

  final Widget Function(bool) builder;

  @override
  Widget build(BuildContext context) {
    return MyDoc(builder: (user) {
      return builder(user?.admin ?? false);
    });
  }
}
