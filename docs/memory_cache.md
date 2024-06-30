# 메모리 캐시

데이터베이스에서 가져 온 데이터를 다시 가져오지 않기 위해서, 메모리에 보관해 둘 때 사용하는 패키지로 pub.dev 의 [Memory Cache](https://pub.dev/packages/memory_cache) 를 사용한다.

아래는 Memory Cache 패키지의 설명을 그대로 가져온 것이다.



> Memory Cache is simple, fast and global in-memory cache.

## Features

- Create, read, update, delete and invalidate cache.
- Expirable Cache
- Creating local MemoryCache instance.

## Getting started

### Use this package as a Library
---
Depend On it

Run this command

with Dart: 
```
$ dart pub add memory_cache
```
with Flutter: 
```
$ flutter pub add memory_cache
```
This will add a line like this to your package's pubspec.yaml (and run an implicit `dart pub get` or `flutter pub get`):
```
dependencies:
  memory_cache: ^1.2.0
```

## Usage

### Create New Value
```dart
MemoryCache.instance.create('myKey', 'myValue');
```
with Expiry:
```dart
MemoryCache.instance.create(
    'myKey',
    'myValue',
    expiry: const Duration(seconds: 5),
  );
```

### Read Value
```dart
final myValue = MemoryCache.instance.read<String>('myKey');
```

### Update Value
```dart
MemoryCache.instance.update('myKey', 'myUpdatedValue');
```

### Delete Value
```dart
MemoryCache.instance.delete('myKey');
```

### Local Instance

MemoryCache can be created locally and same features will be supported

```dart
final MemoryCache localCache = MemoryCache();
```