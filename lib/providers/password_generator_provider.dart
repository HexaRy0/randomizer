import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_generator_provider.g.dart';

@riverpod
class PasswordGenerator extends _$PasswordGenerator {
  @override
  String build() {
    return '';
  }

  void reset() {
    state = '';
  }

  void generatePassword(int length, List<String> includes) {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-={}[]:";\'<>?,./|\\';

    final hasUppercase = includes.contains('uppercase');
    final hasLowercase = includes.contains('lowercase');
    final hasNumbers = includes.contains('numbers');
    final hasSymbols = includes.contains('symbols');

    final random = Random();

    final password = <String>[];

    while (password.length < length) {
      if (hasUppercase) {
        password.add(uppercase[random.nextInt(uppercase.length)]);
      }

      if (hasLowercase) {
        password.add(lowercase[random.nextInt(lowercase.length)]);
      }

      if (hasNumbers) {
        password.add(numbers[random.nextInt(numbers.length)]);
      }

      if (hasSymbols) {
        password.add(symbols[random.nextInt(symbols.length)]);
      }
    }

    password.shuffle();

    state = password.join();
  }
}
