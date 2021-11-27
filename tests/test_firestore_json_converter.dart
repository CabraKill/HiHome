import 'package:hihome/utils/firestore_json_converter.dart';
import 'package:test/test.dart';

void main() {
  test('Map should be firestore api style', () {
    final mapTest = {
      'point': {'x': 10, 'y': 20}
    };

    final firestoreMap = firestoreJsonConverter(mapTest);

    expect(firestoreMap, {
      'fields': {
        'point': {
          'mapValue': {
            'fields': {
              'x': {'integerValue': 10},
              'y': {'integerValue': 20}
            }
          }
        }
      }
    });
  });
}
