import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:island/models/file.dart';
import 'package:tus_client_dart/tus_client_dart.dart';

Completer<SnCloudFile?> putMediaToCloud({
  required dynamic fileData, // Can be XFile or List<int> (Uint8List)
  required String atk,
  required String baseUrl,
  String? filename,
  String? mimetype,
  Function(double progress, Duration estimate)? onProgress,
}) {
  XFile file;
  String actualFilename = filename ?? 'randomly_file';
  String actualMimetype = mimetype ?? '';
  Uint8List? byteData;

  if (fileData is XFile) {
    file = fileData;
    actualFilename = filename ?? fileData.name;
    actualMimetype = mimetype ?? fileData.mimeType ?? '';
  } else if (fileData is List<int> || fileData is Uint8List) {
    byteData = fileData is List<int> ? Uint8List.fromList(fileData) : fileData;
    actualFilename = filename ?? 'uploaded_file';
    actualMimetype = mimetype ?? 'application/octet-stream';
    if (mimetype == null) {
      throw ArgumentError('Mimetype is required when providing raw bytes.');
    }
    file = XFile.fromData(byteData!, mimeType: actualMimetype);
  } else {
    throw ArgumentError(
      'Invalid fileData type. Expected XFile or List<int> (Uint8List).',
    );
  }

  final Map<String, String> metadata = {
    'filename': actualFilename,
    'content-type': actualMimetype,
  };

  final completer = Completer<SnCloudFile?>();

  final client = TusClient(file);
  client
      .upload(
        uri: Uri.parse('$baseUrl/files/tus'),
        headers: {'Authorization': 'Bearer $atk'},
        metadata: metadata,
        onComplete: (lastResponse) {
          final resp = jsonDecode(lastResponse!.headers['x-fileinfo']!);
          completer.complete(SnCloudFile.fromJson(resp));
        },
        onProgress: (double progress, Duration estimate) {
          onProgress?.call(progress, estimate);
        },
        measureUploadSpeed: true,
      )
      .catchError(completer.completeError);

  return completer;
}
