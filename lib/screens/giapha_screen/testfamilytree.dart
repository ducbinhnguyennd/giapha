import 'package:flutter/material.dart';

class Testfamilytree extends StatefulWidget {
  const Testfamilytree({super.key});

  @override
  State<Testfamilytree> createState() => _TestfamilytreeState();
}

class _TestfamilytreeState extends State<Testfamilytree> {
  int index = 1;

  final List<Map<String, dynamic>> _familyData = [
    {
      'id': 1,
      'generation': 'Đời 1',
      'members': [
        {
          'name': 'Nguyễn Thúc Giang',
          'fathers': [],
          'mothers': ['Trần Thu Trang', 'Nguyễn Thị Trà'],
          'children': [
            {'name': 'Nguyễn Văn A'},
            {'name': 'Nguyễn Sơn Dương'},
          ],
        },
      ],
    },
    {
      'id': 2,
      'generation': 'Đời 2',
      'members': [
        {
          'name': 'Nguyễn Văn A',
          'father': 'Nguyễn Thúc Giang',
          'mothers': ['Nguyễn Thị B'],
          'children': [
            {'name': 'Nguyễn Văn B'},
            {'name': 'Nguyễn Văn C'},
          ],
        },
        {
          'name': 'Nguyễn Sơn Dương',
          'father': 'Nguyễn Thúc Giang',
          'mother': 'Nguyễn Thị D',
          'children': [
            {'name': 'Nguyễn H'},
            {'name': 'Nguyễn K'},
          ],
        },
      ],
    },
    {
      'id': 3,
      'generation': 'Đời 3',
      'members': [
        {
          'name': 'Nguyễn Văn B',
          'father': 'Nguyễn Văn A',
          'mothers': ['Nguyễn Thị E'],
          'children': [
            {'name': 'Nguyễn Văn D'},
            {'name': 'Nguyễn Văn F'},
          ],
        },
        {
          'name': 'Nguyễn Văn C',
          'father': 'Nguyễn Văn A',
          'mothers': ['Nguyễn Thị G'],
          'children': [
            {'name': 'Nguyễn M'},
            {'name': 'Nguyễn N'},
          ],
        },
        {
          'name': 'Nguyễn H',
          'father': 'Nguyễn Sơn Dương',
          'mothers': ['Nguyễn Thị H'],
          'children': [
            {'name': 'Nguyễn O'},
            {'name': 'Nguyễn P'},
          ],
        },
        {
          'name': 'Nguyễn K',
          'father': 'Nguyễn Sơn Dương',
          'mothers': ['Nguyễn Thị I'],
          'children': [
            {'name': 'Nguyễn Q'},
            {'name': 'Nguyễn R'},
          ],
        },
      ],
    },
  ];

  void _changeIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Binh Ngu')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: _familyData.map((family) {
                return InkWell(
                  onTap: () => _changeIndex(family['id']),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 50,
                    width: 50,
                    color: Colors.red.shade500,
                    child: Center(
                      child: Text(family['generation']),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            flex: 8,
            child: _buildFamilyTree(),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTree() {
    final selectedFamily = _familyData.firstWhere(
      (family) => family['id'] == index,
      orElse: () => {'members': []},
    );

    return Container(
      color: Colors.blue.withOpacity(0.3),
      child: ListView(
        children: selectedFamily['members'].map<Widget>((member) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Tên: ${member['name']}'), // Hiển thị tên
              ),
              ListTile(
                title: Text('Cha: ${member['father'] ?? 'Chưa xác định'}'), // Hiển thị tên cha
              ),
              ListTile(
                title: Text('Mẹ: ${member['mother'] ?? 'Chưa xác định'}'), // Hiển thị tên mẹ
              ),
              ExpansionTile(
                title: const Text('Con:'),
                children: member['children'].map<Widget>((child) {
                  return ListTile(title: Text(child['name'])); // Hiển thị tên con
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
