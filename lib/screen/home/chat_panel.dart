import 'package:flutter/material.dart';
import 'world_chat_tab.dart';
import 'friends_chat_tab.dart';
import 'chat_dialog.dart';
import 'package:language_game/utils/platform_helper.dart'; // ✅ ADD NI

class ChatPanel extends StatefulWidget {
  const ChatPanel({super.key});

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  int selectedTab = 0;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isOpen ? 280 : 60,
      height: isOpen ? 400 : 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isOpen ? _expandedChat() : _collapsedButton(),
    );
  }

  // 🔘 COLLAPSED
  Widget _collapsedButton() {
    return Stack(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),

            onPressed: () {

              /// 🖥️ DESKTOP MODE → BLOCK FIREBASE
              if (PlatformHelper.isDesktop) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Chat"),
                    content: const Text(
                      "Chat is not available on desktop 💻\nUse Android for online chat.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
                return;
              }

              /// 📱 MOBILE → OPEN REAL CHAT
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Chat",
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) {
                  return const Center(
                    child: ChatDialog(),
                  );
                },
              );
            },
          ),
        ),

        // 🔴 DOT
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // 📦 EXPANDED CHAT
  Widget _expandedChat() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _tab("All", 0),
                _tab("Friends", 1),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => setState(() => isOpen = false),
            )
          ],
        ),

        const Divider(color: Colors.white24),

        Expanded(
          child: selectedTab == 0
              ? _safeWorld()
              : _safeFriends(),
        ),
      ],
    );
  }

  /// 🔒 SAFE WRAPPERS
  Widget _safeWorld() {
    if (PlatformHelper.isDesktop) {
      return const Center(
        child: Text(
          "Offline Mode 💻\nWorld chat unavailable",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return WorldChatTab();
  }

  Widget _safeFriends() {
    if (PlatformHelper.isDesktop) {
      return const Center(
        child: Text(
          "Offline Mode 💻\nFriends chat unavailable",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return FriendsChatTab();
  }

  Widget _tab(String title, int index) {
    final active = selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: active ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}