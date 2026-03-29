import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    if (UserSession.userId == null || UserSession.userId!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Login required")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text("Add Friends"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF020617),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('users').snapshots(),
          builder: (context, snapshot) {

            // 🧨 ERROR
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            // ⏳ LOADING
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final users = snapshot.data?.docs ?? [];

            if (users.isEmpty) {
              return const Center(
                child: Text(
                  "No users found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {

                final user = users[index];
                final data = user.data() as Map<String, dynamic>? ?? {};

                if (user.id == UserSession.userId) {
                  return const SizedBox();
                }

                final name = data['name']?.toString() ?? "No Name";
                final isOnline = data['online'] == true;

                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),

                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        name.isNotEmpty
                            ? name[0].toUpperCase()
                            : "?",
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

                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                      ),
                      child: const Text("Add"),

                      onPressed: () async {

                        final myId = UserSession.userId;

                        if (myId == null || myId.isEmpty) return;
                        if (user.id.isEmpty) return;

                        try {

                          await db.collection('users')
                              .doc(user.id)
                              .set({
                            'requests':
                                FieldValue.arrayUnion([myId])
                          }, SetOptions(merge: true));

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Request sent to $name")),
                          );

                        } catch (e) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}