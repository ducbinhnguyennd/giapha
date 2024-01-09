import 'package:flutter/material.dart';
import 'package:giapha/api_all/api_diachi.dart';
import 'package:giapha/model/diachi_model.dart';

void main() {
  runApp(MaterialApp(home: AddressList()));
}

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final AddressApi _addressApi = AddressApi();
  List<Province> _provinces = [];
  Province? _selectedProvince;
  District? _selectedDistrict;
  Ward? _selectedWard;

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    try {
      final List<Province> provinces = await _addressApi.fetchProvinces();
      setState(() {
        _provinces = provinces;
      });
    } catch (e) {
      print('Error loading provinces: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dropdown for provinces
          DropdownButton<Province>(
            value: _selectedProvince,
            hint: Text('Chọn tỉnh/thành phố'),
            onChanged: (Province? newValue) {
              setState(() {
                _selectedProvince = newValue;
                _selectedDistrict = null;
                _selectedWard = null;
              });
            },
            items: _provinces
                .map<DropdownMenuItem<Province>>(
                  (Province province) => DropdownMenuItem<Province>(
                    value: province,
                    child: Text(province.name),
                  ),
                )
                .toList(),
          ),

          // Dropdown for districts
          if (_selectedProvince != null)
            DropdownButton<District>(
              value: _selectedDistrict,
              hint: Text('Chọn quận/huyện'),
              onChanged: (District? newValue) {
                setState(() {
                  _selectedDistrict = newValue;
                  _selectedWard = null;
                });
              },
              items: _selectedProvince!.districts
                  .map<DropdownMenuItem<District>>(
                    (District district) => DropdownMenuItem<District>(
                      value: district,
                      child: Text(district.name),
                    ),
                  )
                  .toList(),
            ),

          // Dropdown for wards
          if (_selectedDistrict != null)
            DropdownButton<Ward>(
              value: _selectedWard,
              hint: Text('Chọn xã/phường/thị trấn'),
              onChanged: (Ward? newValue) {
                setState(() {
                  _selectedWard = newValue;
                });
              },
              items: _selectedDistrict!.wards
                  .map<DropdownMenuItem<Ward>>(
                    (Ward ward) => DropdownMenuItem<Ward>(
                      value: ward,
                      child: Text(ward.name),
                    ),
                  )
                  .toList(),
            ),

          // Button to add address
          ElevatedButton(
            onPressed: () {
              // Handle the logic for adding address here
              if (_selectedProvince != null &&
                  _selectedDistrict != null &&
                  _selectedWard != null) {
                print(
                    'Done: ${_selectedWard!.name}, ${_selectedDistrict!.name}, ${_selectedProvince!.name}');
                // Add your navigation or address handling logic here
              } else {
                print('Please select all address components');
              }
            },
            child: Text(
              'Thêm địa chỉ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
