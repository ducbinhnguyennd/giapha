import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/model/giaPha_model.dart';

class FamilyTreeScreen extends StatefulWidget {
  @override
  _FamilyTreeScreenState createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  late CayGiaPhaApi _api;
  late Member _familyTreeRoot;
  late Creator _creator;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _api = CayGiaPhaApi();
    _fetchFamilyTree();
  }

  Future<void> _fetchFamilyTree() async {
    try {
      Map<String, dynamic>? jsonData = await _api.fetchFamilyTree();
      setState(() {
        _familyTreeRoot = Member.fromJson(jsonData['familyTreeJSON'][0]);
        _creator = Creator.fromJson(jsonData['creator']);
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load family tree: $e');
      setState(() {
        _isLoading = false;
      });
      // Xử lý lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            AssetsPathConst.bggiapha,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            Positioned(
              top: 90,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text('Gia phả: Họ Nguyễn'),
                        Text('Người tạo họ - ${_creator.name ?? ''}'),
                        Text('Số diện thoại - ${_creator.phone ?? ''}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (!_isLoading)
            Positioned(
              top: 200,
              left: 100,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: FamilyTreeGeneration(
                      generation: _familyTreeRoot,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: FamilyTreeGeneration(
                      generation: _familyTreeRoot,
                      showChildren: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class FamilyTreeGeneration extends StatelessWidget {
  final Member generation;
  final bool showChildren;

  FamilyTreeGeneration({
    required this.generation,
    this.showChildren = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: showChildren ? generation.children!.length : 1,
      itemBuilder: (context, index) {
        final List<Member> children =
            showChildren ? generation.children![index] : [generation];
        return Column(
          children: children.map((child) {
            return ListTile(
              title: Text(child.name ?? ''),
              onTap: () {
                _showChildrenOfMember(context, child);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showChildrenOfMember(BuildContext context, Member member) {
    if (member.children != null && member.children!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(member.name ?? ''),
            content: SingleChildScrollView(
              child: Column(
                children: member.children!.map((childList) {
                  return Column(
                    children: childList.map((child) {
                      return ListTile(
                        title: Text(child.name ?? ''),
                        onTap: () {
                          _showChildrenOfMember(context, child);
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }
}
