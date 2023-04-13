import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx); //เป็นการผูกค่าตัวแปรเข้าไปในตัวแปร
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //ถ้าเข้าเงื่อนไขคือไม่ผ่าน ไม่เพิ่มค่า
    }

    addTx(
      enteredTitle,
      enteredAmount,
    );
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