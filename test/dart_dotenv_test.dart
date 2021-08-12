import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:test/test.dart';

void main() {
  group('A small group of tests', () {
    final dotEnv = DotEnv();

    setUp(() {
      if (!dotEnv.exists()) {
        dotEnv.createNew();
        print(dotEnv.getDotEnv());
      }
    });

    test('Check Filepath', () {
      expect(dotEnv.filePath, '.env');
    });

    test('Check If Exists', () {
      expect(dotEnv.exists(), isTrue);
    });

    test('Get a specific value', () {
      expect(dotEnv.get('DEBUG'), null);
    });

    test('Get complete dotEnv', () {
      expect(dotEnv.getDotEnv()['DEBUG'], 'false');
    });

    test('Set a new set of data', () {
      expect(dotEnv.set('newKey', 'newValue')['newKey'], 'newValue');
    });
  });
}
