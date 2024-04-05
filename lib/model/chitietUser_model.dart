// file: person_model.dart

class ChitietPerson {
  final String id;
  final String name;
  // final String avatar;

  final String nickname;
  final String sex;
  final String date;
  final String academicLevel;
  final String maritalStatus;
  final String job;
  final String address;
  final String hometown;
  final String bio;
  final bool dead;
  final String lineage;
  final DeadInfo deadInfo;

  ChitietPerson({
    required this.id,
    required this.name,
    // required this.avatar,
    required this.nickname,
    required this.sex,
    required this.date,
    required this.academicLevel,
    required this.maritalStatus,
    required this.job,
    required this.address,
    required this.hometown,
    required this.bio,
    required this.dead,
    required this.lineage,
    required this.deadInfo,
  });

  factory ChitietPerson.fromJson(Map<String, dynamic> json) {
    return ChitietPerson(
      id: json['_id'],
      name: json['name'],
      // avatar: json['avatar'],
      nickname: json['nickname'],
      sex: json['sex'],
      date: json['date'],
      academicLevel: json['academiclevel'],
      maritalStatus: json['maritalstatus'],
      job: json['job'],
      address: json['address'],
      hometown: json['hometown'],
      bio: json['bio'],
      dead: json['dead'],
      lineage: json['lineage'],
      deadInfo: DeadInfo.fromJson(json['deadinfo']),
    );
  }
}

class DeadInfo {
  final String deadDate;
  final String lived;
  final String worshipAddress;
  final String worshipPerson;
  final String burialAddress;

  DeadInfo({
    required this.deadDate,
    required this.lived,
    required this.worshipAddress,
    required this.worshipPerson,
    required this.burialAddress,
  });

  factory DeadInfo.fromJson(Map<String, dynamic> json) {
    return DeadInfo(
      deadDate: json['deaddate'],
      lived: json['lived'],
      worshipAddress: json['worshipaddress'],
      worshipPerson: json['worshipperson'],
      burialAddress: json['burialaddress'],
    );
  }
}
