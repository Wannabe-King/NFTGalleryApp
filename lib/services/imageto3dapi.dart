import 'dart:convert';
import 'package:http/http.dart' as http;

// These APIs are not being used as we are directly using the 3d model(.glb) ipfs link and creating a 3d view in webview using flutter3dviewer

Future<String> imageTo3dRequest(String apiKey, String imageUrl) async {
  const url = "https://api.meshy.ai/v1/image-to-3d/";
  final response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        // 'Authorization' : 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "image_url": "$imageUrl.png",
        "enable_pbr": true,
        "surface_mode": "organic"
      }));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final imageto3dRequestId = jsonData['result'] as String;
    return imageto3dRequestId;
  } else {
    print("Coundn't fetch 3d model of given image");
    throw Exception('Failed to load 3d model: ${response.statusCode}');
  }
}

Future<String> imageto3dResult(String apiKey, String requestId) async {
  final url = "https://api.meshy.ai/v1/image-to-3d/$requestId";
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $apiKey',
      // 'Authorization' : 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final model3d = jsonData['model_url'] as String;
    print("test $model3d");
    return model3d;
  } else {
    print("Coundn't fetch 3d model of given image");
    throw Exception('Failed to load 3d model: ${response.statusCode}');
  }
}
