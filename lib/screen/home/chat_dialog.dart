import 'dart:ui';
import 'package:flutter/material.dart';
import 'world_chat_tab.dart';
import 'friends_chat_tab.dart';

class ChatDialog extends StatefulWidget {
  const ChatDialog({super.key});

  @override
  State<ChatDialog> createState() => _ChatDialogState();
}

class _ChatDialogState extends State<ChatDialog>
    with SingleTickerProviderStateMixin {
  int tab = 0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutBack,
        ),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 420,
            height: 520,
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _tab("World", 0),
                    _tab("Friends", 1),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                const Divider(color: Colors.white24),
                Expanded(
                  child: tab == 0 ? WorldChatTab() : FriendsChatTab(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(String title, int index) {
    final active = tab == index;

    return GestureDetector(
      onTap: () {
        setState(() => tab = index);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
