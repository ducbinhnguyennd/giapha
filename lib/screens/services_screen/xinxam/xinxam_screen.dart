import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/ReadData/ModelXinXam.dart';
import 'package:giapha/screens/services_screen/xinxam/lacxinxam.dart';

class XinXamScreen extends StatefulWidget {
  const XinXamScreen({super.key});

  @override
  State<XinXamScreen> createState() => _XinXamScreenState();
}

class _XinXamScreenState extends State<XinXamScreen> {
  List<ItemModelLoaiXam> itemlist = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchDataXinXam();
  }

  Future<void> fetchDataXinXam() async {
    try {
      final List<ItemModelLoaiXam> apiData =
          await ApiLoaiXinXam().fetchLoaiXam();
      setState(() {
        itemlist = apiData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget listXinXam(String ten, String id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LacXinXam(
                id: id,
                ten: ten,
              ),
            ));
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 50,
              width: 339,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 3),
                    blurRadius: 7,
                    spreadRadius: 5,
                  ),
                ],
                color: const Color(0xffFCCDB3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 0.4),
              ),
              child: Center(
                child: Text(ten),
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: const Text(
          'Xin Xăm',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView.builder(
            itemCount: itemlist.length,
            itemBuilder: (context, index) {
              return listXinXam(itemlist[index].ten, itemlist[index].id);
            },
          ),
        ),
      ),
    );
  }
}
