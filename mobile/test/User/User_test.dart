// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';
// import 'package:mobile/src/Components/User/Models/UserModel.dart';
// import 'package:test/test.dart';

// void main() {
//   group('User', () {
//     test('should correctly instantiate a user object from a json string', () {
//       String json = '''
//         {
//           "id": 1,
//           "username": "test",
//           "firstName": "Test",
//           "lastName": "User",
//           "email": "test@test.com",
//           "type": "Student"
//         }
//       ''';
      
//       User user = User.fromJson(jsonDecode(json));
//       expect(user.id, 1);
//       expect(user.username, 'test');
//       expect(user.firstName, 'Test');
//       expect(user.lastName, 'User');
//       expect(user.email, 'test@test.com');
//       expect(user.type, UserType.Student);
//     });

//     test('should throw an exception if there is a missing key', () {
//       String json = '''
//         {
//           "id": 1,
//           "username": "test",
//           "firstName": "Test",
//           "lastName": "User",
//           "email": "test@test.com"
//         }
//       ''';

//       expect(() => User.fromJson(jsonDecode(json)), throwsA(isA<MissingRequiredKeysException>()));
//     });
//   });
// }