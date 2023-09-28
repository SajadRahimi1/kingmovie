import 'package:flutter_test/flutter_test.dart';
import 'package:king_movie/core/services/home_service.dart';

void main() {
  test('home service test', () async {
    final request = await homeService();
    expect(request.statusCode, 200);
  });
}
