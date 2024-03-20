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
            top: 100,
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
          Column(
            children: [
              Expanded(
                child: FamilyTreeGeneration(
                  generation: _familyTreeRoot,
                ),
              ),
              Expanded(
                child: FamilyTreeGeneration(
                  generation: _familyTreeRoot,
                  showChildren: true,
                ),
              ),
            ],
          )
      ],
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
      List<List<Member>> childrenOfMember =
          member.children!.cast<List<Member>>();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescendantsPage(descendants: childrenOfMember),
        ),
      );
    }
  }
}

class DescendantsPage extends StatelessWidget {
  final List<List<Member>> descendants;

  DescendantsPage({required this.descendants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descendants'),
      ),
      body: ListView.builder(
        itemCount: descendants.length,
        itemBuilder: (context, index) {
          final List<Member> firstGeneration = descendants[index];
          return Column(
            children: [
              ListTile(
                title: Text(firstGeneration.first.name ?? ''),
                onTap: () {
                  _showChildrenOfMember(context, firstGeneration.first);
                },
              ),
              Text(firstGeneration.first.generation.toString()),
              if (firstGeneration.first.children != null &&
                  firstGeneration.first.children!.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: firstGeneration.first.children!.length,
                  itemBuilder: (context, index) {
                    final List<Member> secondGeneration =
                        firstGeneration.first.children![index];
                    return Column(
                      children: secondGeneration
                          .map(
                            (member) => ListTile(
                              title: Text(member.name ?? ''),
                              onTap: () {
                                _showChildrenOfMember(context, member);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void _showChildrenOfMember(BuildContext context, Member member) {
    if (member.children != null && member.children!.isNotEmpty) {
      List<List<Member>> childrenOfMember =
          member.children!.cast<List<Member>>();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescendantsPage(descendants: childrenOfMember),
        ),
      );
    }
  }
}
