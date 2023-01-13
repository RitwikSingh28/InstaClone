class CustomUser {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  CustomUser(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.userName,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "uid": uid,
      "photoUrl": photoUrl,
      "bio": bio,
      "followers": followers,
      "following": following,
    };
  }
}
