import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/utils/platform_helper.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ================= AUTH STREAM =================
  static Stream<User?> get authStateChanges {
    if (PlatformHelper.isDesktop) {
      return const Stream.empty(); // 🚫 no Firebase on desktop
    }
    return _auth.authStateChanges();
  }

  /// ================= REGISTER =================
  static Future<bool> registerUser(String email, String password) async {
    if (PlatformHelper.isDesktop) {
      print("Desktop mode: register skipped");
      return true;
    }

    try {
      await _auth.signOut();

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final uid = user.uid;

      final username = "Player_${uid.substring(0, 5)}";

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
      await _auth.currentUser?.reload();

      print("REGISTER SUCCESS UID: ${uid}");

      return true;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  /// ================= LOGIN =================
  static Future<bool> loginUser(String email, String password) async {
    if (PlatformHelper.isDesktop) {
      print("Desktop mode: login skipped");
      return true;
    }

    try {
      await _auth.signOut();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("LOGIN UID: ${_auth.currentUser?.uid}");

      return true;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

  /// ================= GOOGLE LOGIN =================
  static Future<bool> signInWithGoogle() async {
    if (PlatformHelper.isDesktop) {
      print("Desktop mode: Google login skipped");
      return true;
    }

    try {
      await _auth.signOut();

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

      await _auth.currentUser?.reload();

      print("GOOGLE LOGIN UID: $uid");

      return true;
    } catch (e) {
      print("GOOGLE LOGIN ERROR: $e");
      return false;
    }
  }

  /// ================= LOGOUT =================
  static Future<void> logout() async {
    if (PlatformHelper.isDesktop) {
      print("Desktop mode: logout skipped");
      return;
    }

    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  /// ================= CURRENT USER =================
  static User? get firebaseUser => _auth.currentUser;
  static String? get uid => _auth.currentUser?.uid;
}
