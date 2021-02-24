import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/models/bill.dart';
import 'package:time_tracker_flutter_course/app/home/models/contactus.dart';

class EachBill extends StatefulWidget {
  final Bill bill;

  const EachBill({Key key, this.bill}) : super(key: key);
  @override
  _EachBillState createState() => _EachBillState();
}

class _EachBillState extends State<EachBill> {
  bool abc = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Bill          ")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right:20,  top: 30, bottom: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.bill.title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
            Table(
              children: [

                TableRow(
                  children: [
                    Text("\n\nBill Amount: ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                    Text("\n\nRs."+widget.bill.cost.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                  ]
                ),

                TableRow(
                    children: [
                      Text("\nAppointment Date: ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                      Text("\n"+widget.bill.date.toDate().toString().substring(0,10),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                    ]
                ),
                TableRow(
                    children: [
                      Text("\n\n\nNote from hospital: ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                      Text(widget.bill.note == null ? "\n\n\nNo specific note." : "\n\n\n"+widget.bill.note.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                    ]
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.bill.prescription == null ? "" : "\n\n\nWeMedical Prescription:\n",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.bill.prescription == null ? "" : "${widget.bill.prescription.replaceAll("\\n", "\n")}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400)),
              ],
            ),

            Spacer(),
            Text("For any queries",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
            RaisedButton(
              child: Text("Contact us", style: TextStyle(color: Colors.white),),
              color: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactusPage()));
              },


            )

          ],
        ),
      ),
    );
  }
}
