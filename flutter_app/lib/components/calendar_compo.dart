//import 'dart:html';
//
import 'dart:collection';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarCom extends StatefulWidget {
  final mail;
  const CalendarCom({Key? key, this.mail}) : super(key: key);
  @override
  State<CalendarCom> createState() => _CalendarComState();
}

class _CalendarComState extends State<CalendarCom> {
  String? user_id;

  _getdata() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      user_id = user?.email;
      print(user_id);
    });
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getdata();

    String? day_return;

    //보글이 부글이 데이터
    //Future<String>
    Future<dynamic> _readdatedata() async {
      dynamic is_done;
      final userRef = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.mail)
          .collection("Dates")
          .doc(day_return);
      await userRef.get().then((DocumentSnapshot doc) {
        dynamic data = doc['isDone'];
        is_done = data;
        print(is_done);
      });
      return is_done;
    }

    String day_get(String datatr) {
      return datatr;
    }

    return TableCalendar(
      locale: 'ko-KR',
      firstDay: DateTime.utc(2015, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: DateTime.now(),
      //daysOfWeekHeight: 10,
      rowHeight: 70,
      eventLoader: (day) {
        final dateStr = DateFormat('yyyy-MM-dd').format(day);
        day_return = day_get(dateStr);
        if (_readdatedata() == "0") {
          print("read 실행");
          return ['boggle', 'boogle'];
        } else if (_readdatedata() == "1") {
          return ['hi'];
        }
        return [];
      },
      //보글이 이미지 넣는 것 (조건 맞춰야함)

      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          print(date);
          print(events.length);
          if (events.length > 2) {
            return Align(
              alignment: Alignment(0.0, 1.7),
              //alignment: Alignment.bottomCenter,
              child: Container(
                //margin: EdgeInsets.all(10),
                child: Image.asset('assets/boogle.png'),
                width: 40,
                height: 40,
              ),
            );
          } else {
            //부글이 이미지
            return Align(
              alignment: Alignment(0.0, 1.7),
              child: Container(
                //margin: EdgeInsets.all(10),
                child: Image.asset('assets/boogle.png'),
                //child: Icon(Icons.favorite_border_outlined, color: Colors.red),
                width: 40,
                height: 40,
              ),
            );
          }
        },
        dowBuilder: (context, day) {
          //캘린더 요일 영어에서 한국어로 변경 및 색 변경
          final day_lst = ['월', '화', '수', '목', '금', '토', '일'];
          final style_lst = [
            TextStyle(color: Colors.black),
            TextStyle(color: Colors.black),
            TextStyle(color: Colors.black),
            TextStyle(color: Colors.black),
            TextStyle(color: Colors.black),
            TextStyle(color: Colors.blue),
            TextStyle(color: Colors.red)
          ];
          return Center(
            child: Text(day_lst[day.weekday - 1],
                style: style_lst[day.weekday - 1]),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(
          color: Color.fromARGB(255, 141, 166, 140),
        ),
        weekendTextStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
        outsideDaysVisible: false,
        todayDecoration: BoxDecoration(
          color: Color.fromARGB(0, 160, 244, 86),
          shape: BoxShape.rectangle,
        ),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 4, 84, 14),
          decoration: TextDecoration.underline,
          decorationColor: Color.fromARGB(245, 23, 58, 21),
          //backgroundColor: Color.fromARGB(255, 141, 166, 140)
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
    //backgroundColor: Color.fromARGB(255, 171, 199, 100),
  }
}
