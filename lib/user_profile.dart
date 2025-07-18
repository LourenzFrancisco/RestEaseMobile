class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePicture;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
    );
  }
} 