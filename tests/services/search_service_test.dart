import 'package:flutter_test/flutter_test.dart';
import 'package:king_movie/core/services/search_service.dart';
import 'package:king_movie/models/advance_search_model.dart';

void main() {
  test('test advance search', () async {
    await advanceSearch(model: AdvanceSearchModel());
  });
}
