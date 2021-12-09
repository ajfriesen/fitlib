import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {




  setUp(() {});
  tearDown(() {});

  test("Test sign in", () async {

    final MockFirebaseAuth _mockFirebaseAuth = MockFirebaseAuth();

    Authentication authMock = Authentication(firebaseAuth: _mockFirebaseAuth);


    when(_mockFirebaseAuth.signInAnonymously().thenAnswer());


        // thenAnswer((value) {return value;} ));

    expect(await authMock.anonymousLogin(),
        "Signed in");
  });

}