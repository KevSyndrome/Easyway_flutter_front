import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easyway/main.dart';

void main() {
  setUpAll(() => dotenv.testLoad(
        fileInput: 'API_BASE_URL=http://test\nWEBSOCKET_URL=ws://test',
      ));

  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: EasyWayApp()));
    await tester.pump();
    expect(find.text('EasyWay'), findsOneWidget);
  });
}
