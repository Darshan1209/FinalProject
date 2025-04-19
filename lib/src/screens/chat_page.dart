import 'dart:async';
import 'dart:io';

import 'package:apt3065/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Gemini gemini = Gemini.instance;
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = []; // Store messages and metadata
  int? currentlySpeakingIndex; // Index of the message being spoken
  int? highlightedWordIndex; // Index of the word being highlighted
  List<String> highlightedWords = []; // Words being spoken

  final String currentUser = "You";
  final String geminiUser = "Gemini";

  @override
  void initState() {
    super.initState();
    flutterTts.awaitSpeakCompletion(true); // Ensure TTS finishes one word before starting the next
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when leaving the screen
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gemini AI"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Show newest messages at the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message['user'] == currentUser;

                if (message['type'] == 'image') {
                  // Render image message
                  return ListTile(
                    title: Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Image.file(
                        File(message['filePath']),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  // Render text message
                  final isSpeaking = index == currentlySpeakingIndex;

                  return ListTile(
                    leading: isCurrentUser
                        ? null
                        : const CircleAvatar(
                            child: Icon(Icons.android),
                          ),
                    trailing: isCurrentUser
                        ? const CircleAvatar(
                            child: Icon(Icons.person),
                          )
                        : IconButton(
                            icon: const Icon(Icons.volume_up),
                            onPressed: () => _speak(message['text'], index),
                          ),
                    title: Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? GeneralAppColors.mainColor
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isSpeaking
                            ? _buildHighlightedText(message['text'])
                            : Text(
                                message['text'],
                                style: TextStyle(
                                  color: isCurrentUser ? Colors.white : Colors.black,
                                ),
                              ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(String text) {
    final words = text.split(" ");
    return RichText(
      text: TextSpan(
        children: List.generate(words.length, (index) {
          return TextSpan(
            text: words[index] + " ",
            style: TextStyle(
              color: index == highlightedWordIndex
                  ? const Color.fromARGB(255, 48, 89, 193)
                  : Colors.black,
              fontWeight: index == highlightedWordIndex
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.image),
          onPressed: _sendMediaMessage,
        ),
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: const InputDecoration(
              hintText: "Type your message",
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _sendMessage,
        ),
      ],
    );
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final userMessage = {
      'user': currentUser,
      'type': 'text',
      'text': messageController.text.trim(),
    };

    setState(() {
      messages.insert(0, userMessage);
    });

    final question = messageController.text.trim();
    messageController.clear();

    // Call Gemini AI for a response
    try {
      String fullResponse = "";
      gemini.streamGenerateContent(question).listen((event) {
        final part = event.content?.parts
                ?.fold("", (prev, current) => "$prev ${current.text}") ?? 
            "";
        fullResponse += part;
      }, onDone: () {
        final geminiMessage = {
          'user': geminiUser,
          'type': 'text',
          'text': fullResponse.trim(),
        };
        setState(() {
          messages.insert(0, geminiMessage);
        });
      }, onError: (error) {
        print("Error: $error");
        final errorMessage = {
          'user': geminiUser,
          'type': 'text',
          'text': "Sorry, there was an error processing your request.",
        };
        setState(() {
          messages.insert(0, errorMessage);
        });
      });
    } catch (e) {
      print("Error communicating with Gemini: $e");
    }
  }

  void _sendMediaMessage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final userMessage = {
        'user': currentUser,
        'type': 'image',
        'filePath': file.path,
      };

      setState(() {
        messages.insert(0, userMessage);
      });

      // Send media to Gemini AI
      try {
        final imageBytes = await File(file.path).readAsBytes();
        String fullResponse = "";
        gemini.streamGenerateContent(
          "Describe this picture.",
          images: [imageBytes],
        ).listen((event) {
          final part = event.content?.parts
                  ?.fold("", (prev, current) => "$prev ${current.text}") ?? 
              "";
          fullResponse += part;
        }, onDone: () {
          final geminiMessage = {
            'user': geminiUser,
            'type': 'text',
            'text': fullResponse.trim(),
          };
          setState(() {
            messages.insert(0, geminiMessage);
          });
        }, onError: (error) {
          print("Error: $error");
          final errorMessage = {
            'user': geminiUser,
            'type': 'text',
            'text': "Sorry, there was an error processing your request.",
          };
          setState(() {
            messages.insert(0, errorMessage);
          });
        });
      } catch (e) {
        print("Error sending image: $e");
      }
    }
  }

 Future<void> _speak(String text, int index) async {
  try {
    setState(() {
      currentlySpeakingIndex = index;
      highlightedWords = text.split(" ");
      highlightedWordIndex = 0;
    });

    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(1.7); // Increased speed of speech
    await flutterTts.setPitch(1.5); // Optional: Adjust pitch for a natural tone

    for (int i = 0; i < highlightedWords.length; i++) {
      await flutterTts.speak(highlightedWords[i]);
      setState(() {
        highlightedWordIndex = i;
      });

      // Adjust the delay duration to make highlighting faster
      await Future.delayed(
        Duration(milliseconds: (highlightedWords[i].length * 50).clamp(100, 500)), 
      );
    }

    setState(() {
      currentlySpeakingIndex = null;
      highlightedWordIndex = null;
      highlightedWords = [];
    });
  } catch (e) {
    print("Error in Text-to-Speech: $e");
  }
}
}