class Creator {
  String? name;
  String? phone;
  String? namegiapha;

  Creator({this.name, this.phone, this.namegiapha});

  Creator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    namegiapha = json['namegiapha'];
  }
}

class Member {
  String? id;
  String? name;
  String? date;
  bool? dead;
  String? generation;
  String? avatar;

  List<List<Member>>? children;

  Member(
      {this.id,
      this.name,
      this.date,
      this.dead,
      this.generation,
      this.avatar,
      this.children});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    date = json['date'];
    avatar = json['avatar'];

    dead = json['dead'];
    generation = json['relationship'];
    if (json['con'] != null) {
      children = [];
      json['con'].forEach((childList) {
        List<Member> childrenList = [];
        childList.forEach((child) {
          childrenList.add(Member.fromJson(child));
        });
        children?.add(childrenList);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['avatar'] = this.avatar;

    data['dead'] = this.dead;
    data['relationship'] = this.generation;
    if (this.children != null) {
      data['con'] = this
          .children
          ?.map(
              (childList) => childList.map((child) => child.toJson()).toList())
          .toList();
    }
    return data;
  }
}
