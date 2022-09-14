import 'package:logger/logger.dart';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);




// void main() async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Future<List> _futureOfList = _getList();
//   List list = await _futureOfList ;
//   print(list); // will print [1, 2, 3, 4] on console.
// }

// Future<List>  _getList(){
//   return Future.value([1,2,3,4]);
// }



// void inputData() {
//   final User user = auth.currentUser;
//   final uid = user.uid;
//   //final uemail = user.email;
//   // here you write the codes to input the data into firestore
// }

// Future<String> _getdata() async {
//   FirebaseAuth.instance.authStateChanges().listen((User user) {
//     if (user != null) {
//       print(user.uid);
//       print(user.email);
//     }
//   });
// }

// //보글이 부글이 데이터
// //Future<String>
// _readdatedata(String day) async {
//   final userRef = FirebaseFirestore.instance
//       .collection("users")
//       .doc(user_id)
//       .collection("Dates")
//       .doc(day);
//   userRef.get().then((DocumentSnapshot doc) {
//     print("출력 성공\n");
//     print(doc.data());
//   });
// }
