import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget { //เปลี่ยนเป็น full เพราะในเวอชั่นเก่ามันไม่เก็บสถานะ แต่ก่อนหน้านี้เราทำงานได้ปกตินะแค่เปลี่ยนตามเขาเฉยๆ
  final Function addTx;

  NewTransaction(this.addTx); 
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

 //เป็นการผูกค่าตัวแปรเข้าไปในตัวแปร
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //ถ้าเข้าเงื่อนไขคือไม่ผ่าน ไม่เพิ่มค่า
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop(); 
    //ช่วยให้ปิดป้อปอัพอัตโนมัติ โดยเด้งหน้า contact ขึ้นมา เขาบอกว่า context มันจะรู้จาก state ตอนเราประกาศ class
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                     onSubmitted: (_) => submitData(),
                    // onChanged: (val){
                    //   titleInput = val;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true), //รับค่าเป็นตัวเลขเท่านั้น ปกติใช้.number แต่ ios จะไม่รองรับทศนิยมเลยมาใช้ตัวนี้
                    onSubmitted: (_) => submitData(), //ใส่_ เพราะไม่ได้ส่งค่าไปจะเรียกใช้ฟังก์ชั่นเฉยๆเพื่อให้มันตรวจข้อโต้แย้ง
                    // onChanged: (val) => amountInput = val,
                  ),
                  TextButton(
                    child: 
                    Text(
                      'Add Transaction',
                      style: TextStyle(
                        color: Colors.purple
                      )),
                    // style: TextButton.styleFrom(
                    //   primary: Colors.purple,
                    // ),
                    onPressed: submitData,
                  ),
                ],
              ),
            ),
          );
  }
}