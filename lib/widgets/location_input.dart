import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: (_previewImageUrl == "")
              ? const Text("No location Choosen", textAlign: TextAlign.center)
              : Image.network(_previewImageUrl,
                  fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Current Location"),
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Select on Map"),
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
