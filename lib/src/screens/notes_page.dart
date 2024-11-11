import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiologyNotesPage extends StatefulWidget {
  final String topicName;

  const BiologyNotesPage({Key? key, required this.topicName}) : super(key: key);

  @override
  State<BiologyNotesPage> createState() => _BiologyNotesPageState();
}

class _BiologyNotesPageState extends State<BiologyNotesPage> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Consumer(
          builder: (context, ref, child) {
            AsyncValue notesPagedata =
                ref.watch(topicNotesReaderProvider(widget.topicName));
            return notesPagedata.when(
                data: (NotesData) {
                  List<String> stepsString =
                      NotesData[0]['Steps'].toString().split("\\n");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20), // Add space before the title
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green
                              .withOpacity(0.1), // Light blue background color
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.topicName,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              NotesData[0]['Description'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green
                              .withOpacity(0.1), // Light blue background color
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Steps',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount: stepsString.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    stepsString[index],
                                    style: const TextStyle(fontSize: 18),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stack) => Text('Error: $error'),
                loading: () => const Text('Loading...'));
          },
        ),
      ),
    );
  }
}
