import 'dart:io';

class DotEnv {
  /// A class that works as a bridge between [.env] file and dart code.
  /// 
  /// Example -
  /// ```dart
  /// import 'package:dart_dotenv/dart_dotenv';
  /// 
  /// void main(List<String> args) {
  ///   final dotEnv = DotEnv(filePath: './customNamedFile.extension');
  /// 
  ///   // Check if file exists or not.
  ///   print('.env exists ? - ${dotEnv.exists()}');
  /// 
  ///   // Create a new [filePath] file if not exists.
  ///   print('.env Created New ? - ${dotEnv.createNew()}');
  /// 
  ///   // Get a specific value from [.env] file.
  ///   print('.env value of "someSpecificKey" ? - ${dotEnv.get("someSpecificKey")}');
  /// 
  ///   // Get the whole data of [.env] file as [Map<String, String>].
  ///   print('.env data ? - ${dotEnv.getDotEnv()}');
  /// 
  ///   // Set a new value to and existing key or a completely new set of key and value.
  ///   print('.env append new data ? - ${dotEnv.set("newKey", "newValue")}');
  /// 
  ///   // Save the new data to `[filePath]` file.
  ///   print('.env save to file ? - ${dotEnv.saveDotEnv()}');
  /// }
  /// ```
  /// 
  /// Enjoy it!
  DotEnv({this.filePath = '.env'});

  String filePath = '.env';
  // ignore: prefer_final_fields
  Map<String, String> _env = {};

  /// Returns a [bool] indicating whether the `filePath` exists or not.
  bool exists() {
    final dotEnvFile = File(filePath);
    if (!dotEnvFile.existsSync()) {
      return false;
    }
    return true;
  }

  /// Create [evv filePath] if not exists.
  /// 
  /// Takes in a [bool] recrusive, to create the file recrusively or not.
  bool createNew({recrusive = false}) {
    if (!File(filePath).existsSync()) {
      try {
        File(filePath).createSync(recursive: recrusive);
        return true;
      } catch (error) {
        return false;
      }
    } else {
      return true;
    }
  }

  /// Get the content of the .env file as a [Map<String, String>] object.
  Map<String, String> getDotEnv() {
    if (!File(filePath).existsSync()) {
      return {}; 
    } else {
      for (var eachLine in File(filePath).readAsLinesSync()) {
        try {
          _env[eachLine.split('=')[0]] = eachLine.replaceFirst(eachLine.split('=')[0] + '=', '');
        } catch (error) {
          _env[eachLine.split('=')[0]] = '';
        }
      }
      return _env;
    }
  }

  /// Get a value from the [.env] file.
  /// 
  /// Takes in a [String] key, and returns a [String?] value.
  String? get(String key) {
    if (!File(filePath).existsSync()) {
      return '';
    }
    return _env[key];
  }

  /// Get the value of [env] as a [String].
  @override
  String toString() {
    return _env.toString();
  }

  /// Update a value in [env]
  /// 
  /// Return the updated [env] as [Map<String, String>].
  Map<String, String> set(String key, String value) {
    _env[key] = value;
    return _env;
  }

  /// Save The [DotEnv] config to [filePath].
  /// 
  /// This will overwrite the [filePath] if it exists.
  bool saveDotEnv() {
    final dotEnvFile = File(filePath);
    if (!dotEnvFile.existsSync()) {
      return false;
    }
    dotEnvFile.writeAsStringSync('');
    _env.forEach((String key, String value) {
      dotEnvFile.writeAsStringSync('$key=$value\n', mode: FileMode.append);
    });
    return true;
  }
}