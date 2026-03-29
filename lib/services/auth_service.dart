import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ================= REGISTER =================
  static Future<bool> registerUser(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final uid = user.uid;

      // 🔥 AUTO USERNAME GENERATOR
      final username = "Player_${uid.substring(0, 5)}";

      // 🔥 FULL USER DATA (FIXED)
      await _db.collection('users').doc(uid).set({
        'name': username,
        'level': 1,
        'xp': 0,
        'gamesPlayed': 0,
        'totalScore': 0,
        'gender': "male",
        'avatar': "default",
        'online': true,
        'friends': [],
        'requests': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.updateDisplayName(username);

      return true;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  /// ================= LOGIN =================
  static Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

  /// ================= GOOGLE LOGIN =================
  static Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);

      final user = userCred.user!;
      final uid = user.uid;

      final doc = await _db.collection('users').doc(uid).get();

      if (!doc.exists) {
        // 🔥 FIRST TIME GOOGLE USER
        final username =
            googleUser.displayName ?? "Player_${uid.substring(0, 5)}";

        await _db.collection('users').doc(uid).set({
          'name': username,
          'level': 1,
          'xp': 0,
          'gamesPlayed': 0,
          'totalScore': 0,
          'gender': "male",
          'avatar': "default",
          'online': true,
          'friends': [],
          'requests': [],
          'createdAt': FieldValue.serverTimestamp(),
        });

        await user.updateDisplayName(username);
      }

      return true;
    } catch (e) {
      print("GOOGLE LOGIN ERROR: $e");
      return false;
    }
  }

  /// ================= LOGOUT =================
  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  /// ================= CURRENT USER =================
  static Map<String, dynamic>? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;

    return {
      'uid': user.uid,
      'username': user.displayName ?? "Player",
      'email': user.email,
    };
  }
}