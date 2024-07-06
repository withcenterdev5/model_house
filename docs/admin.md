# 관리자

## 개요

- 관리자 기능은 누가 관리자인지 확인을 하거나, 다른 사용자를 관리자로 지정하거나, 관리자에게 권한을 주거나, 사용자, 글, 코멘트, 사진 등등을 관리 할 수 있게 해 준다.

- 관리자 지정하기
  - 선착순 1명이 먼저 root 관리자가 될 수 있다.



## 초기화

- 앱 내에서 관리자 기능을 사용하지 않는 다면, 초기화를 하지 않아도 된다.

- 아래와 같이 하면 초기화가 된다.

```dart
AdminService.instance.init();
```

- `AdminService.instance.init()` 을 호출하면 관리자 목록을 앱 내에서 보관하고, 변경이 있으면 실시간 업데이트를 한다.
  - 즉, `AdminService.instance.init()` 을 호출하지 않으면, 관리자 정보가 앱으로 다운로드 되지 않고, 누가 관리자인지 알 수 없으므로 관리자 기능이 올바로 동작하지 않을 수 있다.
  - 관리자 기능을 앱에서 사용하는 것은 옵션이지만, 사용을 해서, 관리 기능을 추가 해 주는 거이 좋다. 예를 들면, 사용자 차단, 글 삭제, 코멘트 관리, 사진 관리, 관리자에게 채팅을 하기 등등의 여러가지 관리자 기능을 위해서 사용하는 것이 좋다.



### 관리자로 지정하기

누구든 `AdminService.instance.claimAsRoot()` 함수를 최초로 호출하면 root 관리자가 될 수 있다. 이것은 Security rules 에 의해서 보안 관리되며, 그 다음 `claimAsRoot()` 를 호출하는 사용자는 permission denied 에러가 발생한다.

```dart
AdminService.instance.claimAsRoot();
```

- 참고로, 위 `claimAsRoot()` 를 직접 코딩해도 되지만, `AdminClaimButton` 위젯을 이용하면 보다 쉽게 관리자 지정을 할 수 있다.

- 만약, 관리자 지정을 잘못했거나 다시 하고 싶다면, `/settings/admins` 문서를 삭제하고 다시 해야 한다.


## 관리자 권한

관리자는 `/settings/admins` 문서에 둔다.

이 문서의 각 필드는 관리자의 UID 이며, 필드 값은 문자열 배열로 관리자 권한을 추가한다.

관리자 권한에는 `root`, `customer-chat-support` 등이 있다.

`root` 는 모든 권한을 가진 관리자로서 다른 사용자를 관리자로 임명 할 수 있다. `root` 권한을 가진 관리자가 다른 관리자에게 여러가지 권한을 줄 수 있으며,`root` 권한까지도 줄 수 있다. 즉, `root` 관리자가 여러명 있을 수 있다.

`customer-chat-support` 은 고객 상담을 하는 관리자이다. 여러명의 관리자가 이 권한을 가질 수 있으며, 고객(회원)이 관리자에게 질문(채팅)을 하면, 이 권한을 가진 관리자가 모두 채팅방에 들어가서 채팅이 진행된다. 즉, 고객 상담은 그룹 챗으로 진행이 되며, 다른 사용자를 초대 할 수 있다.


사용자 차단, 글, 코멘트 등의 임시 조치는 모든 관리자가 다 할 수 있도록 한다.


## 관리자 인지 확인하기

- 관리자인지 아닌지는 `AdminService.instance.isAdmin` 으로 확인을 할 수 있으며,

- DB 가 변경될 때 또는 사용자 UID 가 변경 될 때, StreamBuilder 로 실시간 업데이트를 하고자 하는 경우 아래와 같이 할 수 있다.

```dart
StreamBuilder(
  stream: AdminService.instance.isAdminStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SizedBox();
    }

    if (snapshot.data != true) return const SizedBox();

    return Text('You are an admin');
  }
);
```

## 관리자와 채팅하기

- 참고로, 관리자와 채팅을 하면, 자동으로 푸시 알림 메시지가 관리자에게 전달된다.

- `AdminService.instance.chatAdminUid` 에 채팅을 전담하는 관리자 UID 가 들어가 있다. 그래서 관리자와 채팅을 하기 위해서는 아래와 같이 하면 된다.

```dart
final room = ChatRoom.fromUid(AdminService.instance.chatAdminUid!);
ChatService.instance.showChatRoomScreen(roomId: roomId);
```

- 관리자과 대화창(1:1 채팅방)을 열지 않고, 곧바로 채팅 메시지를 보내기 위해서는 아래와 같이 하면 된다.

```dart
ChatModel chat = ChatModel(
  room: ChatRoom.fromUid(AdminService.instance.chatAdminUid!),
);
await chat.room.join();
await chat.room.reload();

chat.sendMessage(
  text: text,
  force: true,
);
```

- 관리자 중에서는 고객 상담(앱내 문의)을 전담하는 채팅 상담사가 있어야 한다. 그러한 상담 관리자는 `admins/{uid: ['chat']}` 과 같이 `chat` 옵션을 추가해서 저장을 한다. 단 주의 할 것은 chat 옵션을 가진 관리자는 1명 이어야만 한다.
  - 참고로, Firebase console 에서 처음 admins 데이터를 생성 할 때, Realtime Database 에서 `+` 버튼을 클릭하고 키는 `admins`으로 하고 값은 `{"FjCrteoXHgdYi6MjRp09d51F71H3": "chat"}` 로 하고, Type 은 `auto` 로 하면 된다.
  




## 관리자 화면



- `AdminService.instance.showDashboard()` 를 호출하면 FireFlutter 에서 제공하는 기본 관리자 화면이 나온다.


