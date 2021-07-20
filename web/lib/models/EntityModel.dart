class Entities {
  List<Entity> entities;

  Entities({this.entities});

  Entities.fromJson(Map<String, dynamic> json) {
    if (json['entities'] != null) {
      entities = new List<Entity>();
      json['entities'].forEach((v) {
        entities.add(new Entity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entity {
  String title;
  String description;
  int id;

  Entity({this.title, this.description, this.id});

  Entity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}
