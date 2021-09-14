import 'VirtualEntity.dart';

class VirtualEntities {
  final List<VirtualEntity> virtualEntities;

  VirtualEntities({this.virtualEntities});

  factory VirtualEntities.fromJson(dynamic virtualEntitiesJson) {
    var list = virtualEntitiesJson as List;

    List<VirtualEntity> virtualEntitiesList = list
        .map((virtualEntity) => VirtualEntity.fromJson(virtualEntity))
        .toList();
    return VirtualEntities(virtualEntities: virtualEntitiesList);
  }
}
