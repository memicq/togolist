
class Station {
  String stationId;
  String name;
  String prefecture;
  String line;
  double latitude;
  double longitude;

  int markerCounts;

  Station({
    this.stationId = null,
    this.name,
    this.prefecture,
    this.line,
    this.latitude,
    this.longitude,
    this.markerCounts = 0
  });

  String nameWithSuffix() => this.name + "駅";

  @override
  String toString() {
    return "${nameWithSuffix()}, $prefecture, $line, ($latitude, $longitude)";
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'prefecture': this.prefecture,
      'line': this.line,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'markerCounts': this.markerCounts
    };
  }

  static bool checkSameStation(Station station1, Station station2) {
    return station1.name == station2.name && station1.line == station2.line;
  }
}