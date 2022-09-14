import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

class FriendsPage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final Future<Database>? db;
  final String? id;

  FriendsPage({this.databaseReference, this.db, this.id});

  @override
  State<StatefulWidget> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    super.initState();
    // _FriendList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
