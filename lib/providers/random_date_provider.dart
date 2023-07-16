import 'dart:math';

import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_date_provider.g.dart';

@riverpod
class RandomDate extends _$RandomDate {
  @override
  List<String> build() {
    return [];
  }

  void generateRandomDate(int amount, DateTime startDate, DateTime endDate) {
    final random = Random();

    List<String> generatedDate = [];

    final isSameDay = startDate.day == endDate.day;
    final isSameMonth = startDate.month == endDate.month;
    final isSameYear = startDate.year == endDate.year;

    for (var i = 0; i < amount; i++) {
      final randomDate = DateTime(
        !isSameYear
            ? startDate.year + random.nextInt(endDate.year - startDate.year)
            : startDate.year,
        !isSameMonth
            ? startDate.month + random.nextInt(endDate.month - startDate.month)
            : startDate.month,
        !isSameDay ? startDate.day + random.nextInt(endDate.day - startDate.day) : startDate.day,
      );

      generatedDate.add(DateFormat.yMMMMd().format(randomDate));
    }

    state = generatedDate;
  }
}
