import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Upload Offer Letter"),
      onPressed: () async {
        var result = await FilePicker.platform.pickFiles();
        if (result == null) return;

        var file = result.files.first;
        var response =
            await ApiService.uploadOfferLetter(file.bytes!, file.name);

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Parsed Data"),
            content: Text(response.toString()),
          ),
        );
      },
    );
  }
}
