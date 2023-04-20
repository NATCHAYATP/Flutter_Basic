import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        //weekday คือใช้เก็บข้อมูลทั้ง7วัน
        Duration(days: index),
      ); //subtract คือคำสั่งลบ เช่น index=0 0-0=0 คือวันนี้ index=1 0-1=-1 คือเมื่อวาน
      //duration เข้ามาช่วยจัดการ
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        // ตรวจว่าเป็นวันปัจจุบันมั้ย
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 1), //.Eจะจัด format เป็นวันที่ให้
        'amount': totalSum,
      };
    }).reversed.toList();
  }
  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, //ความสูงของการ์ด
      margin: EdgeInsets.all(20), //ขอบ
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //จัดหน้าตรงแผนภูมิให้มันไม่ติดกัน
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'], 
                data['amount'], 
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
              ),
            );
        }).toList(),
          ),
      ),
    );
  }
}
