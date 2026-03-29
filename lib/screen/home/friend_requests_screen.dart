import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class FriendRequestsScreen extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    if (UserSession.userId == null || UserSession.userId!.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("Login required"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text("Friend Requests"),
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

        child: StreamBuilder<DocumentSnapshot>(
          stream: db.collection('users')
              .doc(UserSession.userId)
              .snapshots(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final doc = snapshot.data!;
            final data = doc.data() as Map<String, dynamic>?;

            if (data == null || !data.containsKey('requests')) {
              return const Center(
                child: Text(
                  "No requests",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final List requests = (data['requests'] ?? [])
                .where((uid) =>
                    uid != null && uid.toString().isNotEmpty)
                .toList();

            if (requests.isEmpty) {
              return const Center(
                child: Text(
                  "No requests",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView(
              children: requests.map<Widget>((uid) {

                if (uid == null || uid.toString().isEmpty) {
                  return const SizedBox();
                }

                return FutureBuilder<DocumentSnapshot>(
                  future: db.collection('users').doc(uid).get(),
                  builder: (context, snap) {

                    if (!snap.hasData) {
                      return const SizedBox();
                    }

                    final userDoc = snap.data!;
                    final userData =
                        userDoc.data() as Map<String, dynamic>?;

                    if (userData == null) {
                      return const SizedBox();
                    }

                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),

                      child: ListTile(
                        title: Text(
                          userData['name'] ?? "Unknown",
                          style: const TextStyle(color: Colors.white),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            // ✅ ACCEPT
                            IconButton(
                              icon: const Icon(Icons.check,
                                  color: Colors.green),
                              onPressed: () async {

                                await db.collection('users')
                                    .doc(UserSession.userId)
                                    .update({
                                  'friends':
                                      FieldValue.arrayUnion([uid]),
                                  'requests':
                                      FieldValue.arrayRemove([uid]),
                                });

                                await db.collection('users')
                                    .doc(uid)
                                    .update({
                                  'friends': FieldValue.arrayUnion(
                                      [UserSession.userId])
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Friend added ✅")),
                                );
                              },
                            ),

                            // ❌ REJECT
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.red),
                              onPressed: () async {

                                await db.collection('users')
                                    .doc(UserSession.userId)
                                    .update({
                                  'requests':
                                      FieldValue.arrayRemove([uid]),
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Request removed ❌")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}