import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? chatId;
  List<Map<String, dynamic>> messages = [];
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  Future<void> _initializeChat() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await HttpHelper.get(
        'api/chat',
      );

      List<dynamic> chatList = response['chats'] as List<dynamic>;
      if (chatList.isNotEmpty) {
        setState(() {
          chatId = chatList[0]['id'];
        });
      }

      await _fetchPreviousMessages();
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchPreviousMessages() async {
    const url = 'api/chat/messages';
    try {
      final data = await HttpHelper.post(
        url,
        {'chatId': chatId},
      );

      final userMessages = (data['userMessages'] as List<dynamic>).map((m) {
        return Map<String, dynamic>.from(m)..['sender'] = 'user';
      }).toList();

      final botMessages = (data['botMessages'] as List<dynamic>).map((m) {
        return Map<String, dynamic>.from(m)..['sender'] = 'bot';
      }).toList();

      final allMessages = [...userMessages, ...botMessages];
      allMessages.sort((a, b) => DateTime.parse(a['created_at'])
          .compareTo(DateTime.parse(b['created_at'])));

      setState(() {
        messages = allMessages.cast<Map<String, dynamic>>();
      });

      // Scroll to the bottom after loading messages
      _scrollToBottom();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<Map<String, dynamic>?> sendMessage({
    required String text,
    required String chatId,
    String? file,
  }) async {
    const url = 'api/chat/message';

    final response = await HttpHelper.post(
      url,
      {
        'text': text,
        'file': file ?? '',
        'chatId': chatId,
      },
    );

    return response;
  }

  Future<void> _sendMessage(String text) async {
    if (chatId == null) return;

    // Add the user's message immediately
    setState(() {
      messages.add({'text': text, 'sender': 'user'});
    });

    // Scroll to the bottom after user sends a message
    _scrollToBottom();

    try {
      final response = await sendMessage(text: text, chatId: chatId!);

      if (response != null) {
        setState(() {
          messages.add({
            'text': response['BotMessage']['text'],
            'sender': 'bot',
            'products': response['products'] ?? [],
          });
        });

        // Scroll to the bottom after receiving bot's response
        _scrollToBottom();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void _scrollToBottom({Duration delay = const Duration(milliseconds: 300)}) {
    Future.delayed(delay, () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(title: const Text('Chat Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                if (message.containsKey('products')) {
                  return Column(
                    children: [
                      _buildMessageBubble(message),
                      ...message['products']
                          .map<Widget>((product) => _buildProductCard(product))
                          .toList(),
                    ],
                  );
                } else {
                  return _buildMessageBubble(message);
                }
              },
            ),
          ),
          if (isLoading) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = messageController.text.trim();
                    if (text.isNotEmpty) {
                      _sendMessage(text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['sender'] == 'user';
    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 100.0 : 10.0, // User messages: 30px padding from left
        right: isUser ? 10.0 : 100.0, // Bot messages: 30px padding from right
        top: 5.0,
        bottom: 5.0,
      ),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isUser ? OurColors.primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: isUser
                  ? const Radius.circular(10.0)
                  : const Radius.circular(0),
              bottomRight: isUser
                  ? const Radius.circular(0)
                  : const Radius.circular(10.0),
            ),
          ),
          child: Text(
            message['text'],
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 180.0, top: 10.0, bottom: 10.0, left: 10),
      child: Container(
        width:
            MediaQuery.of(context).size.width - 60, // Adjust width dynamically
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: OurColors.secondaryBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.network(
                product['image'],
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to product screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          productID: product['product_id'],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  child: const Text('View Product'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
