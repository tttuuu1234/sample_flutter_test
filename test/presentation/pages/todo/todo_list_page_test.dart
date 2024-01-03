import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sample_flutter_test/main.dart';

void main() {
  testWidgets('日付の昇順で表示されているか。', (widgetTester) async {});

  testWidgets('Todoにタイトルと日付が表示されるか。', (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: MyApp()));
    expect(find.text('TodoList'), findsOneWidget);
  });

  // group('Todoの表示に関して。', () async {
  //   final fakeFirestore = FakeFirebaseFirestore();
  //   await fakeFirestore.collection('todos').add({
  //     'title': '掃除',
  //     'date': FieldValue.serverTimestamp(),
  //   });
  //   setUp(() {});
  // });
}
