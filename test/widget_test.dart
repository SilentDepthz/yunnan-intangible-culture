// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:yunnan_intangible_culture/data/mock_data.dart';

void main() {
  test('culture data is complete and searchable', () {
    expect(cultureList, isNotEmpty);
    expect(
      cultureList.map((item) => item.id).toSet().length,
      cultureList.length,
    );
    expect(
      cultureList.where(
        (item) => item.name.contains('扎染') || item.location.contains('大理'),
      ),
      isNotEmpty,
    );
  });

  test('quiz answers point to valid options', () {
    for (final question in qaList) {
      expect(
        question.correctIndex,
        inInclusiveRange(0, question.options.length - 1),
      );
      expect(question.options[question.correctIndex], question.answer);
    }
  });
}
