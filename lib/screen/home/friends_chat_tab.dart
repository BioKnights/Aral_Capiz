import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';
import 'private_chat_screen.dart';

class FriendsChatTab extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FriendsChatTab({super.key});

  @override
  Widget build(BuildContext context) {

    if (UserSession.userId == null || UserSession.userId!.isEmpty) {
      return const Center(
        child: Text("Login required", style: TextStyle(color: Colors.white)),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: db.collection('users')
          .doc(UserSession.userId)
          .snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;

        if (data == null || !data.containsKey('friends')) {
          return const Center(
            child: Text("No friends", style: TextStyle(color: Colors.white70)),
          );
        }

        // ✅ FILTER EMPTY UID
        final List<String> friends =
            List<String>.from(data['friends'] ?? [])
                .where((uid) => uid.toString().isNotEmpty)
                .toList();

        if (friends.isEmpty) {
          return const Center(
            child: Text("No friends", style: TextStyle(color: Colors.white70)),
          );
        }

        return ListView(
          children: friends.map<Widget>((uid) {

            // ✅ EXTRA SAFETY
            if (uid.isEmpty) return const SizedBox();

            return FutureBuilder<DocumentSnapshot>(
              future: db.collection('users').doc(uid).get(),
              builder: (context, snap) {

                if (!snap.hasData) return const SizedBox();

                final userData =
                    snap.data!.data() as Map<String, dynamic>?;

                if (userData == null) return const SizedBox();

                final name = userData['name']?.toString() ?? "";
                final isOnline = userData['online'] == true;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : "?",
                    ),
                  ),

                  title: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  ),

                  subtitle: Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                  ),

                  trailing: Icon(
                    Icons.circle,
                    size: 10,
                    color: isOnline ? Colors.green : Colors.grey,
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PrivateChatScreen(
                          otherUid: uid,
                          otherName: name,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}