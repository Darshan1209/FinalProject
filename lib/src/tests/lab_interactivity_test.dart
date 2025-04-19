import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      'Virtual Lab Interactivity: Select a Virtual Lab → Follow instructions',
      (WidgetTester tester) async {
    // Mock Virtual Lab Provider
    final virtualLabProvider = VirtualLabProvider();

    // Step 1: Load the Virtual Lab
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<VirtualLabProvider>.value(
              value: virtualLabProvider),
        ],
        child: MaterialApp(
          home: VirtualLabPage(),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Step 1: Add the chemical'), findsOneWidget,
        reason: 'The first instruction should be displayed.');

    // Step 2: Simulate user interaction
    final addChemicalButton = find.byKey(Key('addChemicalButton'));
    await tester.tap(addChemicalButton);
    await tester.pumpAndSettle();

    // Verify the lab responds interactively
    expect(find.text('Step 2: Stir the solution'), findsOneWidget,
        reason: 'The lab should respond interactively to the input.');

    // Step 3: Simulate the next interaction
    final stirSolutionButton = find.byKey(Key('stirSolutionButton'));
    await tester.tap(stirSolutionButton);
    await tester.pumpAndSettle();

    // Verify the final state
    expect(find.text('Experiment Complete!'), findsOneWidget,
        reason:
            'The lab should display the completion message after all steps.');
  });
}

class VirtualLabProvider extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void nextStep() {
    _currentStep++;
    notifyListeners();
  }
}

class VirtualLabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final virtualLabProvider = Provider.of<VirtualLabProvider>(context);

    final steps = [
      'Step 1: Add the chemical',
      'Step 2: Stir the solution',
      'Experiment Complete!'
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Virtual Lab')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            steps[virtualLabProvider.currentStep],
            key: Key('instructionText'),
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          if (virtualLabProvider.currentStep == 0)
            ElevatedButton(
              key: Key('addChemicalButton'),
              onPressed: () => virtualLabProvider.nextStep(),
              child: Text('Add Chemical'),
            ),
          if (virtualLabProvider.currentStep == 1)
            ElevatedButton(
              key: Key('stirSolutionButton'),
              onPressed: () => virtualLabProvider.nextStep(),
              child: Text('Stir Solution'),
            ),
        ],
      ),
    );
  }
}
