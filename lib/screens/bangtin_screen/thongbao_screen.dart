import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:giapha/model/thongbao_model.dart';

class NotificationScreen extends StatefulWidget {
  final String userID;
  NotificationScreen({Key? key, required this.userID}) : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];
  NotificationApi notificationApi = NotificationApi();

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      List<NotificationModel> fetchedNotifications =
          await notificationApi.getNotifications(widget.userID);
      setState(() {
        notifications = fetchedNotifications;
      });
    } catch (e) {
      print('Error loading notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.colorPrimary50,
        title: Text('Thông báo'),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text('Không có thông báo.'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                String content = notifications[index].content;
                int indexDa = content.indexOf('đã');

                String beforeDa = content.substring(0, indexDa);
                String afterDa = content.substring(indexDa);

                bool containsThich = content.toLowerCase().contains('thích');

                return Padding(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailBaiViet(
                      //           baivietID: notifications[index].baivietId,
                      //           userID: notifications[index].userId)),
                      // );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: DoubleX.kSizeLarge_1XXX,
                                height: DoubleX.kSizeLarge_1XXX,
                                child: CircleAvatar(
                                  backgroundColor: ColorConst.colorPrimary,
                                  child: Text(
                                    beforeDa.substring(0, 1),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              if (containsThich)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: ColorConst.colorPrimary50),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                ),
                              if (!containsThich)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green),
                                      child: Icon(
                                        Icons.comment,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorConst.colorBackgroundGray,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: beforeDa,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextSpan(
                                          text: afterDa,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    notifications[index].date,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.4)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
