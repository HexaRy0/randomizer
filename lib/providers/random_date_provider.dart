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

  void generateRandomDate(int amount, DateTime startDate, DateTime endDate, bool unique) {
    final random = Random();

    List<String> generatedDate = [];

    for (var i = 0; i < amount; i++) {
      final randomDate = startDate.add(
        Duration(
          days: random.nextInt(endDate.difference(startDate).inDays + 2),
        ),
      );

      if (unique) {
        if (!generatedDate.contains(DateFormat('dd/MM/yyyy').format(randomDate))) {
          generatedDate.add(DateFormat('dd/MM/yyyy').format(randomDate));
        } else {
          i--;
        }
      } else {
        generatedDate.add(DateFormat('dd/MM/yyyy').format(randomDate));
      }
    }

    state = generatedDate;
  }
}
