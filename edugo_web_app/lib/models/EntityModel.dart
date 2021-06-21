class Entities {
  final List<Entity> entities;

  Entities({this.entities});

  factory Entities.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['entities'] as List;
    print(list.runtimeType);
    List<Entity> dataList = list.map((i) => Entity.fromJson(i)).toList();

    return Entities(entities: dataList);
  }
}

class Entity {
  final int id;
  final String title;
  final String description;

  Entity({this.id, this.title, this.description});

  factory Entity.fromJson(Map<String, dynamic> parsedJson) {
    return Entity(
      id: parsedJson['id'],
      title: parsedJson['title'],
      description: parsedJson['description'],
    );
  }
}
