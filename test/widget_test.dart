import 'package:flutter_test/flutter_test.dart';
import 'package:reservation_app/core/utils/constants/constants.dart';

import 'package:reservation_app/main.dart';

void main() {
  testWidgets('main screen test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());

      // Verify that our counter starts at 0.
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      // expect(find.byKey(WidgetKeys.openReservationButtonKey), findsOneWidget);
      await tester.tap(find.byKey(WidgetKeys.openReservationButtonKey).first);
      await tester.pump();

      expect(find.byKey(WidgetKeys.reservationsModalKey), findsOneWidget);
      expect(find.text('Hotel Check-in'), findsOneWidget);
      expect(find.byKey(WidgetKeys.ticketsModalKey), findsNothing);
    });
  });
}
