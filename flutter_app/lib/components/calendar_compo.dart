import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarCom extends StatelessWidget {
  const CalendarCom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String user_id;
    String is_done;

    _getdata() async {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        user_id = user?.email;
        if (user != null) {
          print(user.uid);
        }
        print(user?.email);
      });
    }

    //보글이 부글이 데이터
    //Future<String>
    _readdatedata(String day) async {
      String is_done = "";
      final userRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user_id)
          .collection("Dates")
          .doc(day);
      print(day);
      userRef.get().then((DocumentSnapshot doc) {
        final data = doc.data();
        print("출력 성공\n");
        print(doc.data());
      });
    }

    return TableCalendar(
      locale: 'ko-KR',
      firstDay: DateTime.utc(2015, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: DateTime.now(),
      //daysOfWeekHeight: 10,
      rowHeight: 60,
      eventLoader: (day) {
        if (day.weekday == DateTime.monday && day.day < DateTime.now().day) {
          return ['hiqq', '2222'];
        } else if (day.day < DateTime.now().day) {
          return ['hi'];
        }
        return [];
      },

      //보글이 이미지 넣는 것 (조건 맞춰야함)
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          _getdata();
          final dateStr = DateFormat('yyyy-MM-dd').format(date);

          if (events == 0) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Image.asset('assets/boggle.png')]);
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Image.asset('assets/boogle.png')]);
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
