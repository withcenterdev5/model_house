# 위젯

각 기능별 필요한 위젯은 각 기능 폴더에 저장되어져 있다.



## LabelField

`LabelField` 위젯은 Label 과 TextField 를 합쳐 놓은 것이다. 레이블이 상단에 표시되고 그 아래에 입력 박스가 표시된다.

```dart
Theme(
  data: Theme.of(context).copyWith(
    inputDecorationTheme:
        Theme.of(context).inputDecorationTheme.copyWith( /* ... */ ),
  ),
  child: LabelField(
    label: T.email.tr,
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      prefixIcon: Icon(
        Icons.email,
      ),
    ),
  ),
),
```
