import 'package:fitlib/services/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';


final anonymousUser = MockUser(
  isAnonymous: true,
);

final mockAuth = MockFirebaseAuth(mockUser: anonymousUser);

final auth = Authentication(firebaseAuth: mockAuth);

void main() {

  test("Test anonymous user sign in", () async {
    // auth.anonymousLogin();
    expect(await auth.anonymousLogin(), "Signed in");
  });

}