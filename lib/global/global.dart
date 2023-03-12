import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/user_model.dart';
import '../models/direction_details_info.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAW73J7Yc:APA91bEJ_3kJclnz3BHoxXEwPJkAxa1HpWXIZ3eRvYxZ8SYFbeGAWvlvnJPE4NVyMKdczGhykKpHOJB6-TRHqUdPLOoVE1bAkihlfuIy7vkZzLzRSi8fUBmjchunPFBafyR2aOM3YheS";
String userDropOffAddress = "";
String driverCarDetails ="";
String driverName ="";
String driverPhone ="";
double countRatingStars = 0.0;
String titleStarsRating = "";