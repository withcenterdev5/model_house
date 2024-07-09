# 모델하우스

모델하우스는 플러터와 파이어베이스를 사용하여 앱을 빠르고 쉽게 구축하기 통합형 라이브러리 패키지이다.
모델하우스를 이용하면 아름다운 디자인 뿐만아니라 회원 가입, 게시판, 채팅, 소셜 등의 기능을 모두 포함하는 완전한 소셜 앱을 매우 쉽고 빠르게 개발 할 수 있다.
본 프로젝트는 오픈소스이며, 누구든지 참여 할 수 있다.


## 문서

- [모델하우스 공식 문서](https://thruthesky.github.io/model_house/)

- [하우스엔진](https://github.com/thruthesky/hengine)

- [Coding Guideline (English)](./etc/docs/README.en.md)


## 읽어 볼 만한 문서

- [데이터베이스 개요](https://thruthesky.github.io/model_house/database/)


## 기능




## 장기적으로 추가될 할 기능


### 비용 절감을 위한, 데이터베이스 사용 옵션

- 파이어스토어로 작업을 하면서 계속 생각하는 것이, "Firestore 사용 비용이 너무 높게 나올 것 같은데?" 라는 것입니다.
- 그래서, 고민 중인 것이, 비용 절감을 위해서 데이터 조회를 할 때, 필터링은 Firestore 를 쓰고, 단순히 데이터를 읽고 목록하는 것은 Realtime Database 를 쓰는 것입니다.


- useDatabaseForUser - 사용자의 공개 정보를 읽거나 목록하는 옵션. 사용자 정보 업데이트 할 때, rtdb 로 sync
- useDatabaseForPost - 글 정보를 읽거나 목록하는 옵션, 글 작성/수정 할 때, rtdb 로 sync
- useDatabaseForChatRoom - 채팅방 정보를 읽거나 목록하는 옵션, 글 작성/수정 할 때, rtdb 로 싱크

그 외에 필터링이 복잡하지 않아, 단순 읽기와 목록을 하는 데이터는 rtdb 로 sync 하도록 한다.



