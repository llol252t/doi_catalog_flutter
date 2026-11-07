import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doi_catalog_flutter/app.dart';

void main() {
  testWidgets('App smoke test: shows loading then article list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Initially the list is loading.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the mocked repository delay to complete.
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // The list is shown.
    expect(find.byType(ListView), findsOneWidget);
  });
}
