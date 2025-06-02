import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:island/models/file.dart';
import 'package:tus_client_dart/tus_client_dart.dart';

Future<XFile?> cropImage(
  BuildContext context, {
  required XFile image,
  List<CropAspectRatio?>? allowedAspectRatios,
}) async {
  final result = await showMaterialImageCropper(
    context,
    imageProvider:
        kIsWeb ? NetworkImage(image.path) : FileImage(File(image.path)),
    showLoadingIndicatorOnSubmit: true,
    allowedAspectRatios: allowedAspectRatios,
  );
  if (result == null) return null; // Cancelled operation
  final croppedFile = result.uiImage;
  final croppedBytes = await croppedFile.toByteData(
    format: ImageByteFormat.png,
  );
  if (croppedBytes == null) {
    return image;
  }
  croppedFile.dispose();
  return XFile.fromData(
    croppedBytes.buffer.asUint8List(),
    path: image.path,
    mimeType: image.mimeType,
  );
}

Completer<SnCloudFile?> putMediaToCloud({
  required UniversalFile fileData,
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

  // Handle the data based on what's in the UniversalFile
  final data = fileData.data;

  if (data is XFile) {
    file = data;
    actualFilename = filename ?? data.name;
    actualMimetype = mimetype ?? data.mimeType ?? '';
  } else if (data is List<int> || data is Uint8List) {
    byteData = data is List<int> ? Uint8List.fromList(data) : data;
    actualFilename = filename ?? 'uploaded_file';
    actualMimetype = mimetype ?? 'application/octet-stream';
    if (mimetype == null) {
      throw ArgumentError('Mimetype is required when providing raw bytes.');
    }
    file = XFile.fromData(byteData!, mimeType: actualMimetype);
  } else if (data is SnCloudFile) {
    // If the file is already on the cloud, just return it
    return Completer<SnCloudFile?>()..complete(data);
  } else {
    throw ArgumentError(
      'Invalid fileData type. Expected data to be XFile, List<int>, Uint8List, or SnCloudFile.',
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
