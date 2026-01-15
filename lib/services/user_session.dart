class UserSession {
  // ✅ allow creating instance (para indi mag-error)
  UserSession();

  // ✅ guest by default
  static bool isGuest = true;

  // ✅ name shown in leaderboard / UI
  static String? displayName;

  // ✅ check if may pangalan na
  static bool get hasProfile =>
      displayName != null && displayName!.trim().isNotEmpty;

  // ✅ used by popup name dialog
  static void setProfileName(String name) {
    displayName = name.trim();
  }

  // ✅ login user
  static void login(String name) {
    isGuest = false;
    displayName = name.trim();
  }

  // ✅ guest user
  static void guest() {
    isGuest = true;
    displayName = null; // popup will ask name later
  }

  // ✅ optional logout
  static void logout() {
    isGuest = true;
    displayName = null;
  }
}
  