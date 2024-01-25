import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:giapha/model/bangtin_model.dart';

class CommentScreen extends StatefulWidget {
  final String baivietID;

  final String userID;
  CommentScreen({required this.baivietID, required this.userID});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _commentController = TextEditingController();
  ApiSCommentBaiDang _apiService = ApiSCommentBaiDang();
  ApiCmtBaiViet apiCmtBaiViet = ApiCmtBaiViet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.colorPrimary50,
        title: Text('Danh sách bình luận'),
        leading: InkWell(
            onTap: (() {
              Navigator.pop(context, false);
            }),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Comment>>(
                future: apiCmtBaiViet.getComments(widget.baivietID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: ColorConst.colorPrimary120,
                    ));
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    List<Comment> comments = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        bool isMyComment =
                            comments[index].userId == widget.userID;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: isMyComment
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (comments[index].userId == widget.userID)
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    XoaCommentBaiDang.xoaComment(
                                      widget.baivietID,
                                      comments[index].id ?? '',
                                      widget.userID,
                                    ).then((_) {
                                      setState(() {
                                        comments.removeWhere((comment) =>
                                            comment.id == comments);
                                      });
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Xóa bình luận thành công'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    setState(() {});
                                    // Navigator.pop(context, true);
                                  },
                                ),
                              if (!isMyComment)
                                comments[index].avatar == ''
                                    ? SizedBox(
                                        width: DoubleX.kSizeLarge_1X,
                                        height: DoubleX.kSizeLarge_1X,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ColorConst.colorPrimary,
                                          child: Text(
                                            comments[index]
                                                .username
                                                .toString()
                                                .substring(0, 1),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    : Container(
                                        height: 44,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                comments[index].avatar ?? '')),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              Expanded(
                                child: Padding(
                                  padding: isMyComment
                                      ? EdgeInsets.only(right: 8.0)
                                      : EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: isMyComment
                                          ? ColorConst.colorPrimary80
                                          : Colors.grey[300],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isMyComment
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              comments[index].username ?? '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            (comments[index].role == 'admin')
                                                ? Image.asset(
                                                    AssetsPathConst.tichxanh,
                                                    height: 20)
                                                : Container()
                                          ],
                                        ),
                                        Text(comments[index].content ?? ''),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Text(comments[index].date ?? 'aloo',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (isMyComment)
                                comments[index].avatar == ''
                                    ? SizedBox(
                                        width: DoubleX.kSizeLarge_1X,
                                        height: DoubleX.kSizeLarge_1X,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ColorConst.colorPrimary,
                                          child: Text(
                                            comments[index]
                                                .username
                                                .toString()
                                                .substring(0, 1),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    : Container(
                                        height: 44,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                comments[index].avatar ?? '')),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: ColorConst.colorPrimary120,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Nhập bình luận...',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _postComment();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _postComment() {
    String baivietId = widget.baivietID;
    String userId = widget.userID;
    String comment = _commentController.text.trim();

    if (userId != '') {
      if (comment.isNotEmpty && comment.length >= 5) {
        _apiService.postComment(baivietId, userId, comment).then((_) {
          _commentController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đăng bình luận thành công'),
              backgroundColor: Colors.green,
            ),
          );
          setState(() {});
          // Navigator.pop(context, true);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bình luận quá ngắn, vui lòng nhập ít nhất 5 ký tự.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng nhập để bình luận'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
