class Creator {
  String? name;
  String? phone;

  Creator({this.name, this.phone});

  Creator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Member {
  String? id;
  String? name;
  String? date;
  bool? dead;
  String? generation;
  List<List<Member>>? children;

  Member(
      {this.id,
      this.name,
      this.date,
      this.dead,
      this.generation,
      this.children});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    date = json['date'];
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
