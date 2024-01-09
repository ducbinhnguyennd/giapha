class Province {
  String name;
  int code;
  String codename;
  String divisionType;
  int phoneCode;
  List<District> districts;

  Province({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.phoneCode,
    required this.districts,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['name'],
      code: json['code'],
      codename: json['codename'],
      divisionType: json['division_type'],
      phoneCode: json['phone_code'],
      districts: (json['districts'] as List<dynamic>)
          .map((district) => District.fromJson(district))
          .toList(),
    );
  }
}

class District {
  String name;
  int code;
  String codename;
  String divisionType;
  String shortCodename;
  List<Ward> wards;

  District({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.shortCodename,
    required this.wards,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      code: json['code'],
      codename: json['codename'],
      divisionType: json['division_type'],
      shortCodename: json['short_codename'],
      wards: (json['wards'] as List<dynamic>)
          .map((ward) => Ward.fromJson(ward))
          .toList(),
    );
  }
}

class Ward {
  String name;
  int code;
  String codename;
  String divisionType;
  String shortCodename;

  Ward({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.shortCodename,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      name: json['name'],
      code: json['code'],
      codename: json['codename'],
      divisionType: json['division_type'],
      shortCodename: json['short_codename'],
    );
  }
}
