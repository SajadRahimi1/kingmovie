import 'package:flutter_test/flutter_test.dart';
import 'package:king_movie/core/services/ticket_service.dart';

void main() {
  // String token = "";
  // test('getToken', () async {
  //   final request = await service.login(
  //       email: "rahimixyz@gmail.com", password: '123456789');
  //   token = request.body['salt'];
  //   print(token);
  //   expect(request.body['error'], 'false');
  // });

  test('test ticket', () async {
    final request = await getTicketMessage(
        code: "469785577",
        token: "2y10vz6gcKcO7sPR1kMJMXRF7uHysZBeOMCeGy6rD1cnqyya8vpYpdR8");
    print(request.body['forceOut']);
    expect(request.body['error'], 'false');
  });
}
