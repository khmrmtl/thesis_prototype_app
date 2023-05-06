class SensorReadingModel {
  late final double reading;
  late final int order;
  late final bool isClogged;

  SensorReadingModel(
      {required this.reading, required this.order, required this.isClogged});

  SensorReadingModel.fromJson(Map<dynamic, dynamic> json) {
    reading = json['reading'];
    order = json['order'];
    isClogged = json['isClogged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reading'];
    _data['isClogged'];
    _data['order'];
    return _data;
  }
}
