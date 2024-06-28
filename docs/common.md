# 공통사항


## 목록 위젯

각 모델에는 모델의 문서를 목록을 할 수 있는 ListView 와 GridView 가 있다.
예를 들면, `UserListView`, `CategoryListView`, `PostGridView` 등이 있는데, 모두 공통적으로 사용법이 비슷한 것이다.
`order` 에는 소팅 필드를 적어 줄 수 있다.
`max` 에는 최대 표시 할 개수를 적어 줄 수 있다. 최근 사용자 10명, 최근 게시글 5개 등으로 목록을 표현하고자 할 때 사용할 수 있다.


내부적으로  `FirestoreQueryBuilder` 를 사용한다.

