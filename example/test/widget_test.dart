// Smoke test for the Sui Dart demo app: verifies the app builds and renders
// its home page. (The previous test was the unused `flutter create` counter
// template and did not match this app.)

import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('renders the Sui Dart demo home page', (WidgetTester tester) async {
    // Make visibility_detector update synchronously so it doesn't leave a
    // pending timer at the end of the test.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // The home page renders with its AppBar title.
    expect(find.text('Sui Dart Demo'), findsWidgets);
  });
}
