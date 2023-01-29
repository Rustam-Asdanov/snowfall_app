import 'package:location/location.dart';

class SosMessage {
  final String id;
  final String message;
  final num latitude;
  final num longitude;

  SosMessage({required this.id, required this.message, required this.latitude, required this.longitude});

  factory SosMessage.fromJson(Map<String, dynamic> json) {
    return SosMessage(
        id: json["_id"], message: json["message"], latitude: json["latitude"], longitude: json["longitude"]);
  }

}
