// why not User? cause it's already used in firebase case. So we use LocalUser
import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.profilePic,
    required this.bio,
    required this.points,
    required this.fullName,
    required this.groupIds,
    required this.enrolledCourseIds,
    required this.following,
    required this.followers,
  });

  LocalUser.empty() : this(
    uid:'',
    email:'',
    profilePic:'',
    bio:'',
    points:0,
    fullName:'',
    groupIds:[],
    enrolledCourseIds:[],
    following:[],
    followers:[],
  );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: $bio, '
        'points: $points, fullName: $fullName}';
  }
}