import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:users_app/global/global.dart';

class RateDriverScreen extends StatefulWidget {
String? assignedDriverId;

RateDriverScreen({this.assignedDriverId});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.white54,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22.0,),
              const Text(
                "Noter la course",
                style: TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 2,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 22.0,),
              const Divider(height: 4.0,thickness: 4.0,),
              const SizedBox(height: 22.0,),
              SmoothStarRating(
                rating: countRatingStars,
                allowHalfRating: false,
                starCount: 5,
                color: Colors.green,
                borderColor: Colors.green,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed)
                {
                 countRatingStars = valueOfStarsChoosed;
                 if(countRatingStars ==1)
                   {
                     setState(() {
                       titleStarsRating ="Trex mauvais";
                     });
                   }
                 if(countRatingStars ==2)
                 {
                   setState(() {
                     titleStarsRating ="Mauvais";
                   });
                 }
                 if(countRatingStars ==3)
                 {
                   setState(() {
                     titleStarsRating ="Bon";
                   });
                 }
                 if(countRatingStars ==4)
                 {
                   setState(() {
                     titleStarsRating ="Tres bon";
                   });
                 }
                 if(countRatingStars ==5)
                 {
                   setState(() {
                     titleStarsRating ="Excellent";
                   });
                 }
                },
              ),
              const SizedBox(height: 12.0,),
              Text(
                titleStarsRating,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12.0,),
              ElevatedButton(
                  onPressed: ()
                  {
                    DatabaseReference rateDriverRef = FirebaseDatabase.instance.ref()
                        .child("drivers")
                        .child(widget.assignedDriverId!)
                        .child("ratings");
                    rateDriverRef.once().then((snap) {
                      if(snap.snapshot.value == null)
                        {
                          rateDriverRef.set(countRatingStars.toString());
                          SystemNavigator.pop();
                        }
                      else
                        {
                          double pastRatings =double.parse(snap.snapshot.value.toString());
                          double newAverageRatings = (pastRatings + countRatingStars)/2;
                          rateDriverRef.set(newAverageRatings.toString());
                          SystemNavigator.pop();
                        }
                      Fluttertoast.showToast(msg: "Redemarrer l'applis");
                    });
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 74),
                ),
                  child: Text(
                    "Soumettre",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
              ),
              const SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}
