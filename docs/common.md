# 공통사항


## 목록 위젯

각 모델에는 모델의 문서를 목록을 할 수 있는 ListView 와 GridView 가 있다.
예를 들면, `UserListView`, `CategoryListView`, `PostGridView` 등이 있는데, 모두 공통적으로 사용법이 비슷한 것이다.
`order` 에는 소팅 필드를 적어 줄 수 있다.
`max` 에는 최대 표시 할 개수를 적어 줄 수 있다. 최근 사용자 10명, 최근 게시글 5개 등으로 목록을 표현하고자 할 때 사용할 수 있다.


내부적으로  `FirestoreQueryBuilder` 를 사용한다.





## 파이어스토어 컬렉션과 문서


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



