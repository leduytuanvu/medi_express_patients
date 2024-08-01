import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Please provide an environment (development, staging, production).');
    exit(1);
  }

  final environment = arguments[0];

  final entryPoints = {
    'development': 'lib/main_development.dart',
    'staging': 'lib/main_staging.dart',
    'production': 'lib/main_production.dart',
  };

  final entryPoint = entryPoints[environment];

  if (entryPoint == null) {
    print(
        'Invalid environment. Please choose from development, staging, production.');
    exit(1);
  }

  final flutterExecutable = await _findFlutterExecutable();

  if (flutterExecutable == null) {
    print(
        'Flutter executable not found. Please ensure Flutter is installed and added to the PATH.');
    exit(1);
  }

  // Android build
  var result =
      await Process.run(flutterExecutable, ['build', 'apk', '-t', entryPoint]);
  if (result.exitCode == 0) {
    print('Android build successful.');
  } else {
    print('Android build failed: ${result.stderr}');
  }

  // iOS build
  result =
      await Process.run(flutterExecutable, ['build', 'ios', '-t', entryPoint]);
  if (result.exitCode == 0) {
    print('iOS build successful.');
  } else {
    print('iOS build failed: ${result.stderr}');
  }
}

Future<String?> _findFlutterExecutable() async {
  final paths =
      Platform.environment['PATH']?.split(Platform.isWindows ? ';' : ':') ?? [];

  for (final path in paths) {
    final flutterPath =
        File('${path.trim()}/flutter${Platform.isWindows ? '.bat' : ''}');
    if (await flutterPath.exists()) {
      return flutterPath.absolute.path;
    }
  }

  return null;
}
