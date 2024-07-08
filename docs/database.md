# 데이터베이스

## 개요

2024년 7월 Fireflutter 가 Realtime Database 에서 다시 Firestore 를 사용하도록 변경했다.

2019년 처음 FireFlutter 를 처음 시작할 때, 데이터베이스를 Firestore 위주로 발전을 해 왔는데, 2023년 12월 메인 데이터베이스를 Realtime Database 로 변경을 하였다.

Realtime Database 로 변경한 이유는 Firestore 에 비해 반응 속도가 매우 빠르고, 데이터구조가 JSON 방식으로 매우 단순하여 쿼리가 간편하고, 자동 백업 기능이 기본 장착되어져 있으며, Firestore 에 비해서 비용도 저렴한 등 여러가지 장점이 있어서 이다.

주요 데이터 저장소를 Realtime Database 로 변경 후 좀 더 퀘적한 앱을 개발 할 수 있다는 생각을 가지게 되었지만, 문제는 Firestore 보다 필터링 기능이 못하고, 각종 기능이 뒤떨어져서 Realtime Database 를 쓰는 프레임을 꺼려한다는 것이다. 이러한 이유로 2024년 7월 메인 데이터베이스를 Firestore 로 변경하게 되었다. Realtime Database 에 비해 Firestore 의 장점은 너무나 뚜렷하다. 여러가지 장점들 있지만, 특히 상세한 필터링이 가능해 데이터 관리의 편의성이 크게 증대된 것이 특징이다.

만약 Realtime Database 버전의 FireFlutter 를 사용하고자 한다면, [Realtime Database 브랜치](https://github.com/thruthesky/fireflutter/tree/v0.3.32-2024.07.08-realtime-database-version-backup)를 살펴보면 된다.



## 채팅

### 채팅방

저장소: Firestore

### 채팅메시지

저장소: Realtime Database



## 카테고리

글 카테고리이다.

저장소: Firestore


## 글

저장소: Firestore


## 코멘트

저장소: Realtime Database


## 친구

저장소: Firestore


## 활동로그

저장소: Realtime Database

## 액션로그

주요 액션을 기록하는 것이다. 이 액션 로그를 통해서 하루에 글 쓰기 회수 제한, 또는 특정 조건에 따라서 좋아요, 채팅 등의 제한 등등을 할 수 있다.


저장소: Realtime Database


## 북마크

저장소: Realtime Database


## 모임

모임은 카페 또는 동호회의 성격을 가지며, 회원 가입을 통해서 해당 카페의 글, 채팅을 사용 할 수 있다. 또한 오프라인 이벤트 참여 신청 기능도 있다.

저장소: Firestore

## 사용자 설정

사용자 별 개인 설정이다.

저장소: Firestore


