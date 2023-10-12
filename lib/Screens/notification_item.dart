import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/model/notification.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({Key? key, required this.model}) : super(key: key);
  NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.Libelle, style: boldTextStyle()),
            SizedBox(height: 8),
            Text(model.Descritpion, style: secondaryTextStyle()),
            SizedBox(height: 8),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Container(
            height: 50,
            width: 50,
            color: model.IsView == 1 ? Colors.blueAccent : Colors.greenAccent,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
