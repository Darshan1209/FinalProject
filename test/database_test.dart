import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Database consistency check with item addition', (WidgetTester tester) async {
    // Define a widget that displays a list and allows adding items
    final testWidget = MaterialApp(
      home: Scaffold(
        body: DataListWidget(),
      ),
    );

    await tester.pumpWidget(testWidget);

    // Verify initial state (empty list)
    expect(find.text("No items"), findsOneWidget);

    // Add an item
    await tester.tap(find.byKey(Key('addButton')));
    await tester.pump();

    // Verify the list now has one item
    expect(find.text("Item 1"), findsOneWidget);

    // Add another item
    await tester.tap(find.byKey(Key('addButton')));
    await tester.pump();

    // Verify the list has two items
    expect(find.text("Item 1"), findsOneWidget);
    expect(find.text("Item 2"), findsOneWidget);
  });
}

class DataListWidget extends StatefulWidget {
  @override
  _DataListWidgetState createState() => _DataListWidgetState();
}

class _DataListWidgetState extends State<DataListWidget> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        items.isEmpty
            ? Text("No items", key: Key('noItemsText'))
            : Column(
                children: items.map((item) => Text(item, key: Key(item))).toList(),
              ),
        ElevatedButton(
          key: Key('addButton'),
          onPressed: () {
            setState(() {
              items.add("Item ${items.length + 1}");
            });
          },
          child: Text("Add Item"),
        ),
      ],
    );
  }
}
