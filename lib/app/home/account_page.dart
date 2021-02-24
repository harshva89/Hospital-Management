import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/eachBill.dart';
import 'package:time_tracker_flutter_course/common_widgets/avatar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

import 'jobs/appointmentListFile.dart';
import 'jobs/list_items_builder.dart';
import 'models/bill.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('         Account')),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(Icons.highlight_off, color: Colors.white,),
              onTap: () => _confirmSignOut(context),
            ),
          ),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildUserInfo(user),
          ),
        ),

      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text("Your Bills:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
          SizedBox(height: 15,),
        SingleChildScrollView(
          child: SizedBox(
            height: 400.0,
            child:_buildContents(context),
          ),
        )
        ],
      ),


    );
  }

  Widget _buildContents(BuildContext context) {

    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Bill>>(
      stream: database.billStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Bill>(
            snapshot: snapshot,
            itemBuilder: (context, bill) => Dismissible(
              key: Key('appointment-${bill.id}'),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _delete(context, bill),
              child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EachBill(bill: bill)));
                  }
                ,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title: "+bill.title),
                      Text("Cost: Rs."+bill.cost.toString()),
                      Text("Date: "+bill.date.toDate().day.toString()+"/"+bill.date.toDate().month.toString()+"/"+bill.date.toDate().year.toString()),
                    ],
                  ),
                ),
              ),
            ));

      },
    );
  }

  Future<void> _delete(BuildContext context, Bill bill) async{
    try {
      final database = Provider.of<Database>(context);
      await database.DeleteBill(bill);
    } on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
    }
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
        ),
        SizedBox(
          height: 8,
        ),
        if(user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 8,
        ),
        if(user.emailid != null)
          Text(
            user.emailid,
            style: TextStyle(color: Colors.white),
          ),
      ],
    );
  }
}
