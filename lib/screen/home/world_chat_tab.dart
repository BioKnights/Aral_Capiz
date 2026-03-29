import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class WorldChatTab extends StatefulWidget {
  const WorldChatTab({super.key});

  @override
  State<WorldChatTab> createState() => _WorldChatTabState();
}

class _WorldChatTabState extends State<WorldChatTab> {
  final db = FirebaseFirestore.instance;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // 💬 MESSAGES
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('world_chat')
                .orderBy('timestamp', descending: false)
                .snapshots(includeMetadataChanges: true),

            builder: (context, snapshot) {

              // ✅ FIXED LOADING
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              // ✅ EXTRA SAFETY
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              final messages = snapshot.data!.docs;

              if (messages.isEmpty) {
                return const Center(
                  child: Text(
                    "No messages yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(10),
                children: messages.map<Widget>((msg) {

                  final data =
                      msg.data() as Map<String, dynamic>? ?? {};

                  final name = data['senderName'] ?? "Unknown";
                  final message = data['message'] ?? "";

                  return Card(
                    color: const Color(0xFF1E293B),
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    child: ListTile(
                      title: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        // ✉️ INPUT
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),

          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle:
                        const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: IconButton(
                  icon: const Icon(Icons.send,
                      color: Colors.white),
                  onPressed: () async {

                    final text = controller.text.trim();
                    if (text.isEmpty) return;

                    await db.collection('world_chat').add({
                      'senderName':
                          UserSession.displayName ?? "Guest",
                      'message': text,
                      'timestamp':
                          FieldValue.serverTimestamp(), // ✅ SAFE
                    });

                    controller.clear();
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}