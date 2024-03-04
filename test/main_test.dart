import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/login/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomePage test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(find.text('Home Page'), findsOneWidget);
  });
}