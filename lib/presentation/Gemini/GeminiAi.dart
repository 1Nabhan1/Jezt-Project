import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

import '../../core/constants/Theme_provider/Gemini_theme(provider).dart';
import 'Widget/Custom_drawer.dart';

class AiPage extends StatefulWidget {
  const AiPage({Key? key}) : super(key: key);

  @override
  State<AiPage> createState() => _AiPageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AiPageState extends State<AiPage> {
  late GenerativeModel model;
  final String apiKey =
      'AIzaSyCIZvj4RL1XZMQZGmftNYDNSVZ-YOjr1Io';
  late TextEditingController messageController;
  List<Map<String, String>> messages = [];
  late ScrollController _scrollController;
  bool _showScrollButton = false;

  bool _welcomeMessageDisplayed = false;

  @override
  void initState() {
    super.initState();
    _displayWelcomeMessage();
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    messageController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _displayWelcomeMessage() {
    setState(() {
      messages.add({
        'sender': 'AI',
        'message': 'Hai, how can I help you today?',
      });
      _welcomeMessageDisplayed = true;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // When scrolled to the bottom, hide the scroll button
      setState(() {
        _showScrollButton = false;
      });
    }
  }

  void sendMessage(String message) async {
    setState(() {
      messages
          .add({'sender': 'user', 'message': message}); // Add user's message
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      messages
          .add({'sender': 'AI', 'message': response.text!}); // Add AI response
      _showScrollButton = true; // Show scroll button when new message arrives
    });

    // Scroll to the bottom of the list when a new message is added
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() {
      _showScrollButton = false; // Hide the scroll button after scrolling
    });
  }

  void clearMessages() {
    setState(() {
      messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
      themeProvider.darkModeEnabled ? Colors.grey.shade900 : Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
        themeProvider.darkModeEnabled ? Colors.black12 : Colors.white,
        leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              CupertinoIcons.arrow_2_squarepath,
              color:
              themeProvider.darkModeEnabled ? Colors.white : Colors.black,
            )),
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.blue, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Gemini',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              clearMessages();
            },
            child: Icon(
              Icons.open_in_new,
              color:
              themeProvider.darkModeEnabled ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: CustomDrawer(
        ontap: () {
          clearMessages();
          _scaffoldKey.currentState?.closeDrawer();
        }, sendMessage: sendMessage,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message['sender'] == 'user'
                            ? Icon(
                          Icons.person,
                          color: themeProvider.darkModeEnabled
                              ? Colors.white
                              : Colors.black,
                        )
                            : Image.asset(
                          'assets/google-gemini-icon.png',
                          width: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            message['message']!,
                            style: TextStyle(
                              color: themeProvider.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showScrollButton) // Show scroll button when new message arrives
            IconButton(
              icon: Icon(
                Icons.arrow_downward,
                color:
                themeProvider.darkModeEnabled ? Colors.white : Colors.black,
              ),
              onPressed: scrollToBottom,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: TextField(
                style: TextStyle(
                  color: themeProvider.darkModeEnabled
                      ? Colors.white
                      : Colors.black,
                ),
                controller: messageController,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: themeProvider.darkModeEnabled
                      ? Colors.grey.shade800
                      : Colors.grey,
                  filled: true,
                  suffixIcon: Visibility(
                    visible: messageController.text.isNotEmpty,
                    child: IconButton(
                        onPressed: () {
                          String message = messageController.text.trim();
                          if (message.isNotEmpty) {
                            sendMessage(message);
                            messageController.clear();
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: themeProvider.darkModeEnabled
                              ? Colors.blueGrey
                              : Colors.black,
                        )),
                  ),
                  hintText: 'Enter a prompt here',
                  hintStyle: TextStyle(
                      color: themeProvider.darkModeEnabled
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
