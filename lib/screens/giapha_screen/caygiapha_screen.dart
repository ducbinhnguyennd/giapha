import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/giaPha_model.dart';

class FamilyTreeScreen extends StatefulWidget {
  @override
  _FamilyTreeScreenState createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  final CayGiaPhaApi _apiService = CayGiaPhaApi();
  Member? _familyTree;

  @override
  void initState() {
    super.initState();
    _fetchFamilyTree();
  }

  void _fetchFamilyTree() async {
    try {
      final Member familyTree = await _apiService.fetchFamilyTree();
      setState(() {
        _familyTree = familyTree;
      });
    } catch (e) {
      print("Error fetching family tree: $e");
    }
  }

  Widget _buildMember(Member member) {
    return ListTile(
      title: Text(member.name ?? ''),
      subtitle: Text(member.date ?? ''),
      onTap: () {
        // Handle tap on member
      },
    );
  }

  Widget _buildFamilyTree(Member? member) {
    if (member == null) {
      return Center(child: Text('No family tree data available'));
    }
    return ListView.builder(
      itemCount: _countMembers(member),
      itemBuilder: (BuildContext context, int index) {
        final Member currentMember = _getMemberAtIndex(member, index);
        return _buildMember(currentMember);
      },
    );
  }

  int _countMembers(Member member) {
    int count = 1; // Count the member itself
    if (member.children != null) {
      for (List<Member> childrenList in member.children!) {
        for (Member child in childrenList) {
          count += _countMembers(child);
        }
      }
    }
    return count;
  }

  Member _getMemberAtIndex(Member member, int index) {
    if (index == 0) {
      return member;
    }
    int currentIndex = 1;
    return _findMemberInChildren(member, index, currentIndex);
  }

  Member _findMemberInChildren(
      Member member, int targetIndex, int currentIndex) {
    if (member.children != null) {
      for (List<Member> childrenList in member.children!) {
        for (Member child in childrenList) {
          if (currentIndex == targetIndex) {
            return child;
          }
          currentIndex++;
          Member foundMember =
              _findMemberInChildren(child, targetIndex, currentIndex);
          if (foundMember != member) {
            return foundMember;
          }
        }
      }
    }
    return member;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Tree'),
      ),
      body: _buildFamilyTree(_familyTree),
    );
  }
}
