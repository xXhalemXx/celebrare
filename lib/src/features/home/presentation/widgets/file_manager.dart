import 'dart:typed_data';

abstract class PlatformFileManager {
  factory PlatformFileManager() => getFileManager();
  Future<String> saveFile(Uint8List fileContent, String path, {String? name});
}

PlatformFileManager getFileManager() => throw UnimplementedError(
    "File Picker is Not Implementd in current platform");
