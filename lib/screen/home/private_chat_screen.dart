import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class PrivateChatScreen extends StatefulWidget {
  final String otherUid;
  final String otherName;

  const PrivateChatScreen({
    super.key,
    required this.otherUid,
    required this.otherName,
  });

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final db = FirebaseFirestore.instance;
  final controller = TextEditingController();

  String get chatId {
    final a = UserSession.userId ?? "";
    final b = widget.otherUid;

    if (a.isEmpty || b.isEmpty) return "invalid_chat";

    return a.compareTo(b) < 0 ? "${a}_$b" : "${b}_$a";
  }

  @override
  Widget build(BuildContext context) {

    if (UserSession.userId == null || UserSession.userId!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Login required")),
      );
    }

    if (widget.otherUid.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Invalid user")),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.otherName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),

        child: Column(
          children: [

            const SizedBox(height: 80),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('private_chat')
                    .doc(chatId)
                    .collection('messages')
                    .snapshots(includeMetadataChanges: true),

                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  final rawMessages = snapshot.data!.docs;

                  // ✅ FILTER + SORT (PERMANENT FIX)
                  final messages = rawMessages.where((msg) {
                    final data = msg.data() as Map<String, dynamic>? ?? {};
                    return data['timestamp'] != null;
                  }).toList();

                  messages.sort((a, b) {
                    final aTime = (a['timestamp'] as Timestamp).millisecondsSinceEpoch;
                    final bTime = (b['timestamp'] as Timestamp).millisecondsSinceEpoch;
                    return aTime.compareTo(bTime);
                  });

                  if (messages.isEmpty) {
                    return const Center(
                      child: Text("No messages yet",
                          style: TextStyle(color: Colors.white70)),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: messages.map<Widget>((msg) {

                      final data =
                          msg.data() as Map<String, dynamic>? ?? {};

                      final isMe =
                          data['senderId'] == UserSession.userId;

                      final text = data['message'] ?? "";

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,

                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(12),
                          constraints:
                              const BoxConstraints(maxWidth: 250),

                          decoration: BoxDecoration(
                            gradient: isMe
                                ? const LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.lightBlue,
                                    ],
                                  )
                                : const LinearGradient(
                                    colors: [
                                      Colors.grey,
                                      Colors.blueGrey,
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Text(
                            text,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            // INPUT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () async {

                      final text = controller.text.trim();
                      if (text.isEmpty) return;
                      if (chatId == "invalid_chat") return;

                      await db
                          .collection('private_chat')
                          .doc(chatId)
                          .collection('messages')
                          .add({
                        'senderId': UserSession.userId,
                        'message': text,
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      controller.clear();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}