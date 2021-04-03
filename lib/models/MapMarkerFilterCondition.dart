
class MapMarkerFilterCondition {
  MapMarkerFilterVisited visitedCondition = MapMarkerFilterVisited.NOT_SET;

  MapMarkerFilterCondition([this.visitedCondition = MapMarkerFilterVisited.NOT_SET]);

  Map<String, String> toJson() {
    return {'visited': this.visitedCondition.toString()};
  }

  bool isDefault() {
    return (this.visitedCondition == MapMarkerFilterVisited.NOT_SET);
  }
}

enum MapMarkerFilterVisited {
  NOT_SET,
  VISITED,
  NOT_VISITED
}