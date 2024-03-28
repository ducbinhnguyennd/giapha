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
  bool _showChildren = false; // Add this variable to control showing children

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
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            top: 120,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text('Người tạo họ - ${_creator.name ?? ''}'),
                      Text('Số diện thoại - ${_creator.phone ?? ''}'),
                    ],
                  ),
                  ListTile(
                    title: Text('Gia phả: Họ Nguyễn'),
                  ),
                ],
              ),
            ),
          ),
        if (!_isLoading)
          Positioned(
            top: 150,
            left: 50,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: FamilyTreeGeneration(
                    generation: _familyTreeRoot,
                    showChildren:
                        _showChildren, // Pass the _showChildren variable
                    onShowChildrenChange:
                        _toggleShowChildren, // Pass the method to toggle _showChildren
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _toggleShowChildren() {
    setState(() {
      _showChildren = !_showChildren; // Toggle _showChildren variable
    });
  }
}

class FamilyTreeGeneration extends StatelessWidget {
  final Member generation;
  final bool showChildren;
  final Function() onShowChildrenChange; // Define a callback function

  FamilyTreeGeneration({
    required this.generation,
    required this.showChildren,
    required this.onShowChildrenChange, // Receive the callback function
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
                onShowChildrenChange(); // Call the callback function to toggle _showChildren
              },
            );
          }).toList(),
        );
      },
    );
  }
}
