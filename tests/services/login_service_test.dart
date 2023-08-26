import 'package:flutter_test/flutter_test.dart';
import 'package:king_movie/core/services/login_service.dart';

void main() {
  test('test login', () async {
    final request =
        await login(email: 'rahimixyz@gmail.com', password: '123456789');
    print(request.body['message']);
    expect(request.body['error'], 'false');
  });
}
