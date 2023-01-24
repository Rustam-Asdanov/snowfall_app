import 'package:location/location.dart';

class SosMessage {
  final String id;
  final String text;
  final Future<LocationData> locationData;

  SosMessage({required this.id,required this.text, required this.locationData});

  factory SosMessage.fromJson(Map<String, dynamic> json) {
    return SosMessage(
        id: json["id"], text: json["text"], locationData: json["location"]);
  }
}
