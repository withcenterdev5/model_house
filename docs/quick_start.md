# 간단한 설명과 사용법

먼저 빠르게 경험을 해 보고 싶은 분들을 위해서 짧게 설명을 한다.



## 간단한 초기화 방법

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.setDeviceLocale();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

