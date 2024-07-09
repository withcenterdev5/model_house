# 사용자


## 설치

## 초기화

현재 사용자가 로그인 및 정보 관리를 위해서는 `UserService.instance.init()` 을 통해서 초기화를 해야 한다. 그렇지 않으면 현재 사용자의 로그인 상태나 기타 기능을 사용 할 수 없다. 다만, 로그인 사용자가 아닌, 다른 사용자 정보를 참조할 때에는 초기화가 필요없다.

초기화가 되면, 사용자 문서의 `User` 모델 객체가 `UserService.instance.user` 에 보관되고 실시간 업데이트된다.



## 데이터베이스

- Firestore 를 기본적으로 사용한다.
- `/users` 컬렉션이 사용자 문서 이다.
- `name` 은 사용자 전체 이름(full name)이다.
- `displayName` 은 사용자 별명이며, 화면에 나타나는 이름이다.



## 헬퍼 함수

`iam` 과 `i` 는 글로벌 변수로 단순히 `UserService.instance` 를 짧게 쓰기 위한 alias 이다. 필요없으면 안써도 되고, 적절하게 사용을 하면 된다.


`my` 변수는 글로벌 변수로 `UserService.instance.user` 를 짧게 쓰기 위한 alias 이다.

## 로그인

하우스에서 이메일/비밀번호를 통한 기본적인 회원 가입 및 회원 정보 수정 위젯을 제공한다. 하지만, 실제 앱 개발을 할 때에는 각 앱에 맞는 로그인을 사용하기를 바란다. 어떤 방식이든 Firebase Auth 를 통해서 로그인을 하면 된다. 그러면 각 기능들이 Firebase Auth 서비스를 통해서 로그인 정보를 액세스하고 연동하여 잘 동작을 한다.





## 개인정보

예를 들면, 이름, 생년월일, 성별 등은 민감한 개인 정보로 개발자의 선택에 따라 비공개로 할 수 있다. 비공개로 하기 위해서는 Firestore 의 `/users` 컬렉션에 정보를 보관하면 안되고, `/users-private` 컬렉션에 따로 정보를 보관해야 한다. 참고로 email 과 phoneNumber 필드는 `하우스`가 내부적으로 처리를 비공개 처리를 해 주며, 그 외의 필드는 직접 `/user-private` 컬렉션에 저장해야하며, 이와 관련된 라이브러리가 제공된다.

어떤 필드를 비 공개로 할지 초기화 과정에서 지정을 해 주면 된다.

에제

```dart
my.private.email;
my.private.phoneNumber;
my.private.set('field', 'value');
```



## 관리자

관리자는 앱을 실행하여, 회원 가입하고, 최초 1회 `관리자되기` 버튼을 클릭하는 사용자가 `root` 관리자가 된다. 이 후 부터는 `root` 권한을 가진 관리자가 다른 사용자를 관리자로 임명하여 아래의 권한을 줄 수 있으며, 다른 관리자에게 `root` 권한을 줄 수 있다.

자세한 정보는 [관리자 문서](./admin.md)를 참고한다.



## 사용자 위젯

### 파이어베이스 로그인 UserState

`UserState` 위젯은 단순히, `Firebase.instance.authStateChanges` 내장하여 사용자의 Firestore 로그인 상태에 따라, UI 위젯을 빌드 할 수 있도록 해 놓은 것이다. 내부적으로 StreamBuilder 를 사용하므로, StreamBuilder 의 특성을 그대로 이용하면 된다.





### MyDoc

로그인한 사용자의 정보를 액세스 할 수 있다. 즉, 나의 이름이나 나이, 성별 등의 정보를 읽고 수정 할 수 있다.

주의 할 것은 로그인을 해도 builder 의 파라메타가 null 일 수 있다. 따라서 로그인을 했는지 하지 않았는지로 사용하지 않도록 한다.

다만, 나의 정보를 나타낼 때, 데이터가 로딩되었으면 위젯을 보여주고, 로딩되지 않았으면, 사용자 데이터를 로딩 중이라고는 표시 할 수 있다.



/// -- 여기서 부터


`UserService.instance.user` 는 DB 의 사용자 문서 값을 모델로 가지고 있는 변수이다. 짧게 `my` 로 쓸 수 있도록 해 놓았다. DB 의 값이 변경되면 실시간으로 이 변수의 값도 업데이트(sync)된다. 그래서 DB 에 값을 변경 한 다음, (약간 쉬었다) `my` 변수로 올바로 값이 저장되었는지 확인 할 수 있다. 예를 들면, form field 값 변경 즉시 저장하고, submit 버튼을 누르면 확인을 할 수 있다.

로그인한 사용자(나)의 정보를 참조하기 위해서는 `MyDoc` 를 사용하면 된다. 물론, `UserDoc` 를 사용해도 되지만, `MyDoc` 를 사용하는 것이 더 효과적이다. To reference the information of the logged-in user (yourself), you can use MyDoc. While using UserDoc is acceptable, using MyDoc is more effective.

Fireflutter 은 `UserService.instance.myDataChanges` 를 통해서 로그인 한 사용자의 데이터가 변경 될 때 마다, 자동으로 BehaviorSubject 인 `myDataChanges` 이벤트 시키는데 그 이벤트를 받아서 `MyDoc` 위젯이 동작한다. 그래서 추가적으로 DB 액세스를 하지 않아도 되는 것이다. Fireflutter uses UserService.instance.myDataChanges to automatically trigger the BehaviorSubject myDataChanges event whenever the data of the logged-in user changes. MyDoc widgets respond to this event, eliminating the need for additional DB access.

```dart
MyDoc(builder: (my) => Text("isAdmin: ${my?.isAdmin}"))
```

관리자이면 위젯을 표시하는 예. An example of displaying a widget if the user is an administrator:

```dart
MyDoc(builder: (my) => isAdmin ? Text('I am admin') : Text('I am not admin'))
```

If you are going to watch(listen) a value of a field, then you can use `MyDoc.field`.

```dart
MyDoc.field('${Field.blocks}/$uid', builder: (v) {
  return Text(v == null ? T.block.tr : T.unblock.tr);
})
```

### UserDoc



## 데이터베이스 구조

- 사용자 정보는 realtime database 의 `/users/<uid>` 에 기록된다.

`displayName` is the name of the user.
Firefluter (including all the widgets) will always use `dispalyName` to display the name of the user. This can be a real name, or it can be a nickname. If you want to keep user's name in different format like `firstName`, `middleName`, `lastName`, you can do it in your app. You may get user's real name and save it in `name` field in your app.

- `seearchDisplayName` 은 검색을 위한 용도로 사용한됩니다. 예를 들어 `displayName` 이, "JaeHo Song" 이면, "jaehosong" 으로 모두 소문자로 저장하며, 공백없이 저장을 합니다. 그래서 검색을 할 때, `Jaeho` 또는 `jaehoso` 등으로 검색을 보다 유연하게 할 수 있습니다.

`createdAt` has the time of the first login. This is the account creation time.

사용자의 본명 또는 화면에 나타나지 않는 이름은 `name` 필드에 저장한다.
화면에 표시되는 이름은 `displayName` 필드에 저장을 한다. The user's real name or a name not displayed on the screen is stored in the name field. The displayed name is saved in the `displayName` field.

`isVerified` 는 관리자만 수정 할 수 있는 필드이다. 비록 사용자 문서에 들어 있어도 사용자가 수정 할 수 없다. 관리자가 직접 수동으로 회원 신분증을 확인하고 영상 통화를 한 다음 `isVerified` 에 true 를 지정하면 된다. `isVerified` is a field that only administrators can modify. Even if it's included in the user document, users cannot modify it. Administrators manually confirm identity documents and conduct video calls. Afterward, they can set `isVerified` to true.

`gender` 는 `M` 또는 `F` 의 값을 가질 수 있으며, null (필드가 없는 상태) 상태가 될 수도 있다. 참고로, `isVerified` 가 true 일 때에만 성별 여부를 믿을 수 있다. 즉, `isVerified` 가 true 가 아니면, `gender` 정보도 가짜일 수 있다. `gender` can have values of `M` or `F` and may be in a null state (no field). Note that the gender information can only be trusted when `isVerified` is true. In other words, if `isVerified` is not true, gender information may also be false.

`blocks` 는 차단한 사용자의 목록을 가지고 있다. 차단은 사용자만 할 수 있다.
참고로, 좋아요는 사용자, 글, 코멘트, 채팅 등에 할 수 있고, 북마크는 사용자, 글, 코멘트 등에 할 수 있으나, 차단은 사용만 할 수 있다.
참고로, `likes` 는 쌍방으로 정보 확인이 가능해야한다. 이 말은 내가 누구를 좋아요 했는지 알아야 할 필요가 있고, 상대방도 내가 좋아요를 했는지 알아야 할 필요가 있다. 그래서 데이터 구조가 복잡해 `/user-likes` 에 따로 저장을 하지만, `blocks` 는 내가 누구를 차단했는지 다른 사람에게 알려 줄 필요가 없다. 그래서 `/users` 에 저장을 한다.

`latitude` 와 `longitude` 에 값이 저장되면 자동으로 `geohash4`, `geohash5`, `geohash6`, `geohash7` 에 GeoHash 문자열 4/5/6/7 자리 값이 저장된다. 즉, 위/경도의 값은 앱에서 Location 또는 GeoLocator 패키지를 써서, 퍼미션 설정을 하고, Lat/Lon 값을 구한 다음, `UserModel.update()` 로 저장하면, 자동으로 geohash 문자열이 저장되는 것이다. 보다 자세한 내용은 [거리 검색](#거리-검색)을 참고한다.

- User profile photo is saved under `/users/<uid>` and `/user-profile-photos/<uid>`.
    - The reason why it saves the photo url into `/user-profile-photos` is to list the users who has profile photo.
    Without `/user-profile-photos` node, It can list with `/users` data but it cannot sort by time.
    - `/user-profile-photos/<uid>` has `updatedAt` field that is updated whenever the user changes profile photo.
    - It is managed by `UserModel`.

- 참고 할 만한 사용자 생성 코드
  - `firebase/functions/tests/test.functions.ts` 의 `createTestUser()`
  - `user.model.dart` 의 `create()` 함수


## 사용자 기능 초기화

사용자 기능 초기화는 FireFlutter 가 제공하는 다른 Service 와 마찬가지로 앱 부팅을 할 때, 적절한 위치에서 `init` 함수를 실행하면 된다.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({
    super.key,
  });

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  @override
  void initState() {
    super.initState();
    UserService.instance.init(); /// 여기에서 초기화
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

대부분의 앱에서 사용자 기능을 사용 할 것이다. 만약, 사용자 기능이 초기화 되지 않았는데 사용자 기능을 사용하려고 한다면, 에러가 날 수 있다.

혹시라도 앱 내에서 사용자 기능을 사용하지 않아서, UserService 를 초기화 하지 않는다면, User 관련 모든 기능을 사용하지 말아야 한다. 이 때, UserService 가 초기화 되었는 확인을 해야하는데, `UserService.instance.initialized` 가 false 이면, 초기화를 하지 않은 것으로 모든 User 관련 기능을 비 활성화 하면된다.


## 사용자 UI 커스터마이징 (Customizing User UI)

### 로그인 에러 UI (Login Error UI)

로그인이 필요한 상황에서 로그인을 하지 않고 해당 페이지를 이용하려고 한다면, `DefaultLoginFirstScreen` 이 사용된다. 이것은 아래와 같이 커스터마이징을 할 수 있다. If someone tries to access a page that requires login without logging in, `DefaultLoginFirstScreen` is used. You can customize it as follows:

```dart
UserService.instance.init(
  customize: UserCustomize(
    loginFirstScreen: const Text('로그인을 먼저 해 주세요. (Please login first!)'),
  ...
  ),
)
```

`loginFirstScreen` 은 builder 가 아니다. 그래서 정적 widget 을 만들어주면 되는데, Scaffold 를 통째로 만들어 넣으면 된다. `loginFirstScreen` is not a builder. So, you can create a static widget, and if you put it in a Scaffold, it will work.







### 사용자 정보 수정 페이지 초기화 예제


`profileUpdateForm` 은  `UserService.instance.showProfileUpdateScreen()` 을 호출하면 dialog screen 이 나타나고 그 안에 표시될 회원 정보 양식을 지정 할 때 사용한다.
기본적으로 `DefaultProfileUpdateForm` 위젯을 사용하며, 아래와 같이 커스터마이징을 할 수 있다.


```dart
UserService.instance.init(
  customize: UserCustomize(
    profileUpdateForm: const DefaultProfileUpdateForm(
      stateMessage: (display: true, require: true),
      nationality: (display: true, require: true),
      countryFilter: ['KR', 'VN', 'TH', 'LA', 'MM'],
      region: (display: true, require: true),
      gender: (display: true, require: true),
      morePhotos: (display: true, require: true),
      occupation: (display: true, require: true),
      koreanAreaLanguageCode: 'ko',
    ),
);
```

그런데, 위와 같이 하면 회원 정보 수정 양식만 변경 할 수 있지, 해더나 백그라운드 등 화면 전체에 대한 변경을 할 수 없다. 그래서 아래와 같이 하면 모든 것을 직접 변경 할 수 있다.

```dart
UserService.instance.init(
  customize: UserCustomize(
    profileUpdateScreen: () => const ProfileUpdateScreen(),
  ),
);
```
위 코드는 사용자가 프로필 수정 버튼을 누르면 `ProfileUpdateScreen` 위젯을 화면에 보여주도록 하는 것이다. 이 `ProfileUpdateScreen` 위젯은 직접 만드는 것으로 원하는 모든 것을 작업하면 된다. 가능하면 `DefaultProfileUpdateScreen` 파일을 복사해서 수정할 것을 권한다. 그리고 모든 회원 정보 양식을 직접 만들어도 되지만, 가능하면 `DefaultProfileUpdateForm` 을 `ProfileUpdateScreen` 안에서 사용하고, 헤더 디자인 등 필요한 디자인만 추가할 것을 권한다.


참고로, 회원 정보 수정 페이지는 반드시 `UserService.instance.showProfileUpdateScreen(context: context);` 을 통해서 열어야 한다. 그렇지 않고 직접 route 연결을 통해서 열면, 앱 내의 여러 곳에서 회원 정보 수정 페이지를 여는 버튼을 두어야 하는 경우가 있는데 이 같은 경우, `profileUpdateForm` 이나 `profileUpdateScreen` 등에서 혼동이 생길 수 있다.





### User profile update screen

Fireflutter provides a few widgets to update user's profile information like below

#### DefaultProfileUpdateForm - 사용자 정보 수정 양식

회원 정보 수정을 할 때, `DefaultProfileUpdateForm` 을 통해서 쉽게 회원 정보를 수정 할 수 있다.

기본적으로 제공하는 옵션은 아래와 같다.

- `backgroundImage`
- `birthday`
- `occupation`
- `stateMessage`
- `gender`
- `nationality`
- `region`
- `morePhotos`
- `onUpdate`
- `countryFilter`
- `countrySearch`
- `koreanAreaLanguageCode`
- `countryPickerTheme`

- background
- state image (profile background image)
- profile photo
- name
- state message
- birthday picker
- gender
- nationality selector
- region selector(for Korean nation only)
- job

`DefaultProfileUpdateForm` also provides more optoins.

You you can call `UserService.instance.showProfileScreen(context)` mehtod which shows the `DefaultProfileUpdateForm` as dialog.

It is important to know that Fireflutter uses `UserService.instance.showProfileScreen()` to display the login user's profile update screen. So, if you want to customize everything by yourself, you need to copy the code and make it your own widget. then conect it to `UserService.instance.init(customize: UserCustomize(showProfile: ... ))`.

#### SimpleProfileUpdateForm

This is very simple profile update form widget and we don't recommend it for you to use it. But this is good to learn how to write the user update form.

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Profile'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(md),
    child: Theme(
      data: bigButtonTheme(context),
      child: SimpleProfileUpdateForm(
        onUpdate: () => toast(
          context: context,
          message: context.ke('업데이트되었습니다.', 'Profile updated.'),
        ),
      ),
    ),
  ),
);
```

## 사용자 정보 참고

`UserDoc` 위젯을 사용 하면 된다. 자세한 것은, 위젯 문서를 참고한다.

## 나의 (로그인 사용자) 정보 액세스

`UserService.instance.user` 는 DB 의 사용자 문서 값을 모델로 가지고 있는 변수이다. 짧게 `my` 로 쓸 수 있도록 해 놓았다. DB 의 값이 변경되면 실시간으로 이 변수의 값도 업데이트(sync)된다. 그래서 DB 에 값을 변경 한 다음, (약간 쉬었다) `my` 변수로 올바로 값이 저장되었는지 확인 할 수 있다. 예를 들면, form field 값 변경 즉시 저장하고, submit 버튼을 누르면 확인을 할 수 있다.

로그인한 사용자(나)의 정보를 참조하기 위해서는 `MyDoc` 를 사용하면 된다. 물론, `UserDoc` 를 사용해도 되지만, `MyDoc` 를 사용하는 것이 더 효과적이다. To reference the information of the logged-in user (yourself), you can use MyDoc. While using UserDoc is acceptable, using MyDoc is more effective.

Fireflutter 은 `UserService.instance.myDataChanges` 를 통해서 로그인 한 사용자의 데이터가 변경 될 때 마다, 자동으로 BehaviorSubject 인 `myDataChanges` 이벤트 시키는데 그 이벤트를 받아서 `MyDoc` 위젯이 동작한다. 그래서 추가적으로 DB 액세스를 하지 않아도 되는 것이다. Fireflutter uses UserService.instance.myDataChanges to automatically trigger the BehaviorSubject myDataChanges event whenever the data of the logged-in user changes. MyDoc widgets respond to this event, eliminating the need for additional DB access.

```dart
MyDoc(builder: (my) => Text("isAdmin: ${my?.isAdmin}"))
```

관리자이면 위젯을 표시하는 예. An example of displaying a widget if the user is an administrator:

```dart
MyDoc(builder: (my) => isAdmin ? Text('I am admin') : Text('I am not admin'))
```

If you are going to watch(listen) a value of a field, then you can use `MyDoc.field`.

```dart
MyDoc.field('${Field.blocks}/$uid', builder: (v) {
  return Text(v == null ? T.block.tr : T.unblock.tr);
})
```


### MyDoc 의 initialData 옵션

`MyDoc` 은 StreamBuilder 를 통해서 `UserService.instance.changes` 이벤트를 수신해서, `UserService.instance.user` 가 가지고 있는 값을 빠르게 가져오지만, StreamBuilder 는 loader 를 필수적으로 화면에 표시를 한다. 즉, 화면이 깜빡이게 되는 것이다.

화면이 깜빡이는 이유는 loader 를 표시하기 때문이다.

`initialData` 를 통해서 이미 로드한 사용자의 정보(`UserService.instance.user`)를 전달하면, StreamBuilder 가 loader 를 화면에 나타내지 않고, `initialData` 를 사용한다. 즉, loader 를 화면에 표시하지 않으므로 화면이 깜빡이지 않는다.

특히, 많은 데이터를 리스트로 표현할 때 각 아이템에서 MyDoc 을 사용하면, 화면에 매우 깜빡 거리거나 리스트의 맨 밑으로 스크롤을 내렸을 때, 아래/위로 흔들리는 경우가 종종있다. 이 같은 경우 initialData 를 사용하면 매우 효과적이다.


```dart
MyDoc(initialData: UserService.instance.user, builder: (user) => ... ) // 와 같이 사용 할 수 있다.
MyDoc(initialData:my, builder: (user) => ... ) // 또는 짧게 my 를 쓸 수 있다.
```


### 관리자 위젯 표시 (Displaying Admin Widgets)

관리자 인지 확인하기 위해서는 아래와 같이 간단하게 하면 된다. To check if a user is an administrator, you can do it as follows:

```dart
Admin( builder: () => Text('I am an admin') );
```

## 사용자 정보 수정 (User Information Update)

`UserModel.update()` 를 통해서 사용자 정보를 수정 할 수 있다. 그러나 UserModel 의 객체는 DB 에 저장되기 전의 값을 가지고 있다. 그래서, DB 에 업데이트 된 값을 쓰기 위해서는 `UserModel.reload()` 를 쓰면 된다.

```dart
await user.update(displayName: 'Banana');
await user.reload();
print(user.displayName);
```

## Displaying user data

- You can use `UserDoc` or `MyDoc` to display user data.
- The most commonly used user properties are name and photos. Fireflutter provides `UserDisplayName` and `UserAvatar` for your convinience.

### UserDoc

The `UserDoc` can be used like this:

```dart
UserDoc(
  uid: uid,
  builder: (data) {
    if (data == null) return const SizedBox.shrink();
    final user = UserModel.fromJson(data, uid: uid);
    return Text( user.displayName ?? 'No name' );
  },
),
```

### MyDoc

The `MyDoc` can be used like this:

```dart
MyDoc(
  builder: (my) {
    return Text( user.displayName ?? 'No name');
  }
),

```

### UserDisplayName

The `UserDisplayName` widget can be used like this:

```dart
UserDisplayName(uid: uid),
```

This will show `displayName`, not `name` of the user.

### UserAvatar

The `UserAvatar` widget can be used like this:

```dart
UserAvatar(uid: uid, size: 100, radius: 40),
```

## Block and unblock

You can block or unblock other user like below.

```dart
final re = await my?.block(chat.room.otherUserUid!);
```

You may want to let the user know if the other user has blocked or unblocked.

```dart
final re = await my?.block(chat.room.otherUserUid!);
toast(
  context: context,
  title: re == true ? 'Blocked' : 'Unblocked',
  message: re == true ? 'You have blocked this user' : 'You have unblocked this user',
);
```

## Widgets

### UserDisplayName 사용자 이름 표시

`UserDisplayName` 으로 사용자 이름을 표시 할 수 있습니다.

- `style` 는 TextStyle 로 UI 를 지정 할 수 있습니다.

- `maxLines` 는 최대 라인 수

- `overflow` 는 글자가 overflow 될 때, 처리할 방식


```dart
ConstrainedBox(
  constraints: const BoxConstraints(
    maxWidth: 100,
  ),
  child: UserDisplayName(
    uid: uid,
    cacheId: 'chatRoom',
    style: Theme.of(context).textTheme.labelSmall,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
),
```

### UpdateBirthdayField

You can use this widget to display birthday and let user to update his birthday in profile screen.

### UserTile

Use this widget to display the user information in a list.
`onTap` is optional and if it is not specified, the widget does not capture the tap event.

```dart
FirebaseDatabaseListView(
  query: Ref.users,
  itemBuilder: (_, snapshot) => UserTile(
    user: UserModel.fromSnapshot(snapshot),
    trailing: const Column(
      children: [
        FaIcon(FontAwesomeIcons.solidCheck),
        spaceXxs,
        Text('인증완료'),
      ],
    ),
    onTap: (user) {
      user.update(isVerified: true);
    },
  ),
),
```

You can use `trailing` to add your own buttons intead of using `onTap`.

### UserListView

Fireflutter provides a widget to display user list. We can use this if we don't have to customize the view.

```dart
UserListView()
```

## 좋아요

- 사용자의 좋아요는 내가 좋아요 한 경우에는 `/who-i-like` 에 저장되고, 다른 사람의 나를 좋아요 한 경우에는 `/who-like-me` 에 저장된다.
    - 만약 A 가 B 를 좋아요 하면,
      - `/who-i-like/A {B: true}` 와 같이 저정되고,
      - `/who-like-me/B {A: true}` 와 같이 저장된다.


- 앱에서는 A 가 B 를 좋아요 할 경우, 오직 `/who-i-like/A {U: true}` 에만 값을 저장하면 된다. 나머지는 클라우드 함수가 처리를 한다.
  - 위와 같이 문서가 저장되면, 클라우드 함수 `userLike` 가 이벤트를 받아서 동작하며,
  - `/who-liked-me` 에 적절한 값을 저장하고
  - 서로 좋아요 (주의: 2024. 06. 현재 서로 좋아요는 플러터 UserModel 에서 수행하는데, 클라우드 함수로 옮겨야 한다.)
  - `noOfLikes`
  등의 필요한 여러가지 작업을 수행한다.


- 다음과 같은 예를 들 수 있다.


A 가 B 를 좋아요 하면,
```json
/who-i-like/A { U: true }
/who-liked-me/U { A: true }
/users/U {noOfLikes: 1}
```

- A 와 B 가 C 를 좋아 하면?
```json
/who-i-like/A {C: true}
/who-i-like/B {C: true}
/who-like-me/C { A: true, B: true}
/users/C {noOfLikes: 2}
```

- B 가 C 를 싫어요 하면? B 의 who-i-like 를 삭제하고, C 의 B 에 대한 who-like-me 를 삭제하고, C 의 noOfLikes 를 1 감소한다.
```json
/who-like-me/C { A: true }
/who-i-like/A { C: true }
/users/U {noOfLikes: 1}
```

- A 가 C 와 D 를 좋아요 하면?
```json
/who-i-like/A { C: true, D: true }
/who-like-me/C { A: true }
/who-like-me/C { A: true }
/users/C {noOfLikes: 1}
/users/D {noOfLikes: 1}
```

You can use the `like` method to perform a like and unlike user like bellow.

```dart
IconButton(
  onPressed: () async {
     await my?.like(uid);
  },
  icon: const FaIcon(FontAwesomeIcons.heart),
),
```

## 서로 좋아요

참고, 서로 좋아요 코드를 플러터 UserModel 에서 클라우드 함수로 이동 시켜야 한다.

- `UserModel.like()` 에서 A 가 B 를 좋아요 할 때, B 가 A 를 좋아요 한 상태이면 서로 좋아요를 표시하고,
- `UserModel.like()` 에서 A 가 B 를 좋아요 해제 할 때, 서로 좋아요 표리를 없앤다. 즉, 둘 중 좋아요 해제를 한 명이라도 하면 둘다 해제하면 되는 것이다.

## 사용자 로그인 후 정보 액세스

사용자가 Firebase 에 로그인을 한 다음, 특정 동작을 해야하는 경우, 아래와 같이 할 수 있다. 사용자 정보 확인이나 사용자 관련 로직을 수행 할 때에는 사용자의 UID 가 필요하다. 이 때, 아래와 같이 하면 firebase auth uid 를 바탕으로 작업을 할 수 있다. 다만, firebase auth 에만 로그인을 한 것으로 RTDB 의 사용자 문서는 로드되지 않았을 수 있다.

```dart
FirebaseAuth.instance
    .authStateChanges()
    .distinct((a, b) => a?.uid == b?.uid)
    .listen((user) {
  if (user != null) {
    ///
  }
});
```

## 사용자 목록

아래와 같이 세로로 표시 할 수 있다.

```dart
UserListView()
```

아래와 같이 가로로 표시 할 수 있다.

```dart
SizedBox(
  height: 68,
  child: UserListView(
    scrollDirection: Axis.horizontal,
    itemBuilder: (u, i) => Padding(
      padding: EdgeInsets.fromLTRB(i == 0 ? 28 : 4, 4, 4, 4),
      child: UserAvatar(
        size: 60,
        radius: 24,
        uid: u.uid,
        cacheId: 'user-avatar',
      ),
    ),
  ),
),
```

## 사용자 정보 listening

`UserService.instance.myDataChanges` 는 `UserService.instance.init()` 이 호출 될 때, 최초로 한번 실행되고, `/users/<my-uid>` 의 값이 변경 될 때마다 이벤트를 발생시킨다.

BehaviourSubject 방식으로 동작하므로, 최초 값이 null 일 수 있으며, 그 이후 곧 바로 realtime database 에서 값이 한번 로드된다. 그리고 난 다음에는 data 값이 변경 될 때 마다 호출된다. 이러한 특성을 살려 로그인한 사용자 정보의 변화에 따라 적절한 코딩을 할 수 있다.

```dart
UserService.instance.myDataChanges.listen((user) {
  if (user == null) {
    print('User data is null. Not ready.');
  } else {
    print('User data is loaded. Ready. ${user.data}');
  }
});
```

만약, 사용자 데이터가 로딩될 때 (또는 데이터가 변하는 경우), 한번만 어떤 액션을 취하고 싶다면, 아래와 같이 하면 된다.

```dart
StreamSubscription? listenRequiredField;
listenRequiredField = UserService.instance.myDataChanges.listen((user) {
  if (user != null) {
    checkUserData(user); // 프로필이 올바르지 않으면 새창을 띄우거나 등의 작업
    listenRequiredField?.cancel(); // 그리고 listenning 을 해제 해 버린다.
  }
});
```

### 사용자가 사진 또는 이름을 입력하지 않았으면 강제로 입력하게하는 방법

아래와 같이, `UserService.instance.myDataChanges` 의 값을 살펴보고, 이름 또는 사진이 없으면 특정 페이지로 이동하게 하면 된다.

```dart
class _HomeScreenState extends State<MainScreen> {
  StreamSubscription? subscribeMyData;

  @override
  void initState() {
    super.initState();

    subscribeMyData = UserService.instance.myDataChanges.listen((my) {
      if (my == null) return;
      // 로그인을 한 다음, 이름이나 사진이 없으면, 강제로 입력 할 수 있는 스크린으로 이동해 버린다.
      if (my.displayName.trim().isEmpty || my.photoUrl.isEmpty) {
        context.go(InputRequiredFieldScreen.routeName);
        // 한번만 listen 하도록 한다.
        subscribeMyData?.cancel();
      }
    });
  }
}
```

## 회원 정보 수정 화면

회원 정보 수정 화면은 로그인 한 사용자가 본인의 정보를 보는 페이지다. `UserService.instance.showProfileScreen` 을 호출하면 회원 정보 수정 화면을 열 수 있다.

## 사용자 공개 프로필 화면

사용자 공개 프로필 화면은 본인 뿐만아니라 다른 사용자가 보는 페이지이다.

사용자 프로필 화면은 여러 곳에서 보여질 수 있다. 예를 들면, 사용자 목록, 게시판, 코멘트, 채팅 등등에서 사용자 이름이나 아이콘을 클릭하면 사용자 공개 프로필 화면이 열리는 것이다. 그래서, 개발하기 편하게 하기 위해서 `UserService.instance.showPublicProfileScreen` 을 호출하면, `DefaultPublicProfileScreen` 이 호출 되도록 했다. 커스텀 디자인을 하려면 `UserService.instance.init(custom: ...)` 에서 수정하면 된다. 사실 커스텀 디자인을 추천하며, 공개 프로필에 들어가는 각각의 작은 위젯들을 재 활용하면 된다.

예제 - 초기화를 통하여 공개 프로필 화면 커스텀 디자인 작업

```dart
UserService.instance.init(
  customize: UserCustomize(
    publicProfileScreen: (uid) => PublicProfileScreen(uid: uid),
  ),
);
```

위와 같이 하면, 사용자가 프로필 사진 등을 탭하면, 화면에 `PublicProfileScreen` 이 나타난다. 이 위젯의 디자인을 완전히 처음부터 새로 작성해도 되지만, `DefaultPublicProfileScreen` 을 복사해서 수정하는 것을 추천한다.

### 사용자 프로필 보기를 할 때, 상대 회원에게 푸시 알림 보내기

참고, [푸시알림 메시지 문서](./messaging.md#사용자-프로필이-보여질-때-푸시-알림-커스터마이징)를 본다.





## 사용자 정보 Firestore 미러링

Realtime Database 는 검색 기능이 매우 부족하다. 그래서 사용자 문서를 Firestore 로 미러링(백업)을 해서, Firestore 를 통해서 검색 할 수 있다. 이 미러링 기능은 Cloud functions 의 `userMirror` 함수를 설치하면 된다. 참고, [설치 문서](./install.md).

`userMirror` 함수는 사용자 정보 생성 또는 업데이트를 할 때, 사용자 정보 전체(부분이 아닌 전체 데이터)를 Firestore 의 `/users/<uid>` 로 복사한다. 기존에 존재하는 필드의 경우 덮어 쓸 수 있다.

그 후 필요한 경우, Firestore 의 `users` 컬렉션을 검색하면 된다.


## 거리 검색

거리를 검색 할 때 보다 상세한 검색을 하려면, SQL 데이터베이스, Algolia, Typesense 등의 Radius 수식을 적용하여 검색해야 한다. 그러나 Firebase 에서는 Realtime Database 나 Firestore 에서는 DB 차원을 통해서 Radius 검색을 할 수 없다.

Firebase 를 사용하면서, Radius 검색을 꼭 해야겠다면

1. Location 정보를 Algolia 와 같은 3rd party 검색 엔진에 저장을 하던지
2. 또는 사용자의 모든 Location 정보를 앱 내(SQLite 등)에 보관해 놓고, Radius 검색을 할 수 있다.
3. 또는 공식문서: [Firebase 지역 쿼리](https://firebase.google.com/docs/firestore/solutions/geoqueries?hl=ko)에서 설명하듯이 Geohash 네자리 수에 해당하는 값을 가진 사용자를 가져와 앱 내에서 보다 정확하게 distance 계산을 하는 것이다. 하지만, 이와 같은 경우 `거짓양성`, `에지케이스`, `필요없는 데이터를 가져오는 비용`을 고려해야 한다.

Fireflutter 에서 기본 제공하는 거리 검색은 위의 세 가지 방법과는 조금 다르지만 매우 편리한 방법이다.

- 먼저 앱이 실행되면 사용자의 위/경도 정보를 사용자 문서 필드  `latitude`, `longitude` 에 저장한다.
    - 그러면 Fireflutter 이 자동으로 geohash4,geohash5,geohash6,geohash7 를 저장한다.
    - 그리고, 필요에 따라 Firestore 미러링되게 한다.

- 검색을 할 때, 로그인한 사용자의 200 미터 내의 사용자 검색은 로그인을 한 사용자의 geohash7 과 DB 의 geohash7 이 일치하는 사용자를 가져와 보여주면 된다.
    - geohash6 는 1km 이내, geohash5 는 5km 이내, geohash4 는 20km 이내의 사용자를 검색 할 수 있다.

## 좋아요

- [좋아요](./like.md) 문서 참고



## 사용자 차단 표시 및 차단하기

- 블럭된 사용자는 `BlockListView` 로 목록으로 표시 할 수 있다.
- 블럭된 경우 문자열로 표시하는 경우는 `orBlock()` String extension 을 사용하면 된다.
- 위젯으로 표시를 해야하는 경우는 `Blocked`로 하면 된다.

예제 - 코멘트 목록에서 사진을 표시할 때, 사용자가 차단되어져 있으면 사진을 표시하지 않는다.

```dart
Blocked(
  uid: widget.comment.uid,
  yes: () => SizedBox.fromSize(),
  no: () => DisplayDatabasePhotos(
    urls: widget.comment.urls,
    path:
        '${Path.comment(widget.post.id, widget.comment.id)}/${Field.urls}',
  ),
),
```

블럭 버튼을 표시하는 것은 위젯 문서를 참고한다.


- 다른 사용자를 차단 할 때에 `UserService.instance.block()` 함수를 쓰면 된다. 이 함수 내에
  - 로그인을 했는지 확인하고,
  - 차단 할지 물어보고 (ask 옵션)
  - 차단 했으면 화면에 알려주는 (notify 옵션)
  기능들이 모두 포함되어져 있다.




## 사용자 계정 정지

사용자 계정 정지 기능은 일반 사용자 끼리 차단하는 것과 다른 것으로, 관리자가 특정 사용자를 차단하는 것으로 차단된 사용자는 앱의 기능을 쓰지 못하도록 하는 것이다.

그래서 사용자 계정 정지 기능은 오직 관리자만 할 수 있으며, 관리자가 특정 사용자의 계정을 정지 시키면, `isDisabled` 필드에 true 가 저장되며, 이 후 글 쓰기 등을 할 수가 없다.

참고로 사용자 차단은 FireFlutter 가 기본적으로 제공하는 화면에서 할 수 있다.






## 회원 탈퇴

- 회원 탈퇴는 `UserService.instance.resign()` 함수를 호출하면 된다.
  - 이 `UserService.instance.resign()` 함수는 내부적으로 Firebase Cloud Functions 의 `callable function` 을 통해서 클라우드 함수 코드를 호출한다. 따라서 cloud functions 중에서 `userDeleteAccount` 를 설치해야 한다.
- 회원 탈퇴를 callable function 으로 만드는 이유는 Flutter Client SDK 에서 회원 계정 삭제 작업하면 `requires-recent-login` 에러가 발생한다.
  - 그리고 만약, 회원 탈퇴를 할 때, RTDB 나 Firestore 에서 회원 데이터를 삭제해야하는 경우, Firebase Auth 에서 계정 삭제를 먼저 한 다음,데이터를 삭제해야하는데, Firebase Auth 에서 계정 삭제를 하는 순간, 로그인 사용자의 uid 가 사라지고 회원 로그인 상태 정보가 사라져서 데이터를 삭제 할 수 없다. 그렇다고 데이터를 먼저 삭제해 버리면, `requires-recent-login` 에러가 발생해서 회원 탈퇴는 못하고 회원 데이터만 삭제를 해 버리는 꼴이 되어 문제가 복잡해 진다.
  - 그래서 `on call` 방식으로 하여, 본인 인증을 한 다음, 회원 탈퇴를 한다.
    - 참고로 `http request` 로 하면 본인 인증이 안되고, `backend trigger` 로 하면 클라이언트에서 결과 대기하는 것이 어렵다.


```dart
ElevatedButton(
  onPressed: () async {
    final re = await confirm(
      context: context,
      title: '회원 탈퇴',
      message: '회원 탈퇴를 하시겠습니까?',
    );
    if (re == true) {
      await UserService.instance.resign();
      await UserService.instance.signOut();
      if (context.mounted) {
        context.go(EntryScreen.routeName);
      }
    }
  },
  child: Text('회원 탈퇴'),
),
```

## 로그인에 따른 위젯 보여주기

로그인을 했는지 하지 않았는지에 따라 위젯을 다르게 보여주어야 할 때가 있다.


- `Login` 위젯은 사용자가 Firebase 에 로그인을 했으면, `yes` 콜백 함수가 호출되어 위젯을 표시할 수 있다. 만약 로그인을 하지 않았으면 `no` 콜백 함수가 실행된다. 참고로, `Login` 위젯은 Firebase Auth 만으로 동작하며, Firebase Realtime Database 의 사용자 문서가 로딩되거나 되지 않거나 상관없다. 주로, 파이어베이스에 로그인을 하여 사용자 uid 가 사용 가능한지 확인을 위해서 쓴다.

`LoggedIn` 과 `LoggedOut` 위젯은 단순히, `AuthReady` 를 재 사용하기 쉽게 해 놓은 것이다.

- `LoggedIn` 은 FirebaseAuth 에 로그인을 한 경우 보여진다.
- `LoggedOut` 은 Firebase Auth 에 로그인을 하지 않은 경우 보여진다.


- `MyDoc` 은 내가 로그인을 한 경우 이용 할 수 있다.
  - 이 때, 나의 문서를 Firebase Realtime Database 에서 다운로드 한 경우 builder 콜백 함수에 UserModel 이 전달된다.
  - 만약, 앱이 시작되지 마자 호출되어, 아직 나의 정보가 RTDB 에서 다운로드되지 않았다면 (또는 다운로드 중이라면) build 함수에 null 이 전달된다.


- `DocReady` 이 위젯은 내부적으로 `MyDoc` 을 사용하며, Firestore Auth 에 로그인하고, 나의 문서가 RTDB 에서 로드되면 builder 콜백 함수를 호출한다. 만약, 로그인을 하지 않았거나 문서를 아직 로드하지 않았다면(또는 문서가 존재하지 않거나, 로드 할 수 없는 상태 등) `loadingBuilder` 를 보여준다. 즉, 로그인을 하지 않은 경우나 문서가 없는 경우 등은 `loadingBuilder` 가 화면에 보이는 것이다. 참고로, `MyDoc` 을 사용하면, `builder( UserModel? )` 가 null 일 수 있으므로, null 체크를 해야 하는데, `DocReady` 는 `builder(UserModel)` 가 null 이 아니므로 조금 더 편리하게 사용 할 수 있다.





## 로그인을 하지 않은 경우,

로그인을 하지 않고도 앱을 쓸 수 있도록 한다면, 특정 기능에서 에러가 발생 할 수 있다. 예를 들면, 로그인을 하지 않고 채팅방에 입장, 글 쓰기 등을 하는 경우라 할 수 있다. 이 외에도 코멘트 쓰기, 좋아요 등 여러가지 기능이 있다.

이 처럼 로그인을 해야지만 쓸 수 있는 기능의 경우, 대부분 해당 서비스(예: UserService, ChatSerivce, ForumService 등)에서 팝업이나 생 창을 띄우기 전에 로그인을 했는지 검사를 한다. 로그인을 했으면 문제가 없겠지만, 로그인을 하지 않았다면, `UserService.instance.init(loginRequired: ...)` 콜백 함수를 실행한다. 만약, `UserService.instance.init(loginRequired: ...)` 함수가 정의되지 않았다면 `UserService.instnace.loginRequired!()` 와 같이 호출하는 과정에서, `null check operator used on null value` 와 같은 에러가 발생 할 수 있다. 따라서 로그인을 하지 않고, 앱의 사용 할 수 있게 한다면 반드시 `loginRequired` 설정을 해 주어야 한다.

`action` 은 채팅방 입장, 채팅방 메세지 전송, 글 쓰기, 코멘트 쓰기 등의 행동 분류를 나타내며, `data` 는 각 행동에 따른 각종 옵션이 전달된다.


예제 - 로그인을 하지 않고 채팅방에 입장하려 하는 경우,

```dart

```

참고로, 좋아요 또는 신고 등의 경우, 앱의 여러 곳에서 사용 될 수 있는데, 관련 로직이 모델 클래스에 있다. 그래서 로그인 여부를 판단하기 위해서, 서비스(servivce) 클래스에서 wrapping 을 하는 경우가 있다. 이렇게 하는 이유는 글이나 코멘트 등에서 좋아요를 하는 경우, 해당 글/코멘트 모델 객체가 존재 모델 클래스에서 좋아요 로직에서 로그인을 했는지 확인을 할 수 있. 하지만, 좋아요를 하는 경우, 나의 정보를 담고 있는 UserModel 객체가 필요한데, 로그인을 하지 않아서 해당 객체 자체가 존재하지 않기 때문이다. 그리서 서비스 클래스에서 wrapping 해서 로직 관리를 하는 것이다. 그래서 사용자 좋아요 하는 것과 글 좋아요 하는 것은 로직이 다르다.

만약, 로그인을 했다는 확신이 있다면, `my.toggleBlock` 과 같이 바로 호출해도 된다.

## UserModel 에 존재하지 않는 필드 값 읽기/쓰기 - extra


각 앱마다 사용자에게 필요한 다른 필드가 있을 수 있습니다. 사용자를 업데이트할 때 `extra` 를 사용하세요.


Use this to update any other fields that are not in the User model. For example, if you want to update the user's hair color, you  can do it like this:

User 모델에 없는 다른 필드를 저장하고 읽으려면 다음과 같이 extra 를 사용하면 된다. 예를 들어, 사용자의 머리 색깔을 업데이트하고 싶다면 다음과 같이 할 수 있다:

```dart
final user = User.fromSnapshot(snapshot);
user.update(extra: {"hairColor": "black"});
```

위와 같이 업데이트 한 사용자의 머리 색깔을 읽으려면 다음과 같이 할 수 있다:

```dart
final hairColor = user.data['hairColor'];
```