# 공통사항


## 목록 위젯

각 모델에는 모델의 문서를 목록을 할 수 있는 ListView 와 GridView 가 있다.
예를 들면, `UserListView`, `CategoryListView`, `PostGridView` 등이 있는데, 모두 공통적으로 사용법이 비슷한 것이다.
`order` 에는 소팅 필드를 적어 줄 수 있다.
`max` 에는 최대 표시 할 개수를 적어 줄 수 있다. 최근 사용자 10명, 최근 게시글 5개 등으로 목록을 표현하고자 할 때 사용할 수 있다.


내부적으로  `FirestoreQueryBuilder` 를 사용한다.



## 예외 처리

참고: [예외 처리](./exception.md) 문서 참고


## 빌더

각종 builder 함수에는 그 자체로 yes 또는 no 의 값을 가진다. 예를 들면, `FirebaseAuth.instance.authStateChanged((user) => user == null ? ... : ... )` 와 같이, user 가 null 이 아니면 로그인, null 이면 로그 안한 상태를 나타내듯이, `MyDoc( builder: (doc) => doc == null ? ... : ... )` 와 같이  문서가 있는지 없는지 알 수 있다. 따로 existBuilder, nonExistBuilder 를 두지 않도록 한다.



## 파이어스토어 컬렉션과 문서

경로는 `User.col` 과 같이 static 변수에, collection reference 를 지정하며, 사용자 문서는 `User().ref` 와 같이 해당 객체에 문서 reference 를 둔다.



경로를 지정하는 함수를 따로 만들어 둔다. 예를 들면, `category('qna').col` 와 같이 한다.

receviedRequestRef

- 파라메타가 두개 이상인 함수는 반드시 optional 변수로 쓸 것.
- 변수 명을 아래와 같이 쓸 것


receivedRef
receivedListRef


myReceivedRequestRef

헬퍼 함수를 아래와 같이 만들 것.

mySentListTo(otherUser: uid).ref;
receivedListFrom(otherUser: uid, myUid: myUid).ref;



friends-(request-)received/receiver/sender
friends-(request-)received/{my-uid}/{other-uid} -> myReceived


friends-(request-)sent/sender/receiver
friends-(request-)sent/{my-uid}/{other-uid} -> otherSentMe(other: uid).ref
friends-(request-)sent/{other-uid}/{my-uid} -> mySent(other: uid).ref




## uid

`uid` 는 문서 또는 데이터의 소유자임을 나타낸다. 이 `uid` 를 바탕으로 사용자 정보에서 `displayName` 과 `photoUrl` 을 가져와 보여준다.



## 사용자 정보

사용자 정보는 `UserDoc` 위젯으로 표시하며 기본적으로 메모리 캐시를 한다. 



## 초기값과 캐시

초기값과 캐시 속성은 많은 위젯에서 공통적으로 사용이 된다.

데이터베이스에서 데이터를 가져와 화면에 표시하는 위젯들에 사용되며, 주로 화면에 빠르게 표시를 하기 위해서 사용한다. 예를 들면 사용자 정보를 화면에 표시할 때, 사용자의 문서 레코드를 데이터베이스로 부터 읽어야 하는데, 한번 읽은 데이터는 메모리에 캐시를 하고 재 사용하는 것이다. 또한 initialData 를 통해서 화면 깜밖 거림을 최소화 할 수 있다.

`initialData` 는 초기 값을 미리 주어서 화면에 표시하는 것이다. 옵션이다.
`uid`, `postId` 또는 기타 문서 ID 를 주어서 캐시 된 것이 있으면 캐시 값을 사용하고, 아니면 데이터베이스에서 해당 문서를 가져와 캐시를 할 수 있도록 하는 것이다.
`cache` 값는 기본적으로 true 이며, 메모리 캐시를 한다. 만약 이 값이 false 로 지정되면, 데이터베이스의 값을 가져와 사용한다. 옵션이다.
`sync` 는 데이터베이스이 값이 변경되면 실시간으로 변경되도록 하는 것이다. 옵션이다.
`builder` 는 해당 위젯의 데이터를 화면에 직접 디자인하고자 할 때 사용한다. 옵션이다.
`errorBuilder` 는 퍼미션 에러 등의 에러가 발생할 경우 화면에 표시할 때 사용하는 위젯으로 옵션이 직접 디자인을 하고자 할 때 사용한다.
`loadingBuilder` 는 데이터를 데이터베이스로 부터 로딩 중에 표시하는 것으로 옵션이며 직접 디자인을 변경하고자 할 때 사용한다.






