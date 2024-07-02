# House Model


## Building as a core developer

- Create your own example app with `example/lib/main.[feature].dart`. Don't touch others app.



## Coding convention




### Model class

Model class does
- serialization/deserialization
- basic crud of the model data
- helper functions of the entity itself. Not other entities of the same model.
- encapsulating the refs.

Service class does
- something that are related with the model.
- showing screens
- search & listing data
- initialization, listening, etc.


### Data listing

Use `FirestoreQueryBuilder` or `FirebaseDatabaseQueryBuilder`. Use query builder all the time.



## Documentation

There is no enlish version of documents. So, write all the document in the source code. The comment int source code will turn into dartdoc when it is deployed into pub.dev.


## Test


### Unit test

Do the unit test as Flutter does.

### Widget test


Do the widget test as Flutter does.


### House test


This is a special test for house only. This is because it's not easy to test while connection with Firebase.

