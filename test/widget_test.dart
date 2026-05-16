import 'package:flutter_test/flutter_test.dart';
import 'package:posts_crud_app/main.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame using the correct class name
    await tester.pumpWidget(const PostsCrudApp());

    // Verifies that the app successfully sets up without throwing an immediate error.
    expect(find.byType(PostsCrudApp), findsOneWidget);
  });
}
