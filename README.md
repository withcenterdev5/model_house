# 모델하우스

가칭


## 배우게 될 것

### Git

팀 작업을 위한 Git 명령어 사용법을 꼭 익혀야합니다.

예를 들면 fork 후 pr 을 하고, origin 에서 업데이트 된 내용을 local 로 받아오는 등의 작업이 필요합니다.


### 문서화

패키지로 만들어 공개하고 많은 개발자들이 이용하기를 바란다면 문서화를 잘 해 놓는 것이 가장 중요하겠습니다. 같은 맛이면 보기 좋은 떡이 점수가 더 높은 법입니다.

그래서 가장 먼저 해야 할 것이 문서화를 어떻게 하는 것인가 입니다.

소스 코드 내에 문서화를 하는 방법과 Markdown 에 문서화를 하는 두가지 방법을 배워야 합니다. 그냥 대충 배우는 것이 아니라 잘 배워야 합니다.





    * 명칭: 투표로 결정. 가칭: flutter firebase content management system - 짧게: flutter_firebase_ui
    * 협업
    * Git (멤버로 초대해서 작업하지 않으므로 모두 fork 해서 작업)
    * Code review 및 개발 조언
    * 프로젝트의 이해를 위한 문서. 모든 개발자가 반드시 자신이 작업한 분량에 대해서 짧고 분명하고, 이해가 쉬운 문서를 기록. 문서화 자체도 팀웍으로 진행.
    * Firebase 를 사용하므로 패키지 내에서는 상태 관리자를 쓰지 않음.
    * 앱 개발할 때 상태 관리는 각자 알아서
    * 가능한 플러터스럽게,
    * 반드시 짧은 코드를 써야한다.
    * 긴 코드는 무조건 삭제 됨. 코드가 길면 어딘가 잘못된 것임.
    * 모델은 짧게, User, Category, Post, Comment, Chat, ChatRoom, ChatMessage, Activity, Report 등등으로 사용.
    * 모델은 데이터 serialization/deserialization 뿐만으로 CRUD 를 및 기본 기능을 포함한다. 예) user.like(), post.like(), comment.like(), User.create(), user.update(), user.resign(), user.follow(), user.block(), 등등
    * 모델에서 해결하지 못하는 경우는 Singleton service 를 사용한다. 예) UserService, CategoryService, PostService, CommentService 등과 같이 이름을 정한다.
        * 예를 들면, 사용자의 아바타를 클릭했을 때, 사용자 프로필을 띄워야 한다. 그리고 아바타는 글, 코멘트, 채팅 등 앱의 구조에서 깊속한 곳 까지 다양하게 나타날 수 있고, 아주 빈번히 쓰일 수 있다. 그래서 프로필을 여는 로직을 하나로 만들고 같이 

# model_house
