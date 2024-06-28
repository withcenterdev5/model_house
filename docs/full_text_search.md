# 풀텍스트 검색

Firestore 또는 Realtime Database 를 통해서 Full Text 검색을 할 수 없다. 그래서 3rd party service 를 이용하는데, `하우스`에는 공식적으로 Alogia 와 Typesense 를 지원한다.

Firestore 의 문서를 Alogia 와 Typesense 익스텐션으로 인덱스하면 된다.

채팅 메시지는 인덱싱 할 필요없지만, 글과 코멘트는 인덱싱을 해야 한다. 글은 Firestore 에 기본 저장을 하므로 익스텐션을 설치하면 되지만, 코멘트는 Realtime Database 에 설치가 된다. 그래서 `하우스` 에서 코멘트를 Firestore 에도 저장하는 옵션이 있다.

